import Foundation
import Alamofire
import SwiftyXMLParser

class NewsService {
    
    func getNews(completion: @escaping ([NewsModel]) -> ()) {
        var allNews = [NewsModel]()
        
        getHabrNews() { (habrNews) in
            allNews += habrNews
            
            self.getLentaNews() { (lentaNews) in
                allNews += lentaNews
                
                self.getMeduzaNews { (meduzaNews) in
                    allNews += meduzaNews
                    
                    allNews = allNews.sorted(by: { ($0.date ?? .distantPast) > ($1.date ?? .distantPast) } )
                    completion(allNews)
                }
            }
        }
    }
    
    func getHabrNews(completion: @escaping ([NewsModel]) -> ()) {
        AF.request("https://habr.com/rss/hubs/all").responseData { response in
            if let data = response.data {
                let xml = XML.parse(data)
                
                var newsItems = [NewsModel]()
                for item in xml.rss.channel.item {
                    let news = NewsModel(newsSource: .habr, xml: item)
                    newsItems.append(news)
                }
                
                completion(newsItems)
            }
        }
    }
    
    func getLentaNews(completion: @escaping ([NewsModel]) -> ()) {
        AF.request("https://lenta.ru/rss/").responseData { response in
            if let data = response.data {
                let xml = XML.parse(data)
                
                var newsItems = [NewsModel]()
                for item in xml.rss.channel.item {
                    let news = NewsModel(newsSource: .lenta, xml: item)
                    newsItems.append(news)
                }
                
                completion(newsItems)
            }
        }
    }
    
    func getMeduzaNews(completion: @escaping ([NewsModel]) -> ()) {
        AF.request("https://meduza.io/rss/podcasts/meduza-v-kurse").responseData { response in
            if let data = response.data {
                let xml = XML.parse(data)
                
                var newsItems = [NewsModel]()
                for item in xml.rss.channel.item {
                    let news = NewsModel(newsSource: .meduza, xml: item)
                    newsItems.append(news)
                }
                
                completion(newsItems)
            }
        }
    }
    
    
}
