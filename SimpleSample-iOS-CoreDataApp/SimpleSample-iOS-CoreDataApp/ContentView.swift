//
//  ContentView.swift
//  SimpleSample-iOS-CoreDataApp
//
//  Created by Jo JANGHUI on 2023/01/28.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            showImage(image: selectedImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 150)
            
            Spacer()
            
            Button {
                saveImage(imageData: Data())
            } label: {
                Text("Save Image")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(.blue)
            
            Button {
                imagePickerPresented.toggle()
            } label: {
                Text("Show Image")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(.blue)
            .sheet(isPresented: $imagePickerPresented) {
                ImagePickerController(image: $selectedImage)
            }
            
            Spacer()
            
            Image(systemName: "")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 150)
                .background(.gray)
            
            Spacer()
            
        }
        .padding()
    }
    
    private func showImage(image: UIImage?) -> Image {
        guard let guardImage = image else { return Image(systemName: "photo") }
        return Image(uiImage: guardImage)
    }
    
    private func saveImage(imageData: Data) {
        let newItem = Entity(context: viewContext)
        newItem.img = Data()
        do {
            try viewContext.save()
        }
        catch {
            // Replace this implementation with code to handle the error appropriately.
            let nsError = error as NSError
            debugPrint("🔴🔴🔴 Unresolved error \(nsError)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
