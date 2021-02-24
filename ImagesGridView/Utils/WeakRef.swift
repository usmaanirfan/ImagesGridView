//
//  WeakRef.swift
//  ImagesGridView
//
//  Created by Usman Ansari on 21/02/21.
//  Copyright © 2021 Usman Ansari. All rights reserved.
//

import Foundation

public final class WeakRef<T: AnyObject> {
    public weak var object: T?

    public init(_ object: T) {
        self.object = object
    }
}
