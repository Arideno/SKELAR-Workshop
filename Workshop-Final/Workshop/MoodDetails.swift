//
//  MoodDetails.swift
//  Workshop
//
//  Created by Andrii Moisol on 23/4/25.
//

import SwiftUI
import CoreLocation
import MapKit

struct MoodDetails: View {
    let mood: Mood

    var body: some View {
        VStack {
            Text(mood.type.emoji)
                .font(.system(size: 80))

            Text(mood.date.formatted(date: .abbreviated, time: .shortened))
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Divider()

            Text(mood.note ?? "No note")
                .font(.body)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let image = mood.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(12)
                    .shadow(radius: 4)
            }

            if let coordinate = mood.coordinate {
                Map {
                    Annotation("Mood", coordinate: coordinate) {
                        Circle()
                            .fill(.red)
                            .frame(width: 20, height: 20)
                    }
                }
            }

            Spacer()
        }
        .padding(16)
    }
}

#Preview {
    MoodDetails(mood: Mood(id: UUID(), type: .happy, note: "Note\nNote\nNote", date: .now, image: nil, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0)))
}
