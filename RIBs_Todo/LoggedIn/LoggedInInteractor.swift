//
//  LoggedInInteractor.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs
import RxSwift

protocol LoggedInRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToDetailContent()
}

protocol LoggedInListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    
    init(mutableMemoStream: MutableMemoStream){
        self.mutableMemoStream = mutableMemoStream
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    func registeredTodo(title: String, detail: String) {
        self.router?.routeToDetailContent()
        self.mutableMemoStream.updateMemo(withMemo: .init(title: title, detail: detail))
    }
    
    private let mutableMemoStream: MutableMemoStream
}
