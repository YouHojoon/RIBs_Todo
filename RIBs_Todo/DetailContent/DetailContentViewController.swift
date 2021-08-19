//
//  DetailContentViewController.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs
import RxSwift
import UIKit

protocol DetailContentPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class DetailContentViewController: UIViewController, DetailContentPresentable, DetailContentViewControllable {

    weak var listener: DetailContentPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
    }
    
    func set(memo: Memo) {
        print(memo)
    }
}
