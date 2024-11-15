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
                    messageCell(message)
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
                isShowMessageDetail = true
            }
            .sheet(isPresented: $isShowMessageDetail) {
                MessageDetailSheet(message: selectedMessage!)
                    .presentationDetents([.medium])
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

extension MessageListView {
    private func messageCell(_ message: TextMessage) -> some View {
        HStack {
            Image("Sample")
                .resizable()
                .frame(width: 72, height: 72)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(message.sender.name)
                    .font(.callout)
                
                HStack(alignment: .top, spacing: 4) {
                    Text("NEW")
                        .foregroundStyle(.pink)
                        .font(.callout)
                        .bold()
                    
                    Text("メッセージが届いています!!")
                        .foregroundStyle(.secondary)
                        .font(.callout)
                        .bold()
                }
                
                Spacer()
                
                Text(message.createdAt.formattedElapsedTime())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
