//
//  AddMoodView.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 13/4/25.
//

import SwiftUI
import PhotosUI

struct AddMoodView: View {
    @StateObject private var viewModel = AddMoodViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var photoItem: PhotosPickerItem?

    var body: some View {
        Form {
            Section(header: Text("Mood")) {
                Picker("Select mood", selection: $viewModel.selectedMood) {
                    ForEach(MoodType.allCases) { mood in
                        Text(mood.emoji).tag(mood)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section(header: Text("Note")) {
                TextEditor(text: $viewModel.note)
                    .frame(minHeight: 100)
            }

            Section(header: Text("Photo")) {
                PhotosPicker(selection: $photoItem, matching: .images) {
                    Label("Select photo", systemImage: "photo")
                }
                .onChange(of: photoItem) {
                    Task {
                        if let data = try? await photoItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            viewModel.selectedImage = uiImage
                        }
                    }
                }

                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                }
            }

            Section {
                Button("Save") {
                    viewModel.save()
                    dismiss()
                }
            }
        }
        .navigationTitle("New mood")
        .onAppear {
            viewModel.fetchLocation()
        }
    }
}
