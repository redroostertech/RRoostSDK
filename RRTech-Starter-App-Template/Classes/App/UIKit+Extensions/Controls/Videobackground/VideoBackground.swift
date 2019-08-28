import UIKit
import AVFoundation

private var videoLayerContainer: UIView?
private var videoPlayer: AVPlayer?
private var videoPlayerLayer: AVPlayerLayer?

public class VideoBackground: NSObject {

  var isLoopingEnabled: Bool = false {
    didSet {
      NotificationCenter.default.addObserver(self, selector: #selector(loop), name: .AVPlayerItemDidPlayToEndTime, object: videoPlayer?.currentItem)
    }
  }

  var videoOverlayColor: UIColor = .clear {
    didSet {
      addOverlayToVideo(usingColor: videoOverlayColor)
    }
  }

  init(withPathFromBundle path: String,
       ofFileType fileType: String,
       forView view: UIView? = nil) {
    if let view = view {
      videoLayerContainer = view
    } else {
      videoLayerContainer = UIApplication.shared.keyWindow?.rootViewController!.view
    }
    if let path = Bundle.main.url(forResource: path, withExtension: fileType) {
      videoPlayer = AVPlayer(url: path)
      videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
      if let videoplayer = videoPlayerLayer {
        videoplayer.videoGravity = .resizeAspectFill
      }
    }
    super.init()
    NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForegroundNotification), name: .UIApplicationDidBecomeActive, object: nil)
  }

  // MARK: - Customization Options
  func show() {
    guard let videoplayerlayer = videoPlayerLayer, let videolayercontainer = videoLayerContainer else { return }
    videoplayerlayer.frame = videolayercontainer.frame
    videolayercontainer.layer.insertSublayer(videoplayerlayer, at: 0)
  }

  func destroy() {
    videoLayerContainer = nil
    videoPlayer = nil
    videoPlayerLayer = nil
    NotificationCenter.default.removeObserver(self)
  }

  // MARK: - Primary methods
  @objc func play() {
    guard let videoplayer = videoPlayer else { return }
    videoplayer.play()
  }

  @objc func pause() {
    guard let videoplayer = videoPlayer else { return }
    videoplayer.pause()
  }

  @objc private func loop() {
    guard let videoplayer = videoPlayer else { return }
    DispatchQueue.main.async {
      videoplayer.seek(to: kCMTimeZero)
      self.play()
    }
  }

  @objc func appWillEnterForegroundNotification() {
    play()
  }

  // MARK: - Private methods
  func addOverlayToVideo(usingColor color: UIColor) {
    guard let videolayercontainer = videoLayerContainer else { return }
    let colorOverlay = UIView()
    colorOverlay.backgroundColor = color.withAlphaComponent(0.6)
    colorOverlay.frame = videolayercontainer.frame
    videolayercontainer.insertSubview(colorOverlay, at: 1)
  }
}
