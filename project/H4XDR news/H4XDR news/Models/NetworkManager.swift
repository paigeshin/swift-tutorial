    import Foundation
    
    class NetworkManager: ObservableObject {
        
        @Published var posts = [Post]() //PostObject, 생성자.    -   @Published 를 사용하면, 데이터가 바뀔 때마다 detection이 된다.
        
        func fetchData(){
            if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
                
                let session:URLSession = URLSession(configuration: .default)
                let task = session.dataTask(with: url) { (data, response, error) in
                    
                    if error == nil {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                let results = try decoder.decode(Results.self, from: safeData)
                                DispatchQueue.main.async {
                                    self.posts = results.hits
                                }
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
