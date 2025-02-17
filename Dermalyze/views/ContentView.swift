//
//  ContentView.swift
//  DermaDiary
//
//  Created by samo on 5/2/2025.
//
import SwiftUI

enum Route: Hashable {
    case camera
    case prediction(UIImage)
    case explanation(String)
}

struct ContentView: View {
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                
                VStack(spacing: 40) {
                    // Logo and Title Section
                    VStack(spacing: 24) {
                        Image(systemName: "cross.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                            .symbolRenderingMode(.hierarchical)
                        
                        Text("Dermalyze")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                        
                        Text("Your Personal Skin Health Assistant")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 60)
                    
                    Text("Scan your skin, predict potential conditions, and get immediate insights. Quickly assess your skin's health—just by taking a photo.")
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 32)
                    
                    Spacer()
                    
                    Button(action: {
                        navigationPath.append(Route.camera)
                    }) {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("Get Started")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal, 32)
                    }
                    .padding(.bottom, 40)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .camera:
                    CameraView(navigationPath: $navigationPath)
                case .prediction(let image):
                    PredictionView(navigationPath: $navigationPath, capturedImage: image)
                case .explanation(let diseaseName):
                    ExplanationView(diseaseName: diseaseName, navigationPath: $navigationPath)
                }
            }
        }
    }
}
