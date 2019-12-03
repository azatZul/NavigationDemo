// The MIT License (MIT)
//
// Copyright (c) 2019 Azat Zulkarniaev
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

protocol TopViewControllerProvider {
    var topViewController: UIViewController? { get }
}

typealias RootViewControllerProvider = () -> UIViewController?

final class DefaultTopViewControllerProvider: TopViewControllerProvider {
    private let rootViewControllerProvider: RootViewControllerProvider

    init(rootViewControllerProvider: @escaping RootViewControllerProvider = { UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController }) {
        self.rootViewControllerProvider = rootViewControllerProvider
    }

    var topViewController: UIViewController? {
        guard let root = self.rootViewControllerProvider() else { return nil }
        return self.traverseViewControllersHierarchy(startingFrom: root)
    }

    private func traverseViewControllersHierarchy(startingFrom root: UIViewController) -> UIViewController? {
        var currentViewController: UIViewController? = root
        while currentViewController != nil {
            if let customContainer = currentViewController as? TopViewControllerProvider {
                currentViewController = customContainer.topViewController
            } else if let presentedController = currentViewController?.presentedViewController {
                currentViewController = presentedController
            } else {
                break
            }
        }
        return currentViewController
    }
}
