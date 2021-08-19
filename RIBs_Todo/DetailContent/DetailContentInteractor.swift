//
//  DetailContentInteractor.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import RIBs
import RxSwift

protocol DetailContentRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DetailContentPresentable: Presentable {
    var listener: DetailContentPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func set(memo: Memo)
}

protocol DetailContentListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class DetailContentInteractor: PresentableInteractor<DetailContentPresentable>, DetailContentInteractable, DetailContentPresentableListener {

    weak var router: DetailContentRouting?
    weak var listener: DetailContentListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: DetailContentPresentable, memoStream: MemoStream){
        self.memoStream = memoStream
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        updateMemo()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    //MARK: - Private
    private let memoStream: MemoStream
    private func updateMemo() {
        self.memoStream.memo
            .subscribe(onNext: {self.presenter.set(memo: $0)})
            .disposeOnDeactivate(interactor: self)
    }
}
