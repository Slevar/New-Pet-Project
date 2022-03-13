//
//  APICaller.swift
//  Spotify
//
//  Created by Вардан Мукучян on 14.03.2021.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    enum APIError: Error {
        case failToGetData
    }
    
    // MARK - Albums
    
    public func getAlbumDetails(for album: Album, completion: @escaping (Result<AlbumDetailsResponce, Error>) -> Void) {
         createRequest (
            with: URL(string: Constants.baseAPIURL+"/albums/" + album.id),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    //let result =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(AlbumDetailsResponce.self, from: data)
                    completion(.success(result))
                    //print(result)
                }
                catch {
                    print("Хуйня_Альбом_\(error)")
                    completion(.failure(error))
                }
            }
            task.resume()
         }
    }
    
    // MARK - Playlists
    
    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailResponce, Error>) -> Void) {
         createRequest (
            with: URL(string: Constants.baseAPIURL+"/playlists/"+playlist.id),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    //let result =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(PlaylistDetailResponce.self, from: data)
                    completion(.success(result))
                    //print(result)
                }
                catch {
                    print("Хуйня_Playlist_\(error)")
                    completion(.failure(error))
                }
            }
            task.resume()
         }
    }
    
    public func getCurrentUserPlaylist(completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL+"/me/playlists/?limit=50"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(LibralyPlaylistsResponce.self, from: data)
                        //JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    completion(.success(result.items))
                }
                catch{
                    print("}{уйня")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    public func createPlaylist(with name: String, completion: @escaping (Bool) -> Void) {
        getCurrentUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                let urlString = Constants.baseAPIURL + "/users/\(profile.id)/playlists"
                print(urlString)
                self?.createRequest(with: URL(string: urlString), type: .POST) { baseRequest in
                    var request = baseRequest
                    let json = [
                        "name": name
                    ]
                    request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                        guard let data = data, error == nil else {
                            completion(false)
                            return
                        }
                        do {
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            print("Starting creation...")
                            print(data)
                            if let responce = result as? [String: Any], responce["id"] as? String != nil {
                                print("Created")
                                completion(true)
                            }
                            else {
                                print("Fail to get id")
                                print(result)
                                completion(false)
                            }
                        }
                        catch {
                            print(error)
                            completion(false)
                        }
                    }
                    task.resume()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    public func addTrackToPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Bool) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL+"/playlists/\(playlist.id)/tracks"),
                      type: .POST) { baseRequest in
            var request = baseRequest
            let json = [
                "urls": "spotify:track:\(track.id)"
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(false)
                    return
                }
                do {
                    let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let responce = result as? [String: Any], responce["snapshot_id"] as? String != nil {
                        completion(true)
                    }
                }
            }
            task.resume()
        }
    }
    
    public func removeTrackFromPlaylist(track: AudioTrack, playlist: Playlist, completion: @escaping (Bool) -> Void) { }

    // MARK - Profile

    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
         createRequest (
            with: URL(string: Constants.baseAPIURL+"/me"),
            type: .GET
        ) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    //let noResult =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    completion(.success(result))
                    //print(result)
                }
                catch {
                    print("Хуйня__\(error)")
                    completion(.failure(error))
                }
            }
            task.resume()
         }
    }
    
    public func getNewReleases(completion: @escaping ((Result<NewRealeasesResponce, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL+"/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewRealeasesResponce.self, from: data)
                    completion(.success(result))
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
                }
                catch {
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    public func getFeaturedPlaylist(completion: @escaping ((Result<FeaturedPlaylistResponce, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL+"/browse/featured-playlists?limit=20"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponce.self, from: data)
                    completion(.success(result))
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
                }
                catch {
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
    public func getRecomendations(genres: Set<String>, completion: @escaping ((Result<RecommendationsResponce, Error>)) -> Void) {
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL+"/recommendations?limit=40&seed_genres=\(seeds)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendationsResponce.self, from: data)
                    completion(.success(result))
                    //print(result)
                }
                catch {
                    completion(.failure(error))
                }

            }
            task.resume()
        }
    }

    public func getRecomendedGenre (completion: @escaping ((Result<RecommendedGenresResponce, Error>)) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL+"/recommendations/available-genre-seeds"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(RecommendedGenresResponce.self, from: data)
                    completion(.success(result))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK - Search
    public func search(with query: String, completion: @escaping (Result<[SearchResult], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL+"/search?limit=8&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "-")"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(SearchResultResponce.self, from: data)
                    var searchresult: [SearchResult] = []
                    searchresult.append(contentsOf: result.albums.items.compactMap({SearchResult.album(model: $0)}))
                    searchresult.append(contentsOf: result.artists.items.compactMap({SearchResult.artist(model: $0)}))
                    searchresult.append(contentsOf: result.playlists.items.compactMap({SearchResult.playlist(model: $0)}))
                    searchresult.append(contentsOf: result.tracks.items.compactMap({SearchResult.track(model: $0)}))
                    completion(.success(searchresult))
                }
                catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    //MARK - Categoories
    
    public func getCategories (completion: @escaping (Result<[Category], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL+"/browse/categories?limit=50"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(AllCategoriesResponce.self, from: data)
                    completion(.success(result.categories.items))
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
                }
                catch { completion(.failure(error))
                    
                }
            }
            task.resume()
        }
    }
    
    
    public func getCategoryPlaylists (category: Category,completion: @escaping (Result<[Playlist], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL+"/browse/categories/\(category.id)/playlists/?limit=40"),
                      type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(CategoryPlaylistResponce.self, from: data)
                    completion(.success(result.playlists.items))
                }
                catch { completion(.failure(error))
                    
                }
            }
            task.resume()
        }
    }
    
    // MARK - private
    
//    private func reusableAPICall<T:Codable>(with request: URLRequest, completion: @escaping ((Result<T, Error>)) -> Void, decodableType: T) {
//        let task = URLSession.shared.dataTask(with: request) { data, _, error in
//            guard let data = data, error == nil else {
//                completion(.failure(APIError.failToGetData))
//                return
//            }
//            do {
//                let result = try JSONDecoder().decode(decodableType.self as! T.Type, from: data)
//                completion(.success(result))
//            }
//            catch {
//                completion(.failure(error))
//            }
//        }
//        task.resume()
//    }
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest (with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken {token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                            forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
