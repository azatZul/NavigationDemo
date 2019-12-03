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

import Foundation

protocol ViewControllerContextRouterProtocol {
    func navigateToContext(_ context: ViewControllerContext, animated: Bool)
}

final class ViewControllerContextRouter: ViewControllerContextRouterProtocol {
    private let topViewControllerProvider: TopViewControllerProvider
    private let viewControllersFactory: ViewControllersByContextFactory
    private let transitionProvider: ViewControllerContextTransitionProvider
    private let contextSwitchers: [ViewControllerContextSwitcher]

    init(topViewControllerProvider: TopViewControllerProvider,
         viewControllersFactory: ViewControllersByContextFactory,
         transitionProvider: ViewControllerContextTransitionProvider,
         contextSwitchers: [ViewControllerContextSwitcher]) {
        self.topViewControllerProvider = topViewControllerProvider
        self.viewControllersFactory = viewControllersFactory
        self.transitionProvider = transitionProvider
        self.contextSwitchers = contextSwitchers
    }

    func navigateToContext(_ context: ViewControllerContext, animated: Bool) {
        let topViewController = self.topViewControllerProvider.topViewController
        if let contextHolder = topViewController as? ViewControllerContextHolder, contextHolder.currentContext == context {
            return
        }
        if let switcher = self.contextSwitchers.first(where: { $0.canSwitch(to: context) }) {
            switcher.switchContext(to: context, animated: animated)
            return
        }
        guard let viewController = self.viewControllersFactory.viewController(for: context) else { return }
        let navigation = self.transitionProvider.navigation(for: context)
        navigation.navigate(from: self.topViewControllerProvider.topViewController,
                            to: viewController,
                            animated: true)
    }
}
