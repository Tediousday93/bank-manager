//
//  BankManager.swift
//  Created by Rowan, 릴라.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

struct BankManager {
    let bank: Bank
    
    //메뉴 띄우기
    func printMenu() {
        let menuText = """
            1 : 은행 개점
            2 : 종료
            입력 :
            """
        
        print(menuText)
        
        guard let userInput = readLine() else { return }
        
        switch userInput {
        case "1":
            openBank()
        case "2":
            closeBank()
        default:
            print("잘못 입력하셨습니다.")
        }
    }
    
    func openBank() {
        
    }
    
    func closeBank() {
        
    }
}
