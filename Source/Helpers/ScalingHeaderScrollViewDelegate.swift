//
//  ScalingHeaderScrollViewDelegate.swift
//  ScalingHeaderScrollView
//
//  Created by Daniil Manin on 28.09.2021.
//  Copyright © 2021 Exyte. All rights reserved.
//

import UIKit

final class ScalingHeaderScrollViewDelegate: NSObject, ObservableObject, UIScrollViewDelegate {
    
    var didPullToRefresh: () -> Void = { }
    var didPullToLoadMore: () -> Void = { }
    var didScroll: () -> Void = {}
    var didEndDragging = {}

    // MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll()
        let maxYOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (scrollView.contentOffset.y >= maxYOffset - 200) {
            didPullToLoadMore()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -60 {
            didPullToRefresh()
        }
        let maxYOffset = scrollView.contentSize.height - scrollView.bounds.height
//        if scrollView.contentOffset.y > maxYOffset - 200 {
//            didPullToLoadMore()
//        }

        didEndDragging()
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        didEndDragging()
    }
}
