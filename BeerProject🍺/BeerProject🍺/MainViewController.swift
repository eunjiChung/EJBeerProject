//
//  MainViewController.swift
//  BeerProject🍺
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 17/07/2019.
//  Copyright © 2019 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then


protocol MainViewBindable {
    typealias Tab = MainViewController.Tab // MainVC.Tab 타입을 Tab이라고 선언하는 것 = typealias / 사용자 정의 유형
    var beerListViewModel: BeerListViewBindable { get }
//    var singleBeerViewModel: SingleBeerViewBindable { get }
//    var randomBeerViewModel: RandomBeerViewBindable { get }
}

class MainViewController: UITabBarController {
    let disposeBag = DisposeBag()
    
    enum Tab: Int {
        case beerList
        case singleBeer
        case randomBeer
    }
    
    let beerListVC = BeerListViewController()
    let singleBeerVC = SingleBeerViewController()
    let randomBeerVC = RandomBeerViewController()
    
    let tabBarItems : [Tab: UITabBarItem] = [
        .beerList : UITabBarItem(title: "맥주리스트", image: UIImage.init(named: "Multiple Beers"), selectedImage: UIImage.init(named: "Multiple Beers")),
        .singleBeer : UITabBarItem(title: "ID 검색", image: UIImage.init(named: "Single Beer"), selectedImage: UIImage.init(named: "Single Beer")),
        .randomBeer : UITabBarItem(title: "아무거나 검색", image: UIImage.init(named: "Single Beer with Bubble"), selectedImage: UIImage.init(named: "Single Beer with Bubble"))
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MainViewController")
        attribute()
    }
    
    func bind(_ viewModel: MainViewBindable) {
        
    }
    
    func attribute() {
        self.do {
            beerListVC.tabBarItem = tabBarItems[.beerList]
            singleBeerVC.tabBarItem = tabBarItems[.singleBeer]
            randomBeerVC.tabBarItem = tabBarItems[.randomBeer]
            
            $0.viewControllers = [
                UINavigationController(rootViewController: beerListVC),
                UINavigationController(rootViewController: singleBeerVC),
                UINavigationController(rootViewController: randomBeerVC)
            ]
        }
        
        view.do {
            $0.backgroundColor = .white
        }
    }
    
    
    
}
