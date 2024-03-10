//
//  MyProfileViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/8/24.
//

import UIKit

import SnapKit
import Then

enum ProfileSection: Int, CaseIterable {
    case profile
    case separator1
    case dashedLineExperience
    case dashedLineWorkExperience
    case separator2
    case dashedLineSkillSet
    case separator3
    case dashedLineEducation
    
    var cellIdentifier: String {
        switch self {
        case .profile:
            return MyProfileCell.className
        case .separator1, .separator2, .separator3:
            return EmptyCell.className
        case .dashedLineExperience, .dashedLineWorkExperience, .dashedLineSkillSet, .dashedLineEducation:
            return DashedLineCollectionViewCell.className
        }
    }
    
    var cellHeight: CGFloat {
        switch self {
        case .profile:
            return 329
        case .separator1, .separator2, .separator3:
            return 23
        case .dashedLineExperience, .dashedLineWorkExperience, .dashedLineSkillSet, .dashedLineEducation:
            return 114
        }
    }
}

final class MyProfileViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private let profileView = MyProfileView()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setRegister()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .puzzleWhite
        profileView.logoView.changeTrailingImageComponent(image: UIImage(resource: .icSetting))
    }
    
    private func setHierarchy() {
        view.addSubview(profileView)
    }
    
    private func setLayout() {
        profileView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setDelegate() {
        profileView.profileCollectionView.dataSource = self
        profileView.profileCollectionView.delegate = self
    }
    
    private func setRegister() {
        profileView.profileCollectionView.register(MyProfileCell.self, forCellWithReuseIdentifier: MyProfileCell.className)
        profileView.profileCollectionView.register(EmptyCell.self, forCellWithReuseIdentifier: EmptyCell.className)
        profileView.profileCollectionView.register(DashedLineCollectionViewCell.self, forCellWithReuseIdentifier: DashedLineCollectionViewCell.className)
        
    }
}

// MARK: - UICollectionViewDataSource

extension MyProfileViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ProfileSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = ProfileSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: section.cellIdentifier, for: indexPath)
        
        switch section {
        case .dashedLineExperience:
            (cell as? DashedLineCollectionViewCell)?.bindData(title: "🥇 대표경험", content: "+ 대표경험 서술")
        case .dashedLineWorkExperience:
            (cell as? DashedLineCollectionViewCell)?.bindData(title: "💼 경험 했어요", content: "+ 경력 입력")
        case .dashedLineSkillSet:
            (cell as? DashedLineCollectionViewCell)?.bindData(title: "📌 스킬 셋", content: "+ 전문분야·스킬 등록 ")
        case .dashedLineEducation:
            (cell as? DashedLineCollectionViewCell)?.bindData(title: "🎓 학력", content: "+ 학교, 전공, 기간 등 입력")
        default:
            break
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MyProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        guard let section = ProfileSection(rawValue: indexPath.section) else { return CGSize(width: 0, height: 0) }
        
        return CGSize(width: screenWidth, height: section.cellHeight)
    }
}
