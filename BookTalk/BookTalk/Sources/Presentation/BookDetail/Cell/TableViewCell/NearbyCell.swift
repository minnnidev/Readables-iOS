//
//  NearbyCell.swift
//  BookTalk
//
//  Created by RAFA on 8/2/24.
//

import UIKit

import SnapKit
import Then

final class NearbyCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private let mapView = UIView()
    private let distanceLabel = UILabel()
    private let nearbyInfoStackView = UIStackView()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set UI
    
    private func setViews() {
        titleLabel.do {
            $0.text = "대출 가능한 주변 도서관"
            $0.textColor = .black
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 25, weight: .bold)
        }
        
        mapView.do {
            $0.backgroundColor = .gray100
        }
        
        distanceLabel.do {
            $0.text = "성메 작은도서관 : 295m\n성산글마루 작은도서관 : 641m"
            $0.textColor = .black
            $0.textAlignment = .left
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 15, weight: .medium)
        }
        
        nearbyInfoStackView.do {
            $0.addArrangedSubview(titleLabel)
            $0.addArrangedSubview(mapView)
            $0.addArrangedSubview(distanceLabel)
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 10
        }
    }
    
    private func setConstraints() {
        contentView.addSubview(nearbyInfoStackView)
        
        mapView.snp.makeConstraints {
            $0.height.equalTo(mapView.snp.width)
        }
        
        nearbyInfoStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(15)
        }
    }
}
