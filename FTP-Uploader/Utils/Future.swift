//
//  Future.swift
//  FTP-Uploader
//
//  Created by Golos on 3/9/19.
//  Copyright © 2019 ITC. All rights reserved.
//

import Foundation

final public class Future<Value> {
    typealias Promise = (Value) -> Void

    init(value: Value) {
        self.complete(with: value)
    }

    init(work: (@escaping Promise) -> Void) {
        work(self.complete(with:))
    }

    private var value: Value?

    private func complete(with value: Value) {
        guard self.value == nil else { return }

        self.value = value

        for callback in self.callbacks {
            callback(value)
        }

        self.callbacks = []
    }

    private var callbacks: [Promise] = []

    @discardableResult func onComplete(callback: @escaping Promise) -> Future {
        if let value = self.value {
            callback(value)
        } else {
            self.callbacks.append(callback)
        }

        return self
    }
}

extension Future where Value: ResultType {
    typealias ResultValue = Value

    @discardableResult func onSuccess(call callback: @escaping (ResultValue.ValueType) -> Void) -> Future {
        return self.onComplete { result in
            guard case let .success(value) = result.asResult else { return }
            callback(value)
        }
    }

    @discardableResult func onError(call callback: @escaping (APIError) -> Void) -> Future {
        return self.onComplete { result in
            guard case let .failure(error) = result.asResult else { return }
            callback(error)
        }
    }
}
