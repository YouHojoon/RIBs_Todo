//
//  LoggedInComponent+DetailContent.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import Foundation

extension LoggedInComponent: DetailContentDependency {
    var memoStream: MemoStream {
        return self.mutableMemoSteam
    }
}
