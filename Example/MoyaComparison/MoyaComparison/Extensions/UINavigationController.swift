//
// Copyright 2017 niji
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit

extension UINavigationController {
  
  func setupBlackNavigationBar() {
    navigationBar.barTintColor = UIColor.black
    navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    navigationBar.isTranslucent = false
  }
  
  func setupTranslucentNavigationBar() {
    view.backgroundColor = UIColor.clear
    
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.shadowImage = UIImage()
    navigationBar.isTranslucent = true
    navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    
    automaticallyAdjustsScrollViewInsets = false
  }
}
