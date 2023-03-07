//
//  Bank.swift
//  BankManagerConsoleApp
//
//  Created by Rowan, 릴라 on 2023/03/07.
//

final class Bank {
    private var bankers: [Banker] = []
    private var customerQueue: CustomerQueue<Customer> = CustomerQueue()
    private(set) var totalCustomer: Int = 10
    
    func open() {
        setBankers()
        receiveCustomer()
        orderWork()
    }

    private func setBankers() {
        let banker = Banker()

        bankers.append(banker)
    }
    
    private func receiveCustomer() {
        let customerRange: ClosedRange<Int> = 10...30
        totalCustomer = Int.random(in: customerRange)
        
        for number in 1...totalCustomer {
            let customer = Customer(numberTicket: number.description)
            customerQueue.enqueue(customer)
        }
    }
    
    private func orderWork() {
        while customerQueue.isEmpty == false {
            bankers.forEach { banker in
                let customer = customerQueue.dequeue()
                banker.doWork(for: customer)
            }
        }
    }
}
