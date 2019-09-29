//
// Created by Thomas A. Smedmann on 27/09/2019.
// Copyright (c) 2019 Thomas A. Smedmann. All rights reserved.
//

import Foundation

class WebContentWebViewController: WebViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let url = URL(string: "https://www.apple.com")
        self.load(url: url!)
    }
}