//
//  ViewController.swift
//  listenUp
//
//  Created by Marcos Mejias on 04/06/2017.
//  Copyright © 2017 Marcos Mejias. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UITextField!
    
    var data = [Song]()
    var position : Int = 0
    let urlItunes = "https://itunes.apple.com/search?term="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTable", for: indexPath) as! SongCell
        
        //cell.textLabel?.text = data[indexPath.row]
        //cell.songTitle.text = data[indexPath.row]
        //cell.artist.text = data[indexPath.row]
        cell.binding(song: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
 
    @IBAction func searchActionSong(_ sender: Any) {
        if (data.isEmpty == false) {
            data = [Song]()
        }
        
        let searching = searchBar.text?.replacingOccurrences(of: " ", with: "+")
        getDataFromURL(urlSong: searching!)
        //Init parameters
        //searchBar.text = ""
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino = segue.destination as! PlayViewController
        destino.songCell = data[(tableView.indexPathForSelectedRow?[1])!]
    }

    func getDataFromURL(urlSong: String) {
        let url = URL(string: urlItunes+urlSong)
        URLSession.shared.dataTask(with:url!) { (dataJSONText, response, error) in
            if error == nil {
                do {
                    NSLog("https://itunes.apple.com/search?term="+urlSong,1)
                    
                    let parsedData = try JSONSerialization.jsonObject(with: dataJSONText!) as! [String:Any]
                    let songs = parsedData["results"] as! [Any]
                    //loop of songs and add the infot to song class
                    for dictSong in songs {
                        let song = dictSong as! [String:Any]
                        self.addToSongClass(song: song)
                    }
                    self.tableView.reloadData()
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
    }
    
    func addToSongClass(song : [String:Any]) {
        var collectionName = ""
        var collectionCensoredName = ""
        var previewUrl = ""
        
        let wrapperType = song["wrapperType"] as! String
        let kind = song["kind"] as! String
        let artistName = song["artistName"] as! String
        
        if (song["collectionName"] != nil) {
           collectionName = song["collectionName"] as! String
        }
        
        if (song["collectionCensoredName"] != nil) {
            collectionCensoredName = song["collectionCensoredName"] as! String
        }
        
        if (song["previewUrl"] != nil) {
            previewUrl = song["previewUrl"] as! String
        }
        
        let trackName = song["trackName"] as! String
        let trackCensoredName = song["trackCensoredName"] as! String
        let artworkUrl = song["artworkUrl100"] as! String
        let trackPrice = song["trackPrice"] as! Int
        let releaseDate = song["releaseDate"] as! String
        let trackTimeMillis = song["trackTimeMillis"] as! Int
        let currency = song["currency"] as! String
        let primaryGenreName = song["primaryGenreName"] as! String
        
        data.append(Song(wrapperType: wrapperType, kind: kind, artistName: artistName, collectionName: collectionName, trackName: trackName, collectionCensoredName: collectionCensoredName, trackCensoredName: trackCensoredName, artworkUrl: artworkUrl, trackPrice: trackPrice, releaseDate: releaseDate, trackTimeMillis: trackTimeMillis, currency: currency, primaryGenreName: primaryGenreName, previewUrl: previewUrl))
    }
    
    
    
    

}
