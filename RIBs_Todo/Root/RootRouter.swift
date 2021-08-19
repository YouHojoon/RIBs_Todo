//
//  RootRouter.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs

protocol RootInteractable:  Interactable,LoggedOutListener, LoggedInListener{
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    init(interactor: RootInteractable, viewController: RootViewControllable, loggedOutBuilder: LoggedOutBuildable, loggedInBuilder: LoggedInBuildable){
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        routeToLoggedOut()
    }
    
    func routeToLoggedIn(email: String?, password: String?) {
        if let loggedOut = self.loggedOut{
            self.viewController.dismiss(viewController: loggedOut.viewControllable)
            self.detachChild(loggedOut)
            self.loggedOut = nil
        }
        
        let loggedIn = self.loggedInBuilder.build(withListener: interactor, email: email, password: password)
        self.attachChild(loggedIn)
    }
    
    //MARK: - Private
    
    private let loggedInBuilder: LoggedInBuildable
    private let loggedOutBuilder: LoggedOutBuildable
    private var loggedOut: ViewableRouting?
    

    private func routeToLoggedOut() {
        let loggedOut = self.loggedOutBuilder.build(withListener: self.interactor)
        self.loggedOut = loggedOut
        
        attachChild(loggedOut)
        self.viewController.present(viewController: loggedOut.viewControllable)
    }
}
