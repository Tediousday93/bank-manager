//
//  BankManagerConsoleApp - main.swift
//  Created by Rowan, 릴라. 
//  Copyright © yagom academy. All rights reserved.
//

let customerQueue = CustomerQueue<Customer>()
let bank = Bank(loanBankerCount: 1, depositBankerCount: 2, customerQueue: customerQueue)
var bankManager = BankManager(bank: bank)

bankManager.start()
