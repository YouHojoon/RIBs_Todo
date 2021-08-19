//
//  LoggedInComponet+TodoList.swift
//  RIBs_Todo
//
//  Created by 유호준 on 2021/08/19.
//

import Foundation

extension LoggedInComponent: TodoListDependency{
    
    var inputEmail: String {
        return self.email ?? ""
    }
    
    var inputPassword: String {
        return self.password ?? ""
    }
}
