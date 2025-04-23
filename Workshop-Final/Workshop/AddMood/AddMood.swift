//
//  AddMood.swift
//  Workshop
//
//  Created by Andrii Moisol on 23/4/25.
//

import SwiftUI
import PhotosUI

struct AddMood: View {
    @StateObject var viewModel = AddMoodViewModel()
    @State var selectedPhotoItem: PhotosPickerItem?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form {
            Section(header: Text("Mood")) {
                Picker("Select Mood", selection: $viewModel.selectedMoodType) {
                    ForEach(MoodType.allCases, id: \.emoji) { moodType in
                        Text(moodType.emoji)
                            .tag(moodType)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section(header: Text("Note")) {
                TextEditor(text: $viewModel.note)
                    .frame(minHeight: 200)
            }

            Section(header: Text("Photo")) {
                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    Label("Select a photo", systemImage: "photo")
                }
                .onChange(of: selectedPhotoItem) {
                    Task {
                        let data = try? await selectedPhotoItem?.loadTransferable(type: Data.self)
                        if let data {
                            viewModel.selectedPhotoImage = UIImage(data: data)
                        }
                    }
                }

                if let selectedPhotoImage = viewModel.selectedPhotoImage {
                    Image(uiImage: selectedPhotoImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                }
            }

            Section {
                Button("Save") {
                    viewModel.save()
                }
                .onChange(of: viewModel.shouldClose) {
                    if viewModel.shouldClose {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddMood()
}
