//
//  PredictionsView.swift
//  DermaDiary
//
//  Created by samo on 6/2/2025.
//
import SwiftUI

struct PredictionView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = HAM10000ViewModel()
    
    var capturedImage: UIImage? // The image you want to predict on

    var body: some View {
        VStack(spacing: 20) {
            if let image = capturedImage {
                // Display the captured image
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200, maxHeight: 200)
                    .onAppear {
                        // Trigger the prediction as soon as the image appears
                        viewModel.makePrediction(for: image)
                    }
            } else {
                Text("No image selected")
            }
                        
            List {
                // Display the prediction results from the model
                ForEach(viewModel.labels.keys.sorted(), id: \.self) { key in
                    if let value = viewModel.labels[key] {
                        Text("\(key): \(String(format: "%.0f", value * 100))%")
                    }
                }
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
