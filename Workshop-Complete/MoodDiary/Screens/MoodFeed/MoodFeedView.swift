//
//  MoodFeedView.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 19/4/25.
//

import SwiftUI
import MapKit

struct MoodFeedView: View {
    @StateObject private var viewModel = MoodFeedViewModel()

    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .loading: ProgressView().progressViewStyle(.circular)
            case .error(let error):
                VStack {
                    Text(error.localizedDescription)
                        .foregroundColor(.red)
                        .font(.headline)
                    Button("Retry") {
                        Task {
                            await viewModel.refresh()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            case .data(let moods):
                List {
                    ForEach(moods) { mood in
                        VStack(alignment: .leading, spacing: 8) {
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

                            if let coordinate = mood.coordinate {
                                Map(initialPosition: .camera(.init(centerCoordinate: coordinate, distance: 100))) {
                                    Annotation("Mood", coordinate: coordinate) {
                                        ZStack {
                                            Circle()
                                                .fill(.blue)
                                                .frame(width: 12, height: 12)
                                            Circle()
                                                .stroke(.white, lineWidth: 2)
                                                .frame(width: 18, height: 18)
                                        }
                                    }
                                }
                                .frame(height: 200)
                                .cornerRadius(12)
                                .shadow(radius: 4)
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .refreshable {
                    await viewModel.refresh()
                }
                .listStyle(.plain)
                .navigationTitle("Mood Feed")
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}
