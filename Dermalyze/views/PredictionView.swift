//
//  PredictionView.swift
//  DermaDiary
//
//  Created by samo on 6/2/2025.

import SwiftUI

struct PredictionResult: Identifiable {
    let id = UUID()
    let key: String
    let fullName: String
    let value: Double
}

struct PredictionView: View {
    @StateObject private var viewModel = HAM10000ViewModel()
    @Binding var navigationPath: NavigationPath
    var capturedImage: UIImage
    
    private var sortedResults: [PredictionResult] {
        viewModel.labels.compactMap { key, value in
            guard let fullName = viewModel.labelMappings[key] else { return nil }
            return PredictionResult(key: key, fullName: fullName, value: value)
        }
        .sorted { $0.value > $1.value }
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            VStack(spacing: 24) {
                Image(uiImage: capturedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .frame(height: 250)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .onAppear { viewModel.makePrediction(for: capturedImage) }
                
                List {
                    ForEach(sortedResults) { result in
                        Button(action: {
                            navigationPath.append(Route.explanation(result.fullName))
                        }) {
                            PredictionRowView(fullName: result.fullName, value: result.value)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
                Button(action: {
                    navigationPath = NavigationPath()
                    navigationPath.append(Route.camera)
                }) {
                    HStack {
                        Image(systemName: "camera.fill")
                        Text("Take Another Photo")
                        
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .padding(.horizontal, 32)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Analysis Results")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PredictionRowView: View {
    let fullName: String
    let value: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(fullName)
                .font(.headline)
            
            Text("\(Int(value * 100))% match")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}
