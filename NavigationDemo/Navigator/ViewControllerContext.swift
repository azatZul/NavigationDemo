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

protocol ViewControllerContextInfo {
    func isEqual(to info: ViewControllerContextInfo?) -> Bool
}

extension ViewControllerContextInfo where Self: Equatable {
    func isEqual(to info: ViewControllerContextInfo?) -> Bool {
        guard let info = info as? Self else { return false }
        return self == info
    }
}

struct ViewControllerContext: Equatable {
    public let screenType: String
    public let info: ViewControllerContextInfo?

    static func == (lhs: ViewControllerContext, rhs: ViewControllerContext) -> Bool {
        guard lhs.screenType == rhs.screenType else { return false }
        guard (lhs.info != nil) || (rhs.info != nil) else { return true }
        if let lInfo = lhs.info {
            return lInfo.isEqual(to: rhs.info)
        } else if let rInfo = rhs.info {
            return rInfo.isEqual(to: lhs.info)
        }
        return true
    }
}

