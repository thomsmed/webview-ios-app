//
// Created by Thomas A. Smedmann on 27/09/2019.
// Copyright (c) 2019 Thomas A. Smedmann. All rights reserved.
//

import Foundation

class LocalContentWebViewController : WebViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let bundle = Bundle.main

        let filename = "index"
        let fileExtension = "html"
        let directory = "www"

        let indexUrl = bundle.url(forResource: filename, withExtension: fileExtension, subdirectory: directory)
        let indexPath = bundle.path(forResource: filename, ofType: fileExtension, inDirectory: directory)

        let wwwUrl = bundle.url(forResource: directory, withExtension: nil)
        let wwwPath = bundle.path(forResource: directory, ofType: nil)

        self.loadFileUrl(indexUrl!, allowingReadAccessTo: wwwUrl!)
    }
}