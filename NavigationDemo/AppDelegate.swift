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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var tabsSwitcher = TabBarContextSwitcher()
    lazy var router: ViewControllerContextRouterProtocol = {
        let topViewControllerProvider = DefaultTopViewControllerProvider()
        let navigationStackChanger = NavigationStackChanger(topViewControllerProvider: topViewControllerProvider)
        let viewControllersFactory = DemoViewControllersByContextFactory()
        let router = ViewControllerContextRouter(topViewControllerProvider: DefaultTopViewControllerProvider(),
                                           viewControllersFactory: viewControllersFactory,
                                           transitionProvider: DemoViewControllerContextTransitionProvider(),
                                           contextSwitchers: [tabsSwitcher, navigationStackChanger])
        viewControllersFactory.globalRouter = router
        return router
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabBar = TabBarFactory(globalRouter: router).makeTabBar()
        self.tabsSwitcher.tabBar = tabBar
        let window = UIWindow()
        window.rootViewController = tabBar
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let parser = LinkParser()
        guard let context = parser.viewControllerContext(from: url) else { return false }
        self.router.navigateToContext(context, animated: true)
        return true
    }
}

