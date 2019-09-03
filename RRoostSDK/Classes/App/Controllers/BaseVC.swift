import UIKit

public class BaseVC: UIViewController {
    
    var viewDidLoadActionHandler: (() -> Void)?
    var viewWillAppearActionHandler: (() -> Void)?
    var viewDidAppearActionHandler: (() -> Void)?
    var viewWillDisappearActionHandler: (() -> Void)?
    var viewDidDisappearActionHandler: (() -> Void)?
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoadActionHandler?()
        viewWillAppearActionHandler?()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearActionHandler?()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearActionHandler?()
    }
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewDidDisappearActionHandler?()
    }
}
