//
//  MoodListView.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 13/4/25.
//

import SwiftUI

struct MoodListView: View {
    @StateObject private var viewModel = MoodListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.moods) { mood in
                    NavigationLink {
                        MoodDetailView(mood: mood)
                    } label: {
                        HStack {
                            Text(mood.type.emoji)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(mood.note ?? "No note")
                                    .font(.headline)
                                Text(mood.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                    .swipeActions(edge: .leading) {
                        if !mood.isPublished {
                            Button("Publish") {
                                viewModel.publish(mood: mood)
                            }
                            .tint(.blue)
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.delete(mood: mood)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("My Moods")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        AddMoodView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
}
