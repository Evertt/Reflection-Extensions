@testable import Reflection

extension Metadata {
    struct Enum : NominalType {
        static let kind: Kind? = .enum
        var nominalTypeDescriptorOffsetLocation: Int {
            return 1
        }
        var pointer: UnsafePointer<_Metadata._Enum>
    }
}

extension _Metadata {
    struct _Enum {
        var kind: Int
        var nominalTypeDescriptorOffset: Int
        var parent: Metadata?
    }
}
