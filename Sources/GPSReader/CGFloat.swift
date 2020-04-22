
#if canImport(Darwin)
import Darwin
#else
import Glibc
#endif

import Foundation






extension CGFloat {

    init?(string: String) {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "us_US")
        
        guard let number = formatter.number(from: string) else {
            return nil
        }
        
        self.init(number.floatValue)
    }

}
