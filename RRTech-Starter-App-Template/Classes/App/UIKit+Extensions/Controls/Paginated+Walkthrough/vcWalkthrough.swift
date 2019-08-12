//
//  vcWalkthrough.swift
//
//  Created by Michael Westbrooks on 8/12/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//
import UIKit

fileprivate typealias Slides = [UIView]

/**
 `vcWalkthrough` provides easy setup for paginated walkthrough experience on main view controller in app

 To use via storyboards, all view controller to subclass vcWalkthrough. Next link up IBOutlets
 */

// TODO: - Work on making a reusable component out of this class to remove dependency on IBOutlets and etc.

public class vcWalkthrough: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet private weak var pageControl: UIPageControl!
  @IBOutlet private weak var scrollView: UIScrollView!

  // MARK: - Properties
  private var slides: Slides!

  // MARK: - Lifecycle methods
  override public func viewDidLoad() {
    super.viewDidLoad()

    slides = createSlides()
    scrollView.delegate = self

    setupSlideScrollView(slides: slides)

    pageControl.numberOfPages = slides.count
    pageControl.currentPage = 0

    view.sendSubview(toBack: scrollView)
    view.bringSubview(toFront: pageControl)

  }

  // MARK: - Private member methods
  private func createSlides() -> Slides {
    let slide0 = Walkthrough_1()
    slide0.view.frame = scrollView.bounds
    let slide1 = Walkthrough_2()
    slide1.view.frame = scrollView.bounds
    let slide2 = Walkthrough_3()
    slide2.view.frame = scrollView.bounds
    let slide3 = Walkthrough_4()
    slide3.view.frame = scrollView.bounds
    return [slide0.view, slide1.view, slide2.view, slide3.view]
  }

  private func setupSlideScrollView(slides: Slides) {
    scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(slides.count),
                                    height: scrollView.frame.height)
    scrollView.isPagingEnabled = true

    for i in 0 ..< slides.count {
      slides[i].frame = CGRect(x: scrollView.frame.width * CGFloat(i),
                               y: 0,
                               width: scrollView.frame.width,
                               height: scrollView.frame.height)
      scrollView.addSubview(slides[i])
    }
  }
}

// MARK: - UIScrollViewDelegate
extension vcWalkthrough: UIScrollViewDelegate {
  override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    setupSlideScrollView(slides: slides)
  }

  private func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
    pageControl.currentPage = Int(pageIndex)
  }
}

