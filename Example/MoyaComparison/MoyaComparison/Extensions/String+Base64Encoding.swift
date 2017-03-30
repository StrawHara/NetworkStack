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

import Foundation

extension String {
  
  /// Encode String to base 64
  ///
  /// - Returns: return base64 String encoded
  func convertTobase64() -> String {
    guard let dataToConvert = self.data(using: .utf8) else {
      logger.error(.encoding, "Failed to encode string to base64 = \(self)")
      return ""
    }
    let base64String: String = dataToConvert.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
    return base64String
  }
}
