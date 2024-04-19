//
//  PostView.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 4/19/24.
//

import UIKit

import SnapKit
import Then

final class PostView: UIView {
    
    // MARK: - UIComponents
    
    private let competitionSelectionView = PuzzleCustomView.makeInfoView(title: "공모전 선택")
    
    private let titleTextField = UITextField().then {
        $0.placeholder = "제목을 입력해주세요"
    }
    
    private let splitView = UIView().then {
        $0.backgroundColor = .puzzleGray300
    }
    
    private let recruitCountView = PuzzleCustomView.makeInfoView(title: "모집 인원 수", image: UIImage(resource: .icDoublePeople))
    private let selectionView = PuzzleCustomView.makeInfoView(title: "구인 포지션", image: UIImage(resource: .icWrench))
    
    private lazy var vStackView = UIStackView(
        arrangedSubviews: [
            competitionSelectionView,
            titleTextField,
            splitView,
            recruitCountView,
            selectionView,
            postTextView
        ]
    ).then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 1
    }
    
    let postTextView = UITextView().then {
        $0.font = .body2
        $0.text = "설명"
        $0.isEditable = true
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        let attributedString = NSMutableAttributedString(string: $0.text, attributes: [.font: UIFont.body2, .foregroundColor: UIColor.puzzleBlack])
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        $0.attributedText = attributedString
        $0.isScrollEnabled = false
        $0.sizeToFit()
        $0.backgroundColor = .lightGray
    }
    
    private lazy var postSaveButton = PuzzleMainButton(title: "항목 저장")
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        backgroundColor = .puzzleWhite
    }
    
    private func setHierarchy() {
        addSubview(vStackView)
    }
    
    private func setLayout() {
        vStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(21)
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        competitionSelectionView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        titleTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        splitView.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        recruitCountView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        selectionView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        postTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.greaterThanOrEqualTo(150)
        }

    }
    
}
