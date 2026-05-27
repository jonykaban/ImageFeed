//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Никита Федоров on 23.05.2026.
//
import UIKit

final class SingleImageViewController: UIViewController {
    @IBOutlet weak private var singleImageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleImageView.image = image
    }
    
}
