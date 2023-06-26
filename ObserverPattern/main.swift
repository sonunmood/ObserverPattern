//
//  main.swift
//  ObserverPattern
//
//  Created by Sonun on 25/6/23.
//

import Foundation

protocol DeliverySystem {
    func addObserver(_ observer: Observer)
    func notifyObserver()
}

protocol Observer {
    func update()
}

class DeliveryService: DeliverySystem {
    
    private var observers: [Observer] = []
    private var currentLocation: String = ""
    
    func addObserver(_ observer: Observer) {
        observers.append(observer)
    }
    
    func notifyObserver() {
        for observer in observers {
            observer.update()
        }
    }
    
    func setLocation(_ location: String){
        currentLocation = location
        notifyObserver()
    }
    
    func getCurrentLocation() -> String {
        return currentLocation
    }
}

class Customer: Observer {
    
    private let deliveryService: DeliveryService
    
    init(deliveryService: DeliveryService) {
        self.deliveryService = deliveryService
        deliveryService.addObserver(self)
    }
    
    func update() {
        let location = deliveryService.getCurrentLocation()
        print("Клиент: Обновлено местоположение посылки - \(location)")
    }
    
    
}

class DeliveryDriver: Observer {
    
    private let deliveryService: DeliveryService
    
    init(deliveryService: DeliveryService) {
        self.deliveryService = deliveryService
        deliveryService.addObserver(self)
    }
    
    func update() {
        let location = deliveryService.getCurrentLocation()
        print("Водитель доставки: Обновлено местоположение посылки - \(location)")
    }
}

var deliveryService = DeliveryService()

var customer = Customer(deliveryService: deliveryService)
var deliveryDriver = DeliveryDriver(deliveryService: deliveryService)

deliveryService.setLocation("В пути")
deliveryService.setLocation("Доставлено")
