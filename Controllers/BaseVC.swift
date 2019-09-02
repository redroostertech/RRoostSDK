import UIKit

class BaseVC: UIViewController {
    
    var viewDidLoadActionHandler: (() -> Void)?
    var viewWillAppearActionHandler: (() -> Void)?
    var viewDidAppearActionHandler: (() -> Void)?
    var viewWillDisappearActionHandler: (() -> Void)?
    var viewDidDisappearActionHandler: (() -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoadActionHandler?()
        viewWillAppearActionHandler?()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearActionHandler?()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearActionHandler?()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewDidDisappearActionHandler?()
    }
}
