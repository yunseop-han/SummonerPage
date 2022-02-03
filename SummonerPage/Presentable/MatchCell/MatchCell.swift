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
        $0.font = .systemFont(ofSize: 10, weight: .bold)
        $0.textColor = .white
        $0.paddingInsets = .init(top: 2, left: 4, bottom: 2, right: 4)
    }
    
    private var tileView = TileImageView()
    private var itemView = ItemListView()

    private let multiKillLabel = PaddingLabel().then {
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.darkishPink.cgColor
        $0.textColor = .darkishPink
        $0.font = .systemFont(ofSize: 10)
        $0.paddingInsets = .init(top: 4, left: 8, bottom: 3, right: 8)
    }
    private let KDALabel = UILabel().then {
        // TODO: - AttributeString
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    private let contributionRateLabel = UILabel().then {
        $0.textColor = .gunmetal
        $0.font = .systemFont(ofSize: 12)
    }
    
    private let typeLabel = UILabel().then {
        $0.textAlignment = .right
        $0.textColor = .coolGrey
        $0.font = .systemFont(ofSize: 12)
    }
    private let timeLabel = UILabel().then {
        $0.textAlignment = .right
        $0.textColor = .coolGrey
        $0.font = .systemFont(ofSize: 12)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        layer.makeShadow(color: .steelGrey.withAlphaComponent(0.1),
                         x: 0,
                         y: 4,
                         blur: 2,
                         spread: 0)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        tileView = .init()
        itemView = .init()
    }
    
    func setupConstraints() {
        contentView.addSubview(resultView)
        contentView.addSubview(championImageView)
        contentView.addSubview(MVPLabel)
        
        contentView.addSubview(tileView)
        
        contentView.addSubview(KDALabel)
        contentView.addSubview(contributionRateLabel)
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(timeLabel)
        
        contentView.addSubview(itemView)
        contentView.addSubview(multiKillLabel)

        
        
        resultView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.bottom.equalToSuperview()
            make.height.equalTo(104).priority(999)
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

        KDALabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(tileView.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualTo(typeLabel.snp.leading).offset(-8)
        }
        
        contributionRateLabel.snp.makeConstraints { make in
            make.top.equalTo(KDALabel.snp.bottom).offset(2)
            make.leading.trailing.equalTo(KDALabel)
        }

        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.trailing.equalToSuperview().inset(16)
        }

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(1)
            make.trailing.equalTo(typeLabel)
        }
        
        itemView.snp.makeConstraints { make in
            make.leading.equalTo(championImageView)
            make.top.equalTo(championImageView.snp.bottom).offset(8)
            make.width.equalTo(156)
            make.height.equalTo(24)
        }
        
        multiKillLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.leading.greaterThanOrEqualTo(itemView.snp.trailing).offset(8)
            make.centerY.equalTo(itemView)
            make.height.equalTo(20)
        }
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
                self?.championImageView.sd_setImage(with: $0)
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
            .map { $0.match }
            .bind(to: tileView.rx.match)
            .disposed(by: disposeBag)
     
        reactor.state
            .map { $0.match.stats.general }
            .map { "\($0.kill) / \($0.assist) / \($0.death)" }
            .bind(to: KDALabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.match.stats.general }
            .map { "킬관여 \($0.contributionForKillRate)" }
            .bind(to: contributionRateLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.match }
            .map { $0.gameType }
            .bind(to: typeLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.match.items }
            .bind(to: itemView.rx.items)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.match.stats.general.largestMultiKillString }
            .bind(to: multiKillLabel.rx.text)
            .disposed(by: disposeBag)
        
        // TODO: -
        if #available(iOS 13.0, *) {
            reactor.state
                .map { $0.match }
                .map {
                    
                    let date = Date(timeIntervalSince1970: .init($0.createDate))
                    let formatter = RelativeDateTimeFormatter()
                    formatter.dateTimeStyle = .named
                    
                    let dateString = formatter.localizedString(for: date, relativeTo: .init())
                    return dateString
                }
                .bind(to: timeLabel.rx.text)
                .disposed(by: disposeBag)
        } else {
            // Fallback on earlier versions
        }
    }
}
