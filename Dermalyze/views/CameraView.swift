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
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            VStack(spacing: 30) {
                if let image = capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 400)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    Button(action: {
                        navigationPath.append(Route.prediction(image))
                    }) {
                        HStack {
                            Image(systemName: "sparkles")
                            Text("Analyze Photo")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal, 32)
                    }
                } else {
                    Spacer()
                    
                    Button(action: { showingImagePicker = true }) {
                        VStack(spacing: 16) {
                            Image(systemName: "camera.circle.fill")
                                .font(.system(size: 80))
                                .symbolRenderingMode(.hierarchical)
                            Text("Take Photo")
                                .font(.headline)
                        }
                        .foregroundColor(.blue)
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Capture")
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $capturedImage)
        }
        .onDisappear(){
            capturedImage = nil
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
