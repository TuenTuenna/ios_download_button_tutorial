//
//  ViewController.swift
//  downloadButton_tutorial
//
//  Created by Jeff Jeong on 2020/11/08.
//

import UIKit
import Loady
import Alamofire


class ViewController: UIViewController {
    
    @IBOutlet var myDownloadBtn: LoadyButton!
    
    @IBOutlet var uberlikeBtn: LoadyButton!
    @IBOutlet var fourPhaseBtn: LoadyFourPhaseButton!
    @IBOutlet var downloadBtn: LoadyButton!
    @IBOutlet var indicatorBtn: LoadyButton!
    @IBOutlet var androidBtn: LoadyButton!
    @IBOutlet var fillingBtn: LoadyButton!
    @IBOutlet var circleBtn: LoadyButton!
    @IBOutlet var appstoreBtn: LoadyButton!
    
    @IBOutlet var myBtns : [LoadyButton]!
    
    override func loadView() {
        super.loadView()
        myDownloadBtn.layer.cornerRadius = 8
        
        myBtns.forEach { (btnItem: LoadyButton) in
            btnItem.layer.cornerRadius = 8
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        uberlikeBtn.setAnimation(LoadyAnimationType.topLine())
        
        // 페이즈 버튼. - 일반, 다운로드중, 다운로드 완료, 에러발생
        fourPhaseBtn.loadingColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        let normalPhase = (title: "대기중", image: UIImage(systemName: "stopwatch"), background: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
        let loadingPhase = (title: "진행중..", image: UIImage(systemName: "paperplane.fill"), background: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        let successPhase = (title: "완료!", image: UIImage(systemName: "checkmark")?.withTintColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).withRenderingMode(.alwaysOriginal), background: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        let errorPhase = (title: "실패", image: UIImage(systemName: "flag.fill"), background: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
        fourPhaseBtn.setPhases(phases: .init(normalPhase: normalPhase,
                                             loadingPhase: loadingPhase,
                                             successPhase: successPhase,
                                             errorPhase: errorPhase))
        
        let downloadingLabel = (title: "다운로드 중입니다..." , font: UIFont.boldSystemFont(ofSize: 18), textColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
        let percentageLabel = (font: UIFont.boldSystemFont(ofSize: 14), textColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))
        let downloadedLabel = (title: "다운로드 완료! 👏" , font: UIFont.boldSystemFont(ofSize: 20), textColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        
        downloadBtn.setAnimation(LoadyAnimationType.downloading(with: .init(downloadingLabel: downloadingLabel,
                                                                            percentageLabel: percentageLabel,
                                                                            downloadedLabel: downloadedLabel)))
        downloadBtn.backgroundFillColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        indicatorBtn.setAnimation(LoadyAnimationType.indicator(with: .init(indicatorViewStyle: .light)))
//        indicatorBtn.setAnimation(LoadyAnimationType.indicator(with: .init(indicatorViewStyle: .black)))
        
        androidBtn.setAnimation(LoadyAnimationType.android())
        androidBtn.backgroundFillColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        androidBtn.loadingColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        fillingBtn.setAnimation(LoadyAnimationType.backgroundHighlighter())
        fillingBtn.backgroundFillColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        circleBtn.setAnimation(LoadyAnimationType.circleAndTick())
        circleBtn.backgroundFillColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        circleBtn.loadingColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        appstoreBtn.setAnimation(LoadyAnimationType.appstore(with: .init(shrinkFrom: .fromRight)))
        appstoreBtn.pauseImage = UIImage(systemName: "pause")?.withTintColor(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).withRenderingMode(.alwaysOriginal)
        appstoreBtn.backgroundFillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        appstoreBtn.loadingColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        
        // 다운로드 버튼 애니메이션 설정
        myDownloadBtn.setAnimation(LoadyAnimationType.backgroundHighlighter())
        myDownloadBtn.backgroundFillColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        myDownloadBtn.addTarget(self, action: #selector(onBtnClicked(sender:)), for: .touchUpInside)
        
        myBtns.forEach { (btnItem: LoadyButton) in
            btnItem.addTarget(self, action: #selector(onBtnClicked(sender:)), for: .touchUpInside)
        }
        
    }

    @objc fileprivate func onBtnClicked(sender: LoadyButton){
        print("ViewController - onBtnClicked() called")
        
        sender.stopLoading()
        
        // 들어온 버튼 설정
        sender.startLoading()
        
        if let button = sender as? LoadyFourPhaseButton {
            
            button.normalPhase()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                button.loadingPhase()
            }
        }
        
        // 더미 데이터 다운로드 api http://ipv4.download.thinkbroadband.com/5MB.zip
        let downloadApiUrl = "http://ipv4.download.thinkbroadband.com/5MB.zip"
        
        let progressQueue = DispatchQueue(label: "com.downloadButton_tutorial.progressQueue", qos: .utility)
        
        // 파일이 저장되는 경로
        let destination: DownloadRequest.Destination = { _, _ in
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            // 파일 확장 붙이기
//            let fileURL = documentsURL.appendingPathComponent("image.png")
            // removePreviousFile - 해당 경로에 파일이 존재한다면 지우기, createIntermediateDirectories - 중간 폴더 만들기

            return (documentsURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        AF.download(downloadApiUrl, to: destination)
            .downloadProgress(queue: progressQueue) { progress in
                print("Download Progress: \(progress.fractionCompleted)")
                
                let loadingPercent = progress.fractionCompleted * 100
                print("loadingPercent : \(loadingPercent)")
                
                DispatchQueue.main.async {
                    sender.update(percent: CGFloat(loadingPercent))
                }

            }
            .response { response in
            debugPrint(response)
               
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    sender.stopLoading()
                    if let button = sender as? LoadyFourPhaseButton {
                        button.successPhase()
                    }
                }
//            if response.error == nil, let imagePath = response.fileURL?.path {
//                let image = UIImage(contentsOfFile: imagePath)
//            }
        }
        
    } // onBtnClicked()

}

