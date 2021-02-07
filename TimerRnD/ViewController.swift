//
//  ViewController.swift
//  TimerRnD
//
//  Created by 고종찬 on 2021/02/07.
//

import UIKit
//사운드 킷 임포트
import AVFoundation

class ViewController: UIViewController {
    //매초 마다 시간 출력
    var timeSelector : Selector = #selector(ViewController.countTime)
    var mTimer : Timer?
    var counter = 0
    //AV 플레이어 임포트
    var audioPlayer = AVAudioPlayer()
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var txtCounter: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //Start 버튼 누르면 시작
    @IBAction func btnStart(_ sender: UIButton) {
        let checkCounter = checkNil(check: txtCounter.text!)
        if checkCounter == 1{
        //카운트가 텍스트에 적은 숫자가 나올수 있도록 장치
        counter = Int(txtCounter.text!)!+1
        mTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: timeSelector, userInfo: nil, repeats: true)
            txtCounter.isHidden = true
        }else{
            //빈칸일 경우 채워넣으라고 알람 때림
            nilAlert()
        }
        
    }
    
    //카운터 objc 함수
    @objc func countTime(){
        //Counter가 0으로 수렴하면
        if counter == 0{
            //0초 되었다고 알림
            counterZeroAlert()
            //text 비활성화 된거 다시 활성화
            txtCounter.isHidden = false
            //잘했다고 소리 띄우기
            playSound(file: "01_잘했어요", ext: "mp3")
            //타이머 멈추기
            if let timer = mTimer {
                if(timer.isValid){
                    timer.invalidate()
                }
            }
            
            
            
        }else{
            //카운터가 1초씩 사라짐
            
            counter -= 1
            lblTimer.text = String(counter)
        }
        
        
    }
    
    //nil값 체크 함수
    func checkNil(check :String) -> Int {
        let trimCheck = check.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimCheck.isEmpty{
            return 0
        }else{
            return 1
        }
    }
    
    //nil 값 알람
    func nilAlert(){
        let alertController = UIAlertController(title: "빈칸", message: "시간을 채워주세요", preferredStyle: UIAlertController.Style.alert  )
        let alertAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAlertAction)
        present(alertController, animated: true, completion: nil)
        
    }
    //0초되면 알려주는 함수
    func counterZeroAlert(){
        let alertController = UIAlertController(title: "완료", message: "고생하셨습니다!", preferredStyle: UIAlertController.Style.alert  )
        let alertAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAlertAction)
        present(alertController, animated: true, completion: nil)
        
    }
    //사운드 나오는 함수
    func playSound(file: String , ext: String) -> Void {
        do{
            let url = URL.init(fileURLWithPath: Bundle.main.path(forResource: file, ofType: ext) ?? "mp3")
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        }catch let error{
            NSLog(error.localizedDescription)
        }
    }
    
}

