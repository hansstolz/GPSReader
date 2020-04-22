#if canImport(Darwin)
import Darwin
import GetExif
#else
import Glibc
import GetExifLinux
#endif

import Foundation




public struct GPSReader {
    
func getCoordinates(_ data:Data)->(lat:CGFloat?,long:CGFloat?) {
        
    let exifData = exif_data_new_from_data([UInt8](data), UInt32(data.count))
    

    //let exifData = exif_data_new_from_file("/Users/go/Desktop/dogballs.jpg")
    
    if let ifd = exifData?.pointee.ifd, let gpsExif = ifd.3 {
        
        let tagLong = exif_content_get_entry(gpsExif,ExifTag(rawValue: ExifTag.RawValue(EXIF_TAG_GPS_LONGITUDE)));
        
        let tagLat = exif_content_get_entry(gpsExif,ExifTag(rawValue: ExifTag.RawValue(EXIF_TAG_GPS_LATITUDE)));

        let long = gpsValueFromTag(tag: tagLong)
        let lat = gpsValueFromTag(tag: tagLat)
        return (lat,long)
    }
    return (nil,nil)
}

private func gpsValueFromTag(tag: UnsafeMutablePointer<ExifEntry>?)->CGFloat? {
    if let tag=tag {
        var buffer: [Int8] = [Int8](repeating: 0, count: 30)
    
        exif_entry_get_value(tag, &buffer, UInt32(MemoryLayout<UInt8>.size * 30));

        //let b = buffer.map {  return UInt8($0)}.filter { $0 != 0}
        //let str = String(decoding: b, as: UTF8.self)
        
        
        return strToCoordinate(str: String(cString: buffer))
        
    }
    
    return nil
}

private func strToCoordinate(str:String)->CGFloat? {
    let comps = str.components(separatedBy: ", ")
    guard comps.count == 3 else {
        return nil
    }
    
    if comps[1].starts(with: "0") && comps[2].starts(with: "0") {
        return CGFloat(string:comps[0])
    } else {
        let grad = CGFloat(string:comps[0])
        let minutes = CGFloat(string:comps[1])
        let secs = CGFloat(string:comps[2])
        if let grad=grad, let minutes=minutes, let secs=secs {
        return grad + minutes / 60 + secs / 3600
        }
    }
    
    return nil
}
    
}
