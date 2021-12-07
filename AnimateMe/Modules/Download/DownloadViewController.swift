//
//  DownloadViewController.swift
//  AnimateMe
//
//  Created by Andres Gutierrez on 12/5/21.
//

import UIKit
import Lottie

class DownloadViewController: UIViewController{
    
    @IBOutlet weak var animationView: AnimationView!
    
    //Set markers for different "actions" within animation
    enum DownloadKeyFrames: CGFloat{
        // case key = .rawValue
        case startDownload = 0
        case finishDownload = 180
        case downloadCompleted = 232
    }
                                
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Call to immediately begin downloading when view opens
        startDownload()
    }
   
    //MARK: - Functions
    
    // sets download progress
    private func progress(to progress: CGFloat) {

      // 1. We get the range of frames specific for the progress from 0-100%
      //let progressRange = ProgressKeyFrames.end.rawValue - ProgressKeyFrames.start.rawValue
      
        let progressRange = DownloadKeyFrames.finishDownload.rawValue - DownloadKeyFrames.startDownload.rawValue
        
      // 2. Then, we get the exact frame for the current progress
      //let progressFrame = progressRange * progress
      
        let progressFrame = progressRange*progress
        
      // 3. Then we add the start frame to the progress frame
      // Considering the example that we start in 140, and we moved 30 frames in the progress, we should show frame 170 (140+30)
      //let currentFrame = progressFrame + ProgressKeyFrames.start.rawValue
      
        let currentFrame = progressFrame + DownloadKeyFrames.startDownload.rawValue
        
      // 4. Manually setting the current animation frame
      //progressView?.currentFrame = currentFrame
      
        animationView?.currentFrame = currentFrame
        
      print("Downloading \((progress*100).rounded())%")
    }
    private func downloadingCompleted(){
        animationView.play(fromFrame: DownloadKeyFrames.finishDownload.rawValue, toFrame: DownloadKeyFrames.downloadCompleted.rawValue, loopMode: .none) { _ in
            
        }
    }
    
   
}
    // MARK: - Download Delegate

    extension DownloadViewController: URLSessionDownloadDelegate {
        
        private func startDownload() {

          // 1. URL to download from
          
          let url = URL(string: "https://archive.org/download/SampleVideo1280x7205mb/SampleVideo_1280x720_5mb.mp4")!
          
          // 2. Setup download task and start download
          
          let configuration = URLSessionConfiguration.default
          
          let operationQueue = OperationQueue()
          
          let session = URLSession(configuration: configuration, delegate: self, delegateQueue: operationQueue)
          
          let downloadTask = session.downloadTask(with: url)
          
          downloadTask.resume()
          
        }
      // handles download progress
      
      func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
      
        let percentDownloaded: CGFloat = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
        
          self.progress(to: percentDownloaded)
          
        }
      }
      // finishes download
      func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
      
        DispatchQueue.main.async {
        
          self.downloadingCompleted()
        }
      }
    }
    

