//
//  StatisticsMainVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/10.
//

import UIKit

import SnapKit
import Then

final class StatisticsMainVC: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .singleTitle).setTitle("통계")
    
    private lazy var statisticsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
        return collectionView
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        setDelegate()
        register()
    }
}

// MARK: - Methods

extension StatisticsMainVC {
    private func setDelegate() {
        self.statisticsCollectionView.dataSource = self
        self.statisticsCollectionView.delegate = self
    }
    
    private func register() {
        self.statisticsCollectionView.register(SelectMonthCVC.self,
                                               forCellWithReuseIdentifier: SelectMonthCVC.className)
        self.statisticsCollectionView.register(MonthlyKeywordAnalysisCVC.self,
                                               forCellWithReuseIdentifier: MonthlyKeywordAnalysisCVC.className)
        self.statisticsCollectionView.register(MonthlyEmotionAnalysisCVC.self,
                                               forCellWithReuseIdentifier: MonthlyEmotionAnalysisCVC.className)
        self.statisticsCollectionView.register(MissionPerformanceStatusCVC.self,
                                               forCellWithReuseIdentifier: MissionPerformanceStatusCVC.className)
    }
}

// MARK: - UI & Layout

extension StatisticsMainVC {
    private func setUI() {
        view.backgroundColor = .white
        self.statisticsCollectionView.backgroundColor = UIColor(hex: "#F6F8FF")
    }
    
    private func setLayout() {
        view.addSubviews(naviBar, statisticsCollectionView)
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(142)
        }
        
        statisticsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StatisticsMainVC: UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        let screenWidth = UIScreen.main.bounds.width
        
        switch section {
        case 0:
            return CGSize(width: screenWidth, height: 112)
        default:
            return CGSize(width: screenWidth, height: 250)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        return sectionInsets
    }
}

// MARK: - UICollectionViewDataSource

extension StatisticsMainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectMonthCVC.className, for: indexPath) as? SelectMonthCVC else { return UICollectionViewCell()}
            cell.didSelectMonthButton = { [weak self] in
                let datePickerPopUpVC = CustomDatePickerPopUpVC(title: "월 선택")
                datePickerPopUpVC.modalPresentationStyle = .overFullScreen
                self?.present(datePickerPopUpVC, animated: false)
                // 클로저 설정
                datePickerPopUpVC.setCompletionClosure { selectedDate in
                    let yearSubstring = ToMETimeFormatter.getYearToString(date: selectedDate)
                    let monthSubstring = ToMETimeFormatter.getMonthToString(date: selectedDate)
                    
                    cell.setTitleLabel(year: String(yearSubstring), month: String(monthSubstring))
                }
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthlyKeywordAnalysisCVC.className, for: indexPath) as? MonthlyKeywordAnalysisCVC else { return UICollectionViewCell()}
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthlyEmotionAnalysisCVC.className, for: indexPath) as? MonthlyEmotionAnalysisCVC else { return UICollectionViewCell()}
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MissionPerformanceStatusCVC.className, for: indexPath) as? MissionPerformanceStatusCVC else { return UICollectionViewCell()}
            return cell
        }
    }
}
