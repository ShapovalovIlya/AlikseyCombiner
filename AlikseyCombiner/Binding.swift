//
//  Binding.swift
//  AlikseyCombiner
//
//  Created by Илья Шаповалов on 20.09.2023.
//

import Foundation
import UIKit

extension UILabel: Listener {
    typealias Output = String
    
    func receive(_ value: Output) {
        self.text = value
    }
}

protocol Listener {
    associatedtype Output
    
    func receive(_ value: Output)
}

final class Binding<V, L> where L: Listener, L.Output == V {
    private(set) var wrapped: V {
        didSet {
            subscribers.forEach {
                $0.receive(wrapped)
            }
        }
    }
    
    private var subscribers: [L] = []
    
    //MARK: - init(_:)
    init(_ wrapped: V) {
        self.wrapped = wrapped
    }
    
    func bind(_ listener: L) {
        subscribers.append(listener)
    }
    
    func map<T>(transform: (V) -> T) -> Binding<T, L> {
        let result = transform(wrapped)
        return Binding<T, L>(result)
    }
}


