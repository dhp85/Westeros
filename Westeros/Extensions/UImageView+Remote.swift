//
//  UImageView+Remote.swift
//  Westeros
//
//  Created by Diego Herreros Parron on 12/9/24.
//

import UIKit

extension UIImageView {
    func setImage(url: URL) {
        // Capturamos self para no crear despendencias circulares
        downloadWithURLSession(url: url) { [weak self] image in
            // le decimos al sistema que todo el trabajo asincrono que esta en otro hilo lo vamos a llevar al hilo principal "main".
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
    
    // Este metodo obtiene una imagen a partir
    // de una URL. Utiliaza URLSession para ello
    private func downloadWithURLSession(url: URL, completion: @escaping (UIImage?) -> Void) {
        
        // No se van a manejar errores para simplificar el ejercicio.
        URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, _ in
            guard let data, let image = UIImage(data: data) else {
                // No puedo desempaquetar data ni la imagen
                // llamo al completion con nil
                completion(nil)
                return
                
            }
            completion(image)
        }
        .resume()
    }
}
