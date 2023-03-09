//
//  Banker.swift
//  BankManagerConsoleApp
//
//  Created by Rowan, 릴라 on 2023/03/07.
//

import Foundation

// DispatchQueue 추가
struct Banker {
//    let department: Business
//    let workQueue = DispatchQueue(label: "workQueue")
    
    func work(for customer: Customer?) {
        guard let currentCustomer = customer else { return }
        
        let startMessage = "\(currentCustomer.numberTicket)번 고객 \(currentCustomer.business.rawValue) 업무 시작"
        let endMessage = "\(currentCustomer.numberTicket)번 고객 \(currentCustomer.business.rawValue) 업무 완료"
        
        print(startMessage)
        Thread.sleep(forTimeInterval: currentCustomer.business.processTime)
        print(endMessage)
    }
}
