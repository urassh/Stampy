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
        ZStack {
            Background
            
            VStack(spacing: 32) {
                UserInfoSection
                
                GoalCard
            }
            .padding()
        }
    }
}

extension ProfileView {
    private var Background: some View {
        Map()
            .edgesIgnoringSafeArea(.all)
            .blur(radius: 10.0)
            .overlay {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
            }
    }
    
    private var UserInfoSection: some View {
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
    
    private var GoalCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("🔥")
                    .font(.largeTitle)
                Text("1 week Goal")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
            }
            Text("RailsTutorialを終わらせる。")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("2024/10/11 に作成")
                .font(.callout)
                .opacity(0.6)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.1))
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .border(Color.white.opacity(0.1), width: 1).clipShape(RoundedRectangle(cornerRadius: 12))
        
    }
}

#Preview {
    ProfileView()
}
