//
//  LoggedInRouter.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs

protocol LoggedInInteractable: Interactable, TodoListListener, DetailContentListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
    
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    
    init(interactor: LoggedInInteractable, viewController: LoggedInViewControllable,
         todoListBuilder: TodoListBuildable, detailContentBuilder: DetailContentBuildable) {
        self.viewController = viewController
        self.todoListBuilder = todoListBuilder
        self.detailContentBuilder = detailContentBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        attachTodoList()
    }
    
    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
        if let currentChild = currentChild{
            self.viewController.dismiss(viewController: currentChild.viewControllable)
            self.currentChild = nil
        }
    }
    
    func routeToDetailContent(){
        detachCurrentChild()
        let detailContent = self.detailContentBuilder.build(withListener: interactor)
        self.currentChild = detailContent
        self.attachChild(detailContent)
        self.viewController.present(viewController: detailContent.viewControllable)
    }
    // MARK: - Private

    private let viewController: LoggedInViewControllable
    private let todoListBuilder: TodoListBuildable
    private var currentChild: ViewableRouting?
    private let detailContentBuilder: DetailContentBuildable
    
    private func detachCurrentChild(){
        if let currentChild = self.currentChild{
            self.viewController.dismiss(viewController: currentChild.viewControllable)
            self.detachChild(currentChild)
        }
    }
    
    private func attachTodoList(){
        let todoList = self.todoListBuilder.build(withListener: self.interactor)
        self.currentChild = todoList
        self.attachChild(todoList)
        self.viewController.present(viewController: todoList.viewControllable)
    }
}
