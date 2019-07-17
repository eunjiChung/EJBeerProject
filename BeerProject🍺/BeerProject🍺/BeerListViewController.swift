//
//  BeerListViewController.swift
//  BeerProject🍺
//
//  Created by CHUNGEUNJI on 17/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit


protocol BeerListViewBindable {
    // Subject는 Observer, Observable 둘 다 될 수 있다
    /*
     1. PublishSubject : 새로운 이벤트를 모든 observer들에게 전파할 수 있다
     2. BehaviorSubject : 초기값 혹은 마지막 이벤트를 emit
     3. RelaySubject : 미리 정해진 사이즈만큼 가장 최근 이벤트를 새로운 Subscriber에게 전달
     */
    var viewWillAppear: PublishSubject<Void> { get }  // PublishSubject는 RxSwift 객체, 동작 하나하나에 대한 액션 처리...?
    var itemSelected: PublishRelay<Int> { get }
    var willDisplayCell: PublishRelay<IndexPath> { get }
    var cellData: Driver<[BeerListCell.Data]> { get }
    var reloadList: Signal<Void> { get }
    var errorMessage: Signal<String> { get }
}

class BeerListViewController: UIViewController {
    let disposeBag = DisposeBag()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    func bind(_ viewModel: BeerListViewBindable) {
//        self.rx.viewWillAppear
//            .map { _ in Void() }
//            .bind(to: viewModel.viewWillAppear)
//            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { $0.row } // 테이블에서 선택된 아이템의 행을 리턴
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
        
        
        
    }
    
    func attribute() {
        title = "맥주리스트" // 이게 뭐의 타이틀인지 어떻게 알아...? 얘가 탭뷰 속성이라...?
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Then을 쓰지도 않았는데...?
        // UITabItem이라서 자동 상속?
        tableView.do {
            $0.backgroundView = UIView()
            $0.backgroundView?.isHidden = true
            $0.backgroundColor = .white
            $0.register(BeerListCell.self, forCellReuseIdentifier: String(describing: BeerListCell.self))
            $0.separatorStyle = .singleLine
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 160
        }
    }
    
    
    // 뷰들의 구조를 조절
    func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
