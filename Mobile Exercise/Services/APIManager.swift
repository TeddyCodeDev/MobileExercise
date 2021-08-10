//
//  APIManager.swift
//  Mobile Exercise
//
//  Created by Tyler Barnes on 8/3/21.
//

import Foundation

struct APIManager {

	enum HTTPError: Error, Equatable {
		case transportError(Error)
		case serverSideError(Int)

		static func == (lhs: APIManager.HTTPError, rhs: APIManager.HTTPError) -> Bool {
			if
				case .transportError(let lhsError) = lhs,
				case .transportError(let rhsError) = rhs
			{
				return lhsError.localizedDescription == rhsError.localizedDescription
			}

			if
				case .serverSideError(let lhsError) = lhs,
				case .serverSideError(let rhsError) = rhs
			{
				return lhsError == rhsError
			}

			return false
		}
	}

	// Unused in code currently
	static func sendGETRequest(to url: URL, with parameters: [URLQueryItem] = [], completion: @escaping (Result<Data?, Error>) -> ()) {
		guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
		components.queryItems = parameters

		var request = URLRequest(url: components.url!)
		request.httpMethod = "GET"

		send(request: request, completion: completion)
	}

	static func sendPOSTRequest(to url: URL, with parameters: [URLQueryItem] = [], containing body: [String]=[], completion: @escaping (Result<Data?, Error>) -> ()) {

		guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
		components.queryItems = parameters

		var bodyString: String = ""
		for (i, value) in body.enumerated() {
			bodyString.append(value)

			if i != body.count - 1 {
				bodyString.append("&")
			}
		}
		let postData = bodyString.data(using: .utf8)

		var request = URLRequest(url: components.url!)
		request.httpMethod = "POST"
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");

		request.httpBody = postData

		send(request: request, completion: completion)
	}

	// Dictionaries being unordered causes this method to send parameters up swapped occasionally i.e. "password=smith&username=morty" vs the server expecting them as "username=morty&password=smith" so this unfortunately fails, personally I'd request the web team to have the server accept them in any order and search for the keys they care about so the code can be more generic across the board
//	static func sendPOSTRequest(to url: URL, with parameters: [URLQueryItem] = [], containing body: [String: Any]=[:], completion: @escaping (Result<Data?, Error>) -> ()) {
//
//		guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
//		components.queryItems = parameters
//
//		var bodyString: String = ""
//		for (i, (key, value)) in body.enumerated() {
//			bodyString.append("\(key)=\(value)")
//
//			if i != body.count - 1 {
//				bodyString.append("&")
//			}
//		}
//		let postData = bodyString.data(using: .utf8)
//
//		var request = URLRequest(url: components.url!)
//		request.httpMethod = "POST"
//		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
//
//		request.httpBody = postData
//
//		send(request: request, completion: completion)
//	}

	private static func send(request: URLRequest, completion: @escaping (Result<Data?, Error>) -> ()) {
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completion(.failure(HTTPError.transportError(error)))
			}

			if let httpResponse = response as? HTTPURLResponse {
				switch httpResponse.statusCode {
					case 200:
						completion(.success(data))
					default:
						completion(.failure(HTTPError.serverSideError(httpResponse.statusCode)))
				}
			}
		}.resume()
	}
}
