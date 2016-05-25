//
//  ViewController.swift
//  Musica
//
//  Created by Juan Jose Renteria on 16/05/16.
//  Copyright © 2016 Juan Jose Renteria. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var tituloCancion: UILabel!
    
    @IBOutlet weak var volumenControl: UIStepper!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var fotoCancion: UIImageView!
    var arregloCanciones: [Cancion] = []
    var reproductor : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tituloCancion.text = "  "
        arregloCanciones.append( Cancion(path: "LINKINPARK", nombreFoto: "LINKINPARK.png", titulo: "What ive done") )
        arregloCanciones.append( Cancion(path: "RickSpringfieldHQ", nombreFoto: "RickSpringfieldHQ.jpg", titulo: "Jessie's Girl") )
        
        arregloCanciones.append( Cancion(path: "BEATLES", nombreFoto: "BEATLES.jpg", titulo: "Beatles") )
        arregloCanciones.append( Cancion(path: "ELVIS", nombreFoto: "ELVIS.jpg", titulo: "All Shook") )
        arregloCanciones.append( Cancion(path: "aerosmith-cryin", nombreFoto: "aerosmith-cryin.jpeg", titulo: "Cryin") )
    }

    // Mark UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arregloCanciones.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arregloCanciones[ row ].titulo
    }
    
    // Mark UIPickerViewDelegate
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sonidoUrl = NSBundle.mainBundle().URLForResource( arregloCanciones[ row ].path, withExtension: "mp3")
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: sonidoUrl!)
            tituloCancion.text = arregloCanciones[row].titulo
            fotoCancion.image = UIImage(named: arregloCanciones[row].nombreFoto)
            reproducirMusica()
            
        } catch {
            print( "Error al reproducir el sonido" )
        }
    
    }
  
    
    func reproducirMusica() {
        if !reproductor.playing {
            reproductor.play()
        }
    }
    
    @IBAction func play(sender: UIButton) {
        reproducirMusica()
    }
    
    @IBAction func pause(sender: UIButton) {
        if reproductor.playing {
            reproductor.pause()
        }
    }
    
    @IBAction func stop(sender: UIButton) {
        if reproductor.playing {
            reproductor.stop()
            reproductor.currentTime = 0
        }
    }
    
    @IBAction func randomPlay(sender: UIButton) {
        
        let row = Int( arc4random_uniform( UInt32(arregloCanciones.count )) )
        picker.selectRow(row, inComponent: 0, animated: true)
        pickerView(self.picker, didSelectRow: row, inComponent: 0 )
    }
  
    // El valor de volumen entre 0 y 1
    @IBAction func volumen(sender: UIStepper) {
        reproductor.volume = Float( sender.value / 100 )
    }
    
    
}

