//
//  ProfileView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/05.
//
import SwiftUI
import MapKit

struct ProfileView : View {
    var body: some View {
        VStack {
            ZStack {
                Map()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 10.0)
                    .overlay {
                        Color.black.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                    }
                VStack {
                    Image("Sample")
                        .resizable()
                        .frame(width: 140, height: 140)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .strokeBorder(Color.white.opacity(0.65), lineWidth: 4)
                        }
                        .shadow(radius: 4)
                    Text("urassh")
                        .foregroundStyle(Color.white)
                        .font(.title2)
                    
                    Text("@urassh_enginner")
                        .foregroundStyle(Color.white.opacity(0.9))
                        .font(.callout)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
