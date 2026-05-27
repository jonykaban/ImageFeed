//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Никита Федоров on 23.05.2026.
//
import UIKit

final class SingleImageViewController: UIViewController {
    @IBOutlet weak private var singleImageView: UIImageView!
    
    @IBOutlet weak private var scrollView: UIScrollView!
    
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleImageView.image = image
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
