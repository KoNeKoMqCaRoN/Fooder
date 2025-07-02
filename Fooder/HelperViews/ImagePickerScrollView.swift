//
//  ImagePickerScrollView.swift
//  Fooder
//
//  Created by cmStudent on 2025/07/02.
//

import SwiftUI
import PhotosUI

// Helper View
struct ImagePickerScrollView: View {
    @Binding var selectedImages: [UIImage]
    @State var selectedItem: PhotosPickerItem?
    @State var showCamera: Bool = false
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                // Display Selected Images
                ForEach(selectedImages, id: \.self) { image in
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipped()
                            .cornerRadius(12)
                        
                        // Optional remove button
                        Button {
                            if let index = selectedImages.firstIndex(of: image) {
                                withAnimation {
                                    selectedImages.remove(at: index)
                                }
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .background(Circle().fill(Color.black.opacity(0.6)))
                        }
                        .offset(x: -5, y: 5)
                    }
                }
                
                // Picker and Camera Buttons
                pickerButton
                cameraButton
                
            }
            .padding(.horizontal)
            .sheet(isPresented: $showCamera, content: {
                ImagePicker(sourceType: .camera) { uiImage in
                    selectedImages.append(uiImage)
                }
            })
            .onChange(of: selectedItem) { _, newItem in
                // 選択されたPhotoPickerItem をUIImage に変換し, selectedImagesに入れる
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        selectedImages.append(uiImage)
                    }
                }
            }
        }
    }
    
    private var pickerButton: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            VStack(spacing: 10) {
                Image(systemName: "photo.fill")
                    .font(.title)
                Text("ライブラリ")
                    .font(.caption)
            }
            .frame(width: 120, height: 120)
            .background(.gray.opacity(0.1))
            .cornerRadius(12)
            .foregroundColor(.blue)
        }
    }
    
    private var cameraButton: some View {
        Button {
            showCamera.toggle()
        } label: {
            VStack(spacing: 10) {
                Image(systemName: "camera.fill")
                    .font(.title)
                Text("カメラ")
                    .font(.caption)
            }
            .frame(width: 120, height: 120)
            .background(.gray.opacity(0.1))
            .cornerRadius(12)
            .foregroundColor(.green)
        }
    }
}

#Preview {
    ImagePickerScrollView(selectedImages: .constant([]))
}
