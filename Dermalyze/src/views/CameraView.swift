//
//  CameraView.swift
//  DermaDiary
//
//  Created by samo on 6/2/2025.
//

import SwiftUI

struct CameraView: View {
    @State private var showingImagePicker = false
    @State private var capturedImage: UIImage?
    @State private var navigateToPrediction = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let image = capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 300)
                    
                    Button(action: {
                        navigateToPrediction = true
                    }) {
                        Text("Analyze Photo")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                } else {
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        VStack {
                            Image(systemName: "camera.circle.fill")
                                .font(.system(size: 64))
                            Text("Take Photo")
                                .font(.headline)
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Take Photo")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $capturedImage)
            }
            .navigationDestination(isPresented: $navigateToPrediction) {
                PredictionView(capturedImage: capturedImage) // Pass captured image
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
