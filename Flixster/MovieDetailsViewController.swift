//
//  MovieDetailsViewController.swift
//  Flixster
//
//  Created by Lauren Work on 9/27/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    var movie: [String:Any]!

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        //get poster for movie
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        posterView.af.setImage(withURL: posterURL!)
        
        //get background image for movie
        let largeBaseURL = "https://image.tmdb.org/t/p/w780"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: largeBaseURL + backdropPath)
        backdropView.af.setImage(withURL: backdropURL!)
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPoster(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        posterView.isUserInteractionEnabled = true
        posterView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func didTapPoster(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "trailerSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerViewController = segue.destination as! TrailerViewController
        trailerViewController.movie = movie
    }

}
