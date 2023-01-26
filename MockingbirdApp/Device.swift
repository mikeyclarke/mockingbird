public enum DeviceError: Error {
    case unknownDevice
}

public enum DeviceType: String {
    case phone
    case pad
    case mac
}

#if os(macOS)
public class Device {
    static public func type() throws -> DeviceType {
        return DeviceType.mac
    }

    static public func isMac() -> Bool {
        return true
    }

    static public func isPad() -> Bool {
        return false
    }

    static public func isPhone() -> Bool {
        return false
    }
}
#else
import UIKit

public class Device {
    static public func type() throws -> DeviceType {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return DeviceType.pad
        }

        if UIDevice.current.userInterfaceIdiom == .phone {
            return DeviceType.phone
        }

        throw DeviceError.unknownDevice
    }

    static public func isMac() -> Bool {
        return false
    }

    static public func isPad() -> Bool {
        return try! Self.type() == DeviceType.pad
    }

    static public func isPhone() -> Bool {
        return try! Self.type() == DeviceType.phone
    }
}
#endif
