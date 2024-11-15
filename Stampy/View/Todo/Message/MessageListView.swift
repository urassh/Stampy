//
//  MessageListView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/15.
//
import SwiftUI

struct MessageListView: View {
    @State var selectedMessage: TextMessage? = nil
    @State var isShowMessageDetail: Bool = false
    @State var isShowAlert: Bool = false // New state variable for alert
    private let viewmodel: MessageViewModel
    
    init(viewmodel: MessageViewModel) {
        self.viewmodel = viewmodel
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                ForEach(viewmodel.textMessages) { message in
                    TextMessageCell(message: message)
                        .padding(.all, 8)
                        .onTapGesture {
                            if message.isAvailableShow(todos: viewmodel.getTodos) {
                                selectedMessage = message
                            } else {
                                isShowAlert = true
                            }
                        }
                    
                    Divider()
                }
            }
            .onChange(of: selectedMessage) {
                if selectedMessage != nil {
                    isShowMessageDetail = true
                } else {
                    isShowMessageDetail = false
                }
            }
            .sheet(isPresented: $isShowMessageDetail, onDismiss: {
                selectedMessage = nil
            }) {
                MessageDetailSheet(message: selectedMessage!)
                    .presentationDetents([.medium])
                    .presentationBackground(Material.ultraThin)
            }
            .alert(isPresented: $isShowAlert) { // Alert modifier
                Alert(
                    title: Text("メッセージを表示できません"),
                    message: Text("このメッセージを見るにはTodoを完了する必要があります。"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}
