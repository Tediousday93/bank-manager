//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Rowan, 릴라 on 2023/03/07.
//
import Foundation

final class Bank {
    private var depositCustomerQueue: CustomerQueue<Customer> = CustomerQueue()
    private var loanCustomerQueue: CustomerQueue<Customer> = CustomerQueue()
    private var customerQueue = CustomerQueue<Customer>()
    private let banker = Banker()
    private let loanBankerCount: Int
    private let depositBankerCount: Int
    private(set) var totalCustomer: Int = 0
    
    init(loanBankerCount: Int, depositBankerCount: Int) {
        self.loanBankerCount = loanBankerCount
        self.depositBankerCount = depositBankerCount
    }
    
    func open() {
        receiveCustomer()
        orderWork()
    }
    
    private func receiveCustomer() {
        let customerRange: ClosedRange<Int> = 10...30
        totalCustomer = Int.random(in: customerRange)
        
        for number in 1...totalCustomer {
            guard let business = Business.allCases.randomElement() else { return }
            let numberTicket = String(describing: number)
            let customer = Customer(numberTicket: numberTicket, business: business)
            customerQueue.enqueue(customer)
            
            switch customer.business {
            case .loan:
                loanCustomerQueue.enqueue(customer)
            case .deposit:
                depositCustomerQueue.enqueue(customer)
            }
        }
    }
    
    // 동시성 추가
    private func orderWork() {
        let workGroup = DispatchGroup()
        let workQueue = DispatchQueue(label: "workQueue", attributes: .concurrent)
        let depositSemaphore = DispatchSemaphore(value: self.depositBankerCount)
        let loanSemaphore = DispatchSemaphore(value: self.loanBankerCount)
        let startTime = CFAbsoluteTimeGetCurrent()
        
        while customerQueue.isEmpty == false {
            guard let customer = customerQueue.dequeue() else { return }
            let currentBusiness = customer.business
            
            switch currentBusiness {
            case .deposit:
                workQueue.async(group: workGroup) {
                    depositSemaphore.wait()
                    self.doWork(for: customer)
                    depositSemaphore.signal()
                }
            case .loan:
                workQueue.async(group: workGroup) {
                    loanSemaphore.wait()
                    self.doWork(for: customer)
                    loanSemaphore.signal()
                }
            }
        }
        
        workGroup.wait()
        
        let processTime = CFAbsoluteTimeGetCurrent() - startTime
        
        let roundedProcessTime = round(processTime * 100) / 100
        reportResult(processTime: roundedProcessTime)
        
//        let loanWorkItem = DispatchWorkItem {
//            while self.loanCustomerQueue.isEmpty == false {
//                self.loanBankers.forEach { banker in
//                    let customer = self.loanCustomerQueue.dequeue()
//                    banker.workQueue.async(group: workGroup) {
//                        banker .doWork(for: customer)
//                    }
//                }
//            }
//        }
//        
//        let depositWorkItem = DispatchWorkItem {
//            while self.depositCustomerQueue.isEmpty == false {
//                self.depositBankers.forEach{ banker in
//                    let customer = self.depositCustomerQueue.dequeue()
//                    banker.workQueue.async(group: workGroup) {
//                        banker.doWork(for: customer)
//                    }
//                }
//            }
//        }
        
        
        
//        DispatchQueue.global().async(group: workGroup, execute: loanWorkItem)
//        DispatchQueue.global().async(group: workGroup, execute: depositWorkItem)
            
        
        
        
        
    }
    
    // processTime 수정
    func reportResult(processTime: CFAbsoluteTime) {
        let message = "업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(totalCustomer)명이며, 총 업무시간은 \(processTime)초 입니다."
        print(message)
    }
    
    private func doWork(for customer: Customer?) {
        guard let currentCustomer = customer else { return }
        
        let startMessage = "\(currentCustomer.numberTicket)번 고객 \(currentCustomer.business.rawValue) 업무 시작"
        let endMessage = "\(currentCustomer.numberTicket)번 고객 \(currentCustomer.business.rawValue) 업무 완료"
        
        print(startMessage)
        Thread.sleep(forTimeInterval: currentCustomer.business.processTime)
        print(endMessage)
    }
}
