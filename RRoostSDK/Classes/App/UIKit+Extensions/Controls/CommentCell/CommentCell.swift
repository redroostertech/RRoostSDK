//
//  CommentCell.swift
//  NuWorldApp
//
//  Created by Michael Westbrooks on 3/27/19.
//  Copyright © 2019 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

public class CommentCell: UITableViewCell {

    @IBOutlet private weak var imgUserAvi: UIImageView!
    @IBOutlet private weak var lblUsername: UILabel!
    @IBOutlet private weak var lblComment: UILabel!
    @IBOutlet private weak var likeButton: UIImageView!
    @IBOutlet private weak var replyButton: UIButton!
    @IBOutlet private weak var likeCount: UIButton!

    private var isLiked = false
    private var comment: BaseComment? {
      didSet {
        guard let comment = self.comment else {return }
        lblUsername.text = comment.retrieveOwnerName()
        imgUserAvi.imageFromUrl(theUrl: comment.retrieveOwnerImage())
        lblComment.text = comment.text
        likecount = comment.retrieveLikeCount()
      }
    }
    private var likecount: Int = 0 {
        didSet {
            likeCount.setTitle("\(self.likecount)", for: .normal)
        }
    }
    private var likeImage: UIImage? {
        didSet {
            guard let image = self.likeImage else { return }
            likeButton.setImage(image: image)
        }
    }
    private var dislikeImage: UIImage?

    override public func awakeFromNib() {
        super.awakeFromNib()
        imgUserAvi.applyCornerRadius()
        lblUsername.makeOneLine()
        lblComment.makeMultipleLines()

        replyButton.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeAction))
        likeButton.addGestureRecognizer(tap)
        likeButton.isUserInteractionEnabled = true
    }
    
    public func configure(comment: BaseComment,
                          likeImage: UIImage,
                          dislikeImage: UIImage) {
        self.comment = comment
        self.likeImage = likeImage
        self.dislikeImage = dislikeImage
    }

    @objc func likeAction() {
        // TODO: - Liking should have backend functionality
        if isLiked {
            likeButton.image = likeImage
            likecount -= 1
            isLiked = false
        } else {
            likeButton.image = dislikeImage
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
