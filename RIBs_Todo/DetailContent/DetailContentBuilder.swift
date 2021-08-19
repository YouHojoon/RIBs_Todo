//
//  DetailContentBuilder.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs

protocol DetailContentDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var memoStream: MemoStream { get }
}

final class DetailContentComponent: Component<DetailContentDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    fileprivate var memoStream: MemoStream {
        return self.dependency.memoStream
    }
}

// MARK: - Builder

protocol DetailContentBuildable: Buildable {
    func build(withListener listener: DetailContentListener) -> DetailContentRouting
}

final class DetailContentBuilder: Builder<DetailContentDependency>, DetailContentBuildable {

    override init(dependency: DetailContentDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DetailContentListener) -> DetailContentRouting {
        let component = DetailContentComponent(dependency: dependency)
        let viewController = DetailContentViewController()
        let interactor = DetailContentInteractor(presenter: viewController, memoStream: component.memoStream)
        interactor.listener = listener
        return DetailContentRouter(interactor: interactor, viewController: viewController)
    }
}
