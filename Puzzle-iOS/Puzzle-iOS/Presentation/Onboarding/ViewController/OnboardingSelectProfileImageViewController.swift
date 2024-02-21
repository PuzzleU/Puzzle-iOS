//
//  OnboardingSelectProfileImageViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/17/24.
//

import UIKit
import Combine

import SnapKit
import Then

final class OnboardingSelectProfileImageViewController: UIViewController {
    
    // MARK: - Properties
    private let rootView = OnboardingBaseView()
    
    private lazy var viewDidLoadPublisher = PassthroughSubject<Void, Never>()
    
    private var profileImageCollectionView = OnboardingCollectionView()
    private var viewModel: AnimalsViewModel
    private var cancelBag = CancelBag()
    
    // MARK: - UI Components
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("퍼즐에서 사용할 프로필을 선택해주세요")
    
    private let alertLabel = UILabel().then {
        let label = StringLiterals.Onboarding.selectAnimalProfile
        let specialCharacter = StringLiterals.Onboarding.selectAnimalProfileSpecial
        
        $0.highlightSpecialText(
            mainText: label,
            specialTexts: [specialCharacter],
            mainAttributes: [
                .font: UIFont.body3,
                .foregroundColor: UIColor.black
            ],
            specialAttributes: [
                .font: UIFont.body3,
                .foregroundColor: UIColor.puzzlePurple
            ]
        )
    }
    
    // MARK: - Life Cycles
    
    init(viewModel: AnimalsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setDelegate()
        setLayout()
        setNaviBindings()
        register()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - UI & Layout
    
    private func setHierarchy() {
        view.addSubviews(naviBar, alertLabel, profileImageCollectionView)
    }
    
    private func setLayout() {
        naviBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8 + 5)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        alertLabel.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(8)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(46)
        }
        
        profileImageCollectionView.snp.makeConstraints {
            $0.top.equalTo(alertLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.bottom.equalToSuperview().inset(227)
        }
    }
    
    private func register() {
        profileImageCollectionView.onboardingCollectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.className)
    }
    
    private func setDelegate() {
        profileImageCollectionView.onboardingCollectionView.delegate = self
        profileImageCollectionView.onboardingCollectionView.dataSource = self
    }
    
}

// MARK: - Methods

extension OnboardingSelectProfileImageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.animalImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.className, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell()}
        cell.bindData(with: viewModel.animalImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("OnboardingSelectProfileImageVC 의 \(indexPath.row) 터치 ")
    }
    
    private func setNaviBindings() {
        naviBar.resetLeftButtonAction({ [weak self] in
            self?.viewModel.backButtonTapped.send()
        }, .leftTitleWithLeftButton)
    }
    
    private func bindViewModel() {
        
        let input = AnimalsViewModel.Input(
            viewDidAppear: viewDidLoadPublisher.eraseToAnyPublisher()
        )
        
        let _ = viewModel.transform(from: input, cancelBag: cancelBag)
        
        viewDidLoadPublisher.send()
    }
}

