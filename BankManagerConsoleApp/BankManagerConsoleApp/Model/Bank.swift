//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by 김성준 on 2023/03/07.
//

import Foundation

struct Bank {
    let bankers: [Banker]
    var customerQueue: CustomerQueue<Customer> = CustomerQueue()
    
    func open() {
        
    }
    ///Todo
    ///1. 뱅커한테 일시키기
    ///2. 고객 받기
}