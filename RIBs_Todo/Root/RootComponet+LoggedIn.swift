//
//  RootComponet+LoggedIn.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import Foundation

extension RootComponent: LoggedInDependency{
    var LoggedInViewController: LoggedInViewControllable {
        return self.rootViewController
    }
}
