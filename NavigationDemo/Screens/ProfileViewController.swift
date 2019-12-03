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

final class ProfileViewController: UIViewController {
    private let globalRouter: ViewControllerContextRouterProtocol

    init(globalRouter: ViewControllerContextRouterProtocol) {
        self.globalRouter = globalRouter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        self.view.backgroundColor = .white
        self.addNavigationButton()
    }

    private func addNavigationButton() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Go to Contact 1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        self.view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        ])
        button.addTarget(self, action: #selector(onNavigationButtonTap), for: .touchUpInside)
    }

    @objc
    private func onNavigationButtonTap() {
        let context1 = ViewControllerContext(screenType: ScreenType.contacts.rawValue, info: nil)
        self.globalRouter.navigateToContext(context1, animated: true)
        let context2 = ViewControllerContext(screenType: ScreenType.chat.rawValue, info: "Contact 1")
        self.globalRouter.navigateToContext(context2, animated: true)
    }
}

extension ProfileViewController: ViewControllerContextHolder {
    var currentContext: ViewControllerContext? {
        return ViewControllerContext(screenType: ScreenType.profile.rawValue, info: nil)
    }
}
