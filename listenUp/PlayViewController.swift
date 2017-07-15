//
//  PlayViewController.swift
//  listenUp
//
//  Created by Marcos Mejias on 05/06/2017.
//  Copyright © 2017 Marcos Mejias. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var artisLabel: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var trackImg: UIImageView!
    @IBOutlet weak var collectSong: UILabel!
    
    var songCell : Song? = nil
    var trackSongURL : String? = nil
    var audioPlayer: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.downloadImage((songCell?.artworkUrl!)!, inView: trackImg)
        artisLabel.text = songCell?.artistName
        songName.text = songCell?.trackName
        collectSong.text = songCell?.collectionName
        trackSongURL = songCell?.previewUrl
        
        //Download the song
        self.downloadTheSong(urlSong: trackSongURL!)
        if let AudioFileTemp = URL(string: trackSongURL!){
            audioPlayer = AVPlayer(url: AudioFileTemp)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func PlayButton(_ sender: Any) {
        if (audioPlayer == nil) {
            if let AudioFileTemp = URL(string: trackSongURL!){
                audioPlayer = AVPlayer(url: AudioFileTemp)
            }
        }
        audioPlayer.play()
    }
    
    @IBAction func stopButton(_ sender: Any) {
        if (audioPlayer != nil) {
            audioPlayer.pause()
        }
        audioPlayer = nil
    }
    
    @IBAction func PauseButton(_ sender: Any) {
        audioPlayer.pause()
    }
    
    func downloadImage(_ uri : String, inView: UIImageView){
        let url = URL(string: uri)
        let task = URLSession.shared.dataTask(with: url!) {responseData,response,error in
            if error == nil{
                if let data = responseData {
                    DispatchQueue.main.async {
                        inView.image = UIImage(data: data)
                    }
                }else {
                    NSLog("no data",1)
                }
            }
        }
        task.resume()
    }
    
    func downloadTheSong(urlSong : String) {
        //Check if the song exist
        let finalExtension = urlSong.components(separatedBy: ".")
        if (finalExtension[(finalExtension.count)-1] != "m4a"){
            let alert = UIAlertController(title: "Warning", message: "Sorry!\nThe song Not exist", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
