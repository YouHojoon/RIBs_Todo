//
//  MemoStream.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import Foundation
import RxSwift
import RxCocoa

struct Memo {
    let title: String
    let detail: String
}

protocol MemoStream: AnyObject {
    var memo: Observable<Memo> { get }
}

protocol MutableMemoStream: MemoStream {
    func updateMemo(withMemo memo: Memo)
}

class MemoSteamImpl: MutableMemoStream {
    var memo: Observable<Memo> {
        return variable.asObservable()
    }
    func updateMemo(withMemo memo: Memo){
        let newMemo: Memo = .init(title: memo.title, detail: memo.detail)
        self.variable.accept(newMemo)
    }
    //MARK: - Private
    private let variable = BehaviorRelay<Memo>(value: Memo(title: "", detail: ""))
    
}
