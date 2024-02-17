//
//  OnboardingSignUpIdVC.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 2/15/24.
//

import UIKit

class OnboardingSignUpIdVC: UIViewController {
    
    // MARK: - Properties
    
    private let rootView = OnboardingBaseView()
    
    private var viewModel: OnboardingViewModel
    private var cancelBag = CancelBag()
    
    
    // MARK: - UI Conponents
    private lazy var naviBar = PuzzleNavigationBar(self, type: .leftTitleWithLeftButton).setTitle("퍼즐에서 사용할 아이디를 입력해주세요")
    
    private let inputId = UITextField().then {
        // 플레이스홀더 설정
        $0.attributedPlaceholder = NSAttributedString(
            string: "아이디를 입력해주세요. (최대 20자)",
            attributes: [
                .font: UIFont.body3,  // 폰트 설정
                .foregroundColor: UIColor.puzzleLightGray  // 색상 설정
            ]
        )
        
        // 텍스트 필드 입력 값 스타일
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.puzzleLightGray.cgColor
        $0.font = .body2
        $0.textColor = .black
        
        // "@" 레이블 생성
        let atSymbolLabel = UILabel()
        atSymbolLabel.text = "@"
        atSymbolLabel.font = .body3
        atSymbolLabel.textColor = .black
        
        // "@"를 포함할 컨테이너 뷰 생성
        let containerView = UIView()
        containerView.addSubview(atSymbolLabel)
        
        atSymbolLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(11)  // 컨테이너 뷰 내에서 "@" 왼쪽에 11의 패딩
            make.trailing.equalToSuperview().offset(-11)  // "@"와 플레이스홀더 사이에 11의 패딩
        }
        
        // 컨테이너 뷰의 크기를 레이블과 패딩에 맞게 조절
        let containerWidth = atSymbolLabel.intrinsicContentSize.width + 22  // 왼쪽과 오른쪽 패딩을 포함
        let containerHeight = atSymbolLabel.intrinsicContentSize.height
        containerView.frame = CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight)
        
        // leftView로 컨테이너 뷰 설정
        $0.leftView = containerView
        $0.leftViewMode = .always
    }
    
    
    
    private let recommededLabel = UILabel().then {
        
        let label = "인스타그램 아이디를 사용하면 친구들이 찾기 쉬워요!"
        
        let specialCharacter = "인스타그램 아이디"
        let specialCharacterRange = (specialCharacter as NSString).range(of: specialCharacter)
        
        let attributeLabel = NSMutableAttributedString(
            string: label,
            attributes: [
                .font: UIFont.subTitle3,
                .foregroundColor: UIColor.black
            ]
        )
        
        // 특정 문자에만 다른 폰트와 색상 적용하는 코드 입니다.
        attributeLabel.addAttributes([
            .font: UIFont.subTitle3,
            .foregroundColor: UIColor.puzzlePurple
        ], range: specialCharacterRange)
        
        $0.attributedText = attributeLabel
        
    }
    
    // MARK: - Life Cycles
    
    init(viewModel: OnboardingViewModel) {
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
        setUI()
        setLayout()
        setBindings()
        setupNaviBindings()
    }
    
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.addSubviews(naviBar, inputId, recommededLabel)
    }
    private func setLayout() {
        
        naviBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8 + 5)
            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        inputId.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(28)
            $0.height.equalTo(32)
        }
        
        recommededLabel.snp.makeConstraints {
            $0.top.equalTo(inputId.snp.bottom).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(28)
        }
    }
    
    private func setBindings() {
        
        inputId.textPublisher
            .print()
            .receive(on: DispatchQueue.main)
            .assign(to: \.userId, on: viewModel)
            .store(in: cancelBag)
    }
    
}


// MARK: - Methods

extension OnboardingSignUpIdVC {
    private func setupNaviBindings() {
        naviBar.resetLeftButtonAction({ [weak self] in
            self?.viewModel.backButtonTapped.send()
        }, .leftTitleWithLeftButton)
    }
}
