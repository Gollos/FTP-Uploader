//
//  CommandWith.swift
//  FTP-UploaderReduxState
//
//  Created by Golos on 3/3/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

final class CommandWith<T> {
    private let action: (T) -> Void
    
    init(action: @escaping (T) -> Void) {
        self.action = action
    }
    
    func perform(with value: T) {
        action(value)
    }
    
    func dispatched(on queue: DispatchQueue) -> CommandWith {
        return CommandWith { value in
            queue.async {
                self.perform(with: value)
            }
        }
    }
}

// MARK: Hashable
extension CommandWith: Hashable {
    static func == (lhs: CommandWith<T>, rhs: CommandWith<T>) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
}
