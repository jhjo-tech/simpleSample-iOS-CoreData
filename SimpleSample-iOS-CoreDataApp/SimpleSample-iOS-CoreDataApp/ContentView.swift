//
//  ContentView.swift
//  SimpleSample-iOS-CoreDataApp
//
//  Created by Jo JANGHUI on 2023/01/28.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private let entityName = String(describing: Entity.self)
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var imagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var loadedImage: UIImage?
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            showImage(image: selectedImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 150)
            
            Spacer()
            
            createButton(
                title: "Show Image",
                action: {
                    imagePickerPresented.toggle()
                }
            )
            .sheet(isPresented: $imagePickerPresented) {
                ImagePickerController(image: $selectedImage)
            }
            
            createButton(
                title: "Save Image",
                action: {
                    if let imageData = selectedImage?.pngData() {
                        saveImage(imageData: imageData)
                    }
                })
            
            createButton(
                title: "Load first Image",
                action: {
                    loadedImage = UIImage(data: fetchEntitys().first?.img ?? Data())
                })
            
            createButton(
                title: "Remove Entitys",
                action: {
                    removeAllEntity()
                })
            
            Spacer()
            
            showImage(image: loadedImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 150)
            Spacer()
            
        }
        .padding()
    }
    
    private func createButton(
        title: String,
        action: @escaping () -> Void) -> some View {
            Button {
                action()
            } label: {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(.blue)
        }
    
    private func showImage(image: UIImage?) -> Image {
        guard let guardImage = image else { return Image(systemName: "photo") }
        return Image(uiImage: guardImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Context(Core Data)
extension ContentView {
    
    private func saveImage(imageData: Data) {
        withAnimation {
            let newItem = Entity(context: viewContext)
            newItem.img = imageData
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
    
    private func fetchEntitys() -> [Entity] {
        withAnimation {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                let entitys = try viewContext.fetch(fetchRequest) as! [Entity]
                debugPrint("Load Entity(\(entitys.count)pcs) : \(entitys)")
                return entitys
            }
            catch {
                debugPrint("Error while feching the image")
            }
            
            return []
        }
    }
    
    private func removeAllEntity() {
        withAnimation {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                let entitys = try viewContext.fetch(fetchRequest) as! [Entity]
                entitys.forEach(viewContext.delete)
                
                try viewContext.save()
                
                loadedImage = nil
                
                debugPrint(#function)
            }
            catch {
                debugPrint("Error while feching the image")
            }
        }
    }
}
