//
//  MoodDetailView.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 13/4/25.
//

import SwiftUI
import MapKit

struct MoodDetailView: View {
    let mood: Mood

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let image = mood.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                }

                HStack(spacing: 8) {
                    Text(mood.type.emoji)
                        .font(.system(size: 40))

                    VStack(spacing: 8) {
                        Text(mood.note ?? "No note")
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(mood.date.formatted(date: .abbreviated, time: .shortened))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .font(.subheadline)

                    Spacer()
                }

                Divider()

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
                    .frame(height: 400)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                } else {
                    Text("No location")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Mood details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MoodDetailView(
        mood: Mood(
            id: UUID(),
            type: .calm,
            note: "Some Note",
            date: .now,
            image: nil,
            coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            isPublished: false
        )
    )
}
