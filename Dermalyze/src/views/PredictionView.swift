//
//  PredictionsView.swift
//  DermaDiary
//
//  Created by samo on 6/2/2025.
//

import SwiftUI

struct PredictionView: View {
    @Environment(\.dismiss) private var dismiss
//    @StateObject private var mlManager = MLManager(modelName: "SkinLesionClassifier") // Load your CoreML model
    var capturedImage: UIImage?
    
    @State private var predictionLabel: String?
    @State private var predictionConfidence: Float?
    
    var body: some View {
        VStack(spacing: 20) {
            if let image = capturedImage {
                // Display the captured image
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300, maxHeight: 300)
                
                // Analyze the image when it's available
                Button("Analyze Photo") {
//                    analyzeImage(image)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            } else {
                Text("No image selected")
            }
            
            // Show classification result
            if let label = predictionLabel, let confidence = predictionConfidence {
                Text("Predicted: \(label)")
                    .font(.headline)
                    .padding()
                Text("Confidence: \(String(format: "%.2f", confidence * 100))%")
                    .font(.subheadline)
                    .padding()
            }
            
            // Button to take another photo
            Button(action: {
                dismiss()
            }) {
                Text("Take Another Photo")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("Predicted Results")
        .padding()
    }
    
}
