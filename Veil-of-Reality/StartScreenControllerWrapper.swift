//
//  StartScreenControllerWrapper.swift
//  Veil-of-Reality
//
//  Created by Andrew Zhao on 12/3/23.
//

import SwiftUI

struct StartScreenControllerWrapper: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> StartScreenController {
//        return StartScreenController()
//    }

    func makeUIViewController(context: Context) -> StartScreenController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let startScreenViewController = storyboard.instantiateViewController(withIdentifier: "StartScreenViewController") as? StartScreenController {
            startScreenViewController.username = ""
            startScreenViewController.password = ""
            startScreenViewController.newLifeOrNot = true
            return startScreenViewController
        } else {
            fatalError("Unable to instantiate StartScreenController")
        }
    }

    
    func updateUIViewController(_ uiViewController: StartScreenController, context: Context) {
        
    }
}
