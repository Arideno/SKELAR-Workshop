//
//  MoodsList.swift
//  Workshop
//
//  Created by Andrii Moisol on 23/4/25.
//

import SwiftUI

struct MoodsList: View {
    @StateObject private var viewModel = MoodsListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.moods, id: \.id) { mood in
                    NavigationLink {
                        MoodDetails(mood: mood)
                    } label: {
                        HStack {
                            Text(mood.type.emoji)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(mood.note ?? "No note")
                                    .font(.headline)

                                Text(mood.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.delete(mood: mood)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Moods")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddMood()
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

#Preview {
    MoodsList()
}
