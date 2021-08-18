//
//  FeedVC.swift
//  Module_Diagram:S2
//
//  Created by Ashish Rai on 15/08/21.
//

import UIKit

protocol FeedLoader {
    func loadFeed(completion: @escaping ([String])-> Void)
}

class FeedViewController: UIViewController {
    var loader: FeedLoader!
    
    convenience init (loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.loadFeed { loadedItems in
            //Update UI
        }
    }
}

class RemoteFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        // remote access i.e API call or service
    }
}

class LocalFeedLoader: FeedLoader {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        //Do something local for testing purpose
    }
}

struct Reachability {
    static let isInternetAvaialable: Bool = false
}

struct RemoteWithLocalFallbackFeedLoader: FeedLoader {
    var remoteLoader: RemoteFeedLoader
    var localLoader: LocalFeedLoader
    
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remoteLoader = remote
        self.localLoader = local
    }
    
    func loadFeed(completion: @escaping ([String]) -> Void) {
        let loader = Reachability.isInternetAvaialable ? remoteLoader.loadFeed : localLoader.loadFeed
        loader(completion)
    }

}

//MARK: Instantiating
let vc = FeedViewController.init(loader: RemoteFeedLoader())
let vc2 = FeedViewController.init(loader: LocalFeedLoader())
let vc3 = FeedViewController.init(loader: RemoteWithLocalFallbackFeedLoader(
                                    remote: RemoteFeedLoader(),
                                    local: LocalFeedLoader())
                                    )
