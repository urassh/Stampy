//
//  MessageViewModel.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/15.
//

import Foundation

class MessageViewModel: ObservableObject {
    @Published var textMessages: [TextMessage] = []
    @Published var stampMessages: [StampMessage] = []
    private let goal: Goal
    private let todos: [Todo]
    
    init(goal: Goal, todos: [Todo]) {
        self.goal = goal
        self.todos = todos
    }
    
    func getMessages() async {
        let fetchedStamps = await GetStampMessageUseCase().execute(goal: goal)
        let fetchedTexts = await GetTextMessageUseCase().execute(goal: goal)
        
        let timeSortedStamps = fetchedStamps.sorted { $0.createdAt > $1.createdAt }
        let timeSortedTexts = fetchedTexts.sorted { $0.createdAt > $1.createdAt }
        
        DispatchQueue.main.async {
            self.stampMessages = timeSortedStamps
            self.textMessages = timeSortedTexts
        }
    }
    
    var getTodos: [Todo] {
        todos
    }
}
