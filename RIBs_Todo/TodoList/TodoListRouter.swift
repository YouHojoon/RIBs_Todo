//
//  TodoListRouter.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs

protocol TodoListInteractable: Interactable {
    var router: TodoListRouting? { get set }
    var listener: TodoListListener? { get set }
}

protocol TodoListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TodoListRouter: ViewableRouter<TodoListInteractable, TodoListViewControllable>, TodoListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TodoListInteractable, viewController: TodoListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
