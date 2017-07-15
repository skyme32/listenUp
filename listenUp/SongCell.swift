//
//  SongCell.swift
//  listenUp
//
//  Created by Marcos Mejias on 04/06/2017.
//  Copyright © 2017 Marcos Mejias. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var inView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func binding(song : Song) {
        songTitle.text = song.trackName
        artist.text = song.artistName
        self.downloadImage(song.artworkUrl!, inView : inView)
    }
    
    func downloadImage(_ uri : String, inView: UIImageView){
        print("")
        let url = URL(string: uri)
        let task = URLSession.shared.dataTask(with: url!) {responseData,response,error in
            if error == nil{
                if let data = responseData {
                    DispatchQueue.main.async {
                        inView.image = UIImage(data: data)
                    }
                }else {
                    print("no data")
                }
            }
        }
        task.resume()
    }
    
    
    /*
    func downloadFromUrl(stringURL: String, handler: DataResultDelegate) {
        //Inicializamos parámetros de la petición
        let url = NSURL(string: stringURL)!
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.timeoutInterval = 8
        //Definimos comportamiento para el resultado de la petición
        let asyncDownloadTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            guard let data = data else {
                if let errorCallback = handler.error {
                    errorCallback()
                }
                return
            }
            handler.success(data)
        }
        //Realizamos la petición
        asyncDownloadTask.resume()
    }*/
    
    


}
