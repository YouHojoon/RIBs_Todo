//
//  RootViewController.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable, LoggedInViewControllable {

    weak var listener: RootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    func present(viewController: ViewControllable){
        self.present(viewController.uiviewController, animated: true, completion: nil)
    }
    
    func dismiss(viewController: ViewControllable){
        if viewController.uiviewController === presentedViewController {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
