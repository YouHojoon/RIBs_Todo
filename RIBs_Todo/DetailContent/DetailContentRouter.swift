//
//  DetailContentRouter.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs

protocol DetailContentInteractable: Interactable {
    var router: DetailContentRouting? { get set }
    var listener: DetailContentListener? { get set }
}

protocol DetailContentViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class DetailContentRouter: ViewableRouter<DetailContentInteractable, DetailContentViewControllable>, DetailContentRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: DetailContentInteractable, viewController: DetailContentViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
