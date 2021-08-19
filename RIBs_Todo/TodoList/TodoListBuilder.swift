//
//  TodoListBuilder.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs

protocol TodoListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var inputEmail: String { get }
    var inputPassword: String { get }
}

final class TodoListComponent: Component<TodoListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    fileprivate var email: String {
        return self.dependency.inputEmail
    }
    
    fileprivate var password: String {
        return self.dependency.inputPassword
    }
}

// MARK: - Builder

protocol TodoListBuildable: Buildable {
    func build(withListener listener: TodoListListener) -> TodoListRouting
}

final class TodoListBuilder: Builder<TodoListDependency>, TodoListBuildable {

    override init(dependency: TodoListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TodoListListener) -> TodoListRouting {
        let component = TodoListComponent(dependency: dependency)
        let viewController = TodoListViewController(email: component.email, password: component.password)
        let interactor = TodoListInteractor(presenter: viewController)
        interactor.listener = listener
        return TodoListRouter(interactor: interactor, viewController: viewController)
    }
}
