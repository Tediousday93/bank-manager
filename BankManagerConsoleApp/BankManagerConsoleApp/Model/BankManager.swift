//
//  BankManager.swift
//  Created by Rowan, 릴라.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

final class BankManager {
    private let bank: Openable
    private var customerReceiver: Receivable
    
    init(bank: Openable, customerReceiver: Receivable) {
        self.bank = bank
        self.customerReceiver = customerReceiver
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(start),
            name: Notification.Name.bankClosed,
            object: nil
        )
    }
    
    @objc
    func start(completionHandler: @escaping () -> Void) {
        printMenu()
        guard let userInput = readInput() else { return }
        handleMenuInput(userInput, onCompleted: completionHandler)
    }
    
    private func printMenu() {
        let menuText = """
            1 : 은행 개점
            2 : 종료
            입력 :
            """
        
        print(menuText, terminator: " ")
    }
    
    private func readInput() -> String? {
        let userInput = readLine()
        
        return userInput
    }
    
    private func handleMenuInput(_ userInput: String, onCompleted: @escaping () -> Void) {
        switch userInput {
        case "1":
            let totalCustomer = customerReceiver.receiveCustomer()
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                bank.open(totalCustomer: totalCustomer)
                NotificationCenter.default.post(name: NSNotification.Name.bankClosed, object: nil)
            }
        case "2":
            DispatchQueue.main.async {
                onCompleted()
            }
            return
        default:
            let message = "잘못 입력하셨습니다."
            print(message)
            NotificationCenter.default.post(name: Notification.Name.bankClosed, object: nil)
        }
    }
}
