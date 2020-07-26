import Foundation

protocol NewsPresenterDelegate: class {
    func updateTableView(news: [NewsModel])
}

class NewsPresenter {
    
    weak private var delegate: NewsPresenterDelegate?
    
    private let newsService: NewsService
    
    init(mainService: NewsService) {
        self.newsService = mainService
        
        mainService.getNews { (news) in
            self.delegate?.updateTableView(news: news)
        }
    }
    
    func setDelegate(_ mainPresenterDelegate: NewsPresenterDelegate?) {
        self.delegate = mainPresenterDelegate
    }

}
