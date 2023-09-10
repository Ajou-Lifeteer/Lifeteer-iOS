//
//  SecondDetailLandingPageVC.swift
//  Ajou-Lifeteer-iOS
//
//  Created by 몽이 누나 on 2023/07/27.
//

import UIKit

import SnapKit
import Then

final class SecondDetailLandingPageVC: UIViewController {
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "일기"
        $0.textColor = .appleBlack
        $0.font = .body1
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "오늘 하루는 어땠나요? 날씨, 감정,\n그리고 일상까지 쉽게 담아봐요."
        $0.numberOfLines = 2
        let attrString = NSMutableAttributedString(string: $0.text!, attributes: [.font: UIFont.body1, .foregroundColor: UIColor.disabled1])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 7
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        $0.attributedText = attrString
    }

    private let landingPageImageView = UIImageView().then {
        $0.image = ImageLiterals.diaryImgAlbum
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
    }
}

// MARK: - UI & Layout

extension SecondDetailLandingPageVC {
    private func setUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews(landingPageImageView, subTitleLabel, titleLabel)
        
        landingPageImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalToSuperview().inset(21)
            make.height.equalTo(landingPageImageView.snp.width).multipliedBy(1.14)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(56)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subTitleLabel.snp.top).offset(-13)
            make.centerX.equalToSuperview()
        }
    }
}
