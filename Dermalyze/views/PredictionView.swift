//
//  PredictionView.swift
//  DermaDiary
//
//  Created by samo on 6/2/2025.
import SwiftUI

struct PredictionView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = HAM10000ViewModel()
    @Binding var path: NavigationPath
    var capturedImage: UIImage
    
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
                    ForEach(viewModel.labels.keys.sorted {
                        viewModel.labels[$0] ?? 0 > viewModel.labels[$1] ?? 0
                    }, id: \.self) { key in
                        if let value = viewModel.labels[key],
                           let fullName = viewModel.labelMappings[key] {
                            NavigationLink(destination: ExplanationView(diseaseName: fullName, path: $path)) {
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
                    }
                }
                .listStyle(PlainListStyle())
                
                Button(action: {
                    path = NavigationPath(["camera"])
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
