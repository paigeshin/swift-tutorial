import GoogleMobileAds
import UIKit

class ViewController: UIViewController {

  var bannerView: GADBannerView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // In this case, we instantiate the banner with desired ad size.
    bannerView = GADBannerView(adSize: kGADAdSizeBanner)

    addBannerViewToView(bannerView)
  }

  func addBannerViewToView(_ bannerView: GADBannerView) {
    bannerView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bannerView)
    view.addConstraints(
      [NSLayoutConstraint(item: bannerView,
                          attribute: .bottom,
                          relatedBy: .equal,
                          toItem: bottomLayoutGuide,
                          attribute: .top,
                          multiplier: 1,
                          constant: 0),
       NSLayoutConstraint(item: bannerView,
                          attribute: .centerX,
                          relatedBy: .equal,
                          toItem: view,
                          attribute: .centerX,
                          multiplier: 1,
                          constant: 0)
      ])
   }
   
}
