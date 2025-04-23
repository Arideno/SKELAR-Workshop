//
//  HTTPService.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 17/4/25.
//

import Foundation

final class HTTPService {
    enum RequestError: LocalizedError {
        case message(String)
        case noToken
        case unknown

        var errorDescription: String? {
            switch self {
            case .message(let message): message
            case .noToken: "No token"
            case .unknown: "Unknown error"
            }
        }
    }

    static let shared = HTTPService()
    private let session = URLSession.shared

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private init() {
        encoder.keyEncodingStrategy = .convertToSnakeCase
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }

    private func get<T: Decodable>(path: String) async throws -> T {
        guard let token = await AuthService.shared.getToken() else {
            throw RequestError.noToken
        }

        let url = URL(string: "https://skelar-workshop.andriimoisol.com/api/\(path)")!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoded = try decoder.decode(ResponseWrapper<T>.self, from: data)
        switch decoded {
        case .success(let data): return data
        case .error(let message): throw RequestError.message(message)
        }
    }

    private func post<T: Encodable>(path: String, body: T) async throws {
        guard let token = await AuthService.shared.getToken() else {
            throw RequestError.noToken
        }

        let url = URL(string: "https://skelar-workshop.andriimoisol.com/api/\(path)")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let bodyData = try encoder.encode(body)
        request.httpBody = bodyData

        let (data, _) = try await URLSession.shared.data(for: request)

        let decoded = try decoder.decode(VoidResponseWrapper.self, from: data)

        switch decoded {
        case .success: break
        case .error(let message): throw RequestError.message(message)
        }
    }

    func publishMood(_ mood: Mood) async throws {
        let dto = MoodDTO(
            id: mood.id,
            type: mood.type.rawValue,
            note: mood.note,
            date: mood.date,
            latitude: mood.coordinate?.latitude,
            longitude: mood.coordinate?.longitude
        )

        try await post(path: "moods/publish", body: dto)
    }

    func getAllMoods() async throws -> [MoodDTO] {
        try await get(path: "moods")
    }
}

enum ResponseWrapper<T: Decodable>: Decodable {
    case success(T)
    case error(String)

    enum CodingKeys: String, CodingKey {
        case status
        case data
        case message
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let status = try container.decode(ResponseStatus.self, forKey: .status)

        switch status {
        case .success:
            let data = try container.decode(T.self, forKey: .data)
            self = .success(data)
        case .error:
            let message = try container.decode(String.self, forKey: .message)
            self = .error(message)
        }
    }
}

enum VoidResponseWrapper: Decodable {
    case success
    case error(String)

    enum CodingKeys: String, CodingKey {
        case status
        case message
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let status = try container.decode(ResponseStatus.self, forKey: .status)

        switch status {
        case .success:
            self = .success
        case .error:
            let message = try container.decode(String.self, forKey: .message)
            self = .error(message)
        }
    }
}

enum ResponseStatus: String, Decodable {
    case success
    case error
}
