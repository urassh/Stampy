//
//  ProfileView.swift
//  Stampy
//
//  Created by 浦山秀斗 on 2024/11/05.
//
import SwiftUI
import MapKit

struct ProfileView : View {
    @ObservedObject var viewmodel: ProfileViewModel = ProfileViewModel()
    
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
    
    var body: some View {
        ZStack {
            Background
            
            VStack(spacing: 32) {
                UserInfoSection
                
                if (viewmodel.weekGoal == nil) {
                    ProgressView()
                } else if (viewmodel.weekGoal!.title.isEmpty) {
                    EmptyCard
                } else {
                    GoalCard
                }
            }
            .padding()
        }.onAppear {
            Task {
                await viewmodel.fetchWeekGoal()
                viewmodel.getImage()
            }
        }
        
    }
}

extension ProfileView {
    private var Background: some View {
        Image("background")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .overlay {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
            }
    }
    
    private var UserInfoSection: some View {
        VStack {
            viewmodel.image
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 140)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .strokeBorder(Color.white.opacity(0.65), lineWidth: 4)
                }
                .shadow(radius: 4)
            
            Text(viewmodel.getLoginUser().name)
                .foregroundStyle(Color.white)
                .font(.title)
                .fontWeight(.bold)
            
            Text("@\(LoginUser.shared.loginUser.id)")
                .foregroundStyle(Color.white.opacity(0.9))
                .font(.body)
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
            Text(viewmodel.weekGoal!.title)
                .font(.title)
                .fontWeight(.semibold)
            
            Text("\(viewmodel.weekGoal!.createdAt.toFormattedString()) に作成")
                .font(.callout)
                .opacity(0.6)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundStyle(.white)
        .background(Color.white.opacity(0.1))
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .border(Color.white.opacity(0.1), width: 1).clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var EmptyCard: some View {
        VStack(alignment: .center, spacing: 12) {
            Text("1 week ゴールがまだ設定されていません!!")
                .font(.title)
                .fontWeight(.semibold)
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
