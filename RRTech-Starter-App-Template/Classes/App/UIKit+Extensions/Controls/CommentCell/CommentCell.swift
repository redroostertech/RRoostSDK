//
//  CommentCell.swift
//  NuWorldApp
//
//  Created by Michael Westbrooks on 3/27/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var imgUserAvi: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var likeButton: UIImageView!
    @IBOutlet weak var replyButton: UIButton!
    
    var comment: BlogComment?
    var isLiked = false
    var likecount = 0 {
        didSet {
            likeCount.setTitle("\(self.likecount)", for: .normal)
        }
    }
    @IBOutlet weak var likeCount: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgUserAvi.applyCornerRadius()
        lblUsername.makeOneLine()
        lblComment.makeMultipleLines()
        
        replyButton.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeAction))
        likeButton.addGestureRecognizer(tap)
        likeButton.isUserInteractionEnabled = true
    
    }
    
    func configure(withComment comment: BlogComment) {
        self.comment = comment
        self.lblComment.text = comment.getCommenttext()
        
        getInfo(forUser: comment.getUserid())
        getImage(forUser: comment.getUserid())
    }
    
    func getInfo(forUser id: Int) {
        let parameters: [String: Any] = [
            "action" : "getUserInfo",
            "user_id": id
        ]
        makeApiRequest(withParameters: parameters) { (data, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                if let data = data as? [String: Any] {
                    guard let user = User(JSON: data) else { return }
                    self.lblUsername.text = user.firstName ?? ""
                }
            }
        }
    }
    
    func getImage(forUser id: Int) {
        let parameters: [String: Any] = [
            "action" : "getUserImage",
            "user_id": id
        ]
        makeApiRequest(withParameters: parameters) { (data, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
//                if let data = data as? [String: Any] {
//                    guard let user = User(JSON: data) else { return }
//                    self.lblUsername.text = user.firstName ?? ""
//                }
            }
        }
    }

    @objc func likeAction() {
        // TODO: - Liking should have backend functionality
        if isLiked {
            likeButton.image = UIImage(named:"like")
            likecount -= 1
            isLiked = false
        } else {
            likeButton.image = UIImage(named:"like-filled")
            likecount += 1
            isLiked = true
        }
    }
    
    @IBAction func reply(_ sender: Any) {
        // TODO: - Replying to comments should have backend functionality
    }
    
    @IBAction func like(_ sender: Any) {
        likeAction()
    }
    
}

extension CommentCell {
    static var identifier: String {
        return String(describing: self)
    }
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
