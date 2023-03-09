//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Rowan, 릴라 on 2023/03/07.
//
import Foundation

final class Bank {
    private var customerQueue = CustomerQueue<Customer>()
    private let banker = Banker()
    private(set) var totalCustomer: Int = 0
    private let workGroup = DispatchGroup()
    private let workQueue = DispatchQueue(label: "workQueue", attributes: .concurrent)
    private let depositSemaphore: DispatchSemaphore
    private let loanSemaphore: DispatchSemaphore
    
    init(loanBankerCount: Int, depositBankerCount: Int) {
        self.loanSemaphore = DispatchSemaphore(value: loanBankerCount)
        self.depositSemaphore = DispatchSemaphore(value: depositBankerCount)
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
        }
    }
    
    private func orderWork() {
        let startTime = CFAbsoluteTimeGetCurrent()
        
        while customerQueue.isEmpty == false {
            guard let customer = customerQueue.dequeue() else { return }
            let currentBusiness = customer.business
            treat(business: currentBusiness, for: customer)
        }
        
        workGroup.wait()
        
        let processTime = CFAbsoluteTimeGetCurrent() - startTime
        let roundedProcessTime = round(processTime * 100) / 100
        reportResult(processTime: roundedProcessTime)
    }
    
    private func treat(business: Business, for customer: Customer) {
        switch business {
        case .deposit:
            workQueue.async(group: workGroup) {
                self.depositSemaphore.wait()
                self.banker.work(for: customer)
                self.depositSemaphore.signal()
            }
        case .loan:
            workQueue.async(group: workGroup) {
                self.loanSemaphore.wait()
                self.banker.work(for: customer)
                self.loanSemaphore.signal()
            }
        }
    }
    
    private func reportResult(processTime: CFAbsoluteTime) {
        let message = "업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(totalCustomer)명이며, 총 업무시간은 \(processTime)초 입니다."
        print(message)
    }
}
