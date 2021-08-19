//
//  LoggedInBuilder.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs

protocol LoggedInDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var LoggedInViewController: LoggedInViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
    
    /*
        Paraent의 Component에 있는 값을 전달받고 싶을 때 작성
        여기선 Root
     */
}

final class LoggedInComponent: Component<LoggedInDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var LoggedInViewController: LoggedInViewControllable {
        return dependency.LoggedInViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    /*
        Parent의 Componet에 존재하지 않는 값을 받고 싶기 때문에
        email, password를 Componet에 작성
     */
    let email: String?
    let password: String?
    var mutableMemoSteam: MutableMemoStream {
        return shared{ MemoSteamImpl() }
    }
    
    init(dependency: LoggedInDependency, email: String?, password: String?) {
        self.email = email
        self.password = password
        super.init(dependency: dependency)
    }
    
}

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener, email: String?, password: String?) -> LoggedInRouting
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LoggedInListener, email: String?, password: String?) -> LoggedInRouting {
        let component = LoggedInComponent(dependency: dependency, email: email, password: password)
        let interactor = LoggedInInteractor(mutableMemoStream: component.mutableMemoSteam)
        let todoListBuilder = TodoListBuilder(dependency: component)
        let detailBuilder = DetailContentBuilder(dependency: component)
        
        interactor.listener = listener
        
        return LoggedInRouter(interactor: interactor, viewController: component.LoggedInViewController, todoListBuilder: todoListBuilder, detailContentBuilder: detailBuilder)
    }
}
