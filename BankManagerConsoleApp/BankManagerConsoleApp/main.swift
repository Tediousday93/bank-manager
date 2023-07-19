//
//  BankManagerConsoleApp - main.swift
//  Created by Rowan, 릴라. 
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

let customerQueue = CustomerQueue()
let loanDepartment = BankDepartment(workableBankerCount: 1)
let depositDepartment = BankDepartment(workableBankerCount: 2)
let bank = Bank(loanDepartment: loanDepartment,
                depositDepartment: depositDepartment,
                customerQueue: customerQueue)
let customerReceiver = CustomerReceiver()
var bankManager = BankManager(bank: bank, customerReceiver: customerReceiver)

let runLoop = CFRunLoopGetCurrent()

func stopRunLoop() {
    CFRunLoopStop(runLoop)
}

bankManager.addObserver()
bankManager.start(completionHandler: stopRunLoop)
CFRunLoopRun()
