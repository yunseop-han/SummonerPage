//
//  MatchCell.swift
//  SummonerPage
//
//  Created by 한윤섭 on 2022/02/03.
//

import UIKit
import Then
import SnapKit
import ReactorKit
import RxSwift
import RxCocoa
import SDWebImage

class MatchCell: UITableViewCell, View {
    typealias Reactor = MatchCellReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let resultView = ResultView()
    private let championImageView = RoundImageView()
    private let MVPLabel = PaddingLabel().then {
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.font = .systemFont10Bold
        $0.textColor = .white
        $0.paddingInsets = .init(top: 2, left: 4, bottom: 2, right: 4)
    }
    
    private let tileView = TileImageView()
    private let generalView = GeneralView()
    
    private let leadingView = LeadingView()
    private let itemView = ItemListView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        let shadowColor: UIColor = .steelGrey.withAlphaComponent(0.1)
        layer.makeShadow(color: shadowColor, x: 0, y: 4, blur: 2, spread: 0)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        championImageView.image = nil
    }
    
    func bind(reactor: MatchCellReactor) {

        reactor.state
            .map { $0.match }
            .bind(to: resultView.rx.match)
            .disposed(by: disposeBag)

        reactor.state
            .map { $0.match.champion.imageUrl }
            .map { URL(string: $0) }
            .bind { [weak self] in
                self?.championImageView.sd_setImage(with: $0, placeholderImage: .from(color: .red))
            }.disposed(by: disposeBag)

        reactor.state
            .map { $0.match.stats.general.opScoreBadge.rawValue }
            .bind(to: MVPLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.match.stats.general.opScoreBadge }
            .map { $0 == .ace ? .periwinkle : .orangeYellow }
            .bind(to: MVPLabel.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { state -> [[String]] in
                let spell = state.match.spells.map { $0.imageUrl }
                let peak = state.match.peak
                return [spell, peak]
            }
            .bind(to: tileView.rx.imageUrls)
            .disposed(by: disposeBag)
     
        reactor.state
            .map { $0.match.stats.general }
            .bind(to: generalView.rx.general)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.match }
            .bind(to: leadingView.rx.match)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.match.items }
            .bind(to: itemView.rx.items)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        contentView.addSubview(resultView)
        
        contentView.addSubview(championImageView)
        contentView.addSubview(MVPLabel)
        
        contentView.addSubview(tileView)
        
        contentView.addSubview(generalView)
        
        contentView.addSubview(itemView)

        contentView.addSubview(leadingView)

        
        
        resultView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(40)
        }
        
        championImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(resultView).offset(16)
            make.leading.equalTo(resultView.snp.trailing).offset(16)
        }
        
        MVPLabel.snp.makeConstraints { make in
            make.centerX.equalTo(championImageView)
            make.top.equalTo(championImageView).offset(30)
        }
        
        tileView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(championImageView)
            make.leading.equalTo(championImageView.snp.trailing).offset(4)
        }

        generalView.snp.makeConstraints { make in
            make.top.bottom.equalTo(tileView)
            make.leading.equalTo(tileView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(itemView.snp.trailing)
        }
        
        itemView.snp.makeConstraints { make in
            make.leading.equalTo(championImageView)
            make.top.equalTo(championImageView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(16)
            make.width.equalTo(180)
            make.height.equalTo(24)
        }
        
        leadingView.snp.makeConstraints { make in
            make.leading.equalTo(itemView.snp.trailing).offset(8)
            make.top.bottom.trailing.equalToSuperview().inset(16)
        }
    }
}
