//
//  HomeViewController.swift
//  Puzzle-iOS
//
//  Created by 이명진 on 3/2/24.
//

import UIKit
import Combine

import Then
import SnapKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let logoView = LogoView()
    private let titleView = TitleView()
    private let keywordView = KeywordView()
    private let resultView = ResultView()
    private let mainView = MainView()
    
    private let homeHeight: Int = 40
    
    // MARK: - UIComponents
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            titleView,
            keywordView,
            resultView,
            mainView
        ])
        
        stackView.axis = .vertical
        return stackView
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .puzzleWhite
    }
    
    private func setHierarchy() {
        view.addSubview(vStackView)
    }
    
    private func setLayout() {
        vStackView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        logoView.snp.makeConstraints {
            $0.height.equalTo(homeHeight)
        }
        
        titleView.snp.makeConstraints {
            $0.height.equalTo(homeHeight)
        }
        
        keywordView.snp.makeConstraints {
            $0.height.equalTo(homeHeight)
        }
        
        resultView.snp.makeConstraints {
            $0.height.equalTo(homeHeight)
        }
        
        mainView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
        }
    }
}
