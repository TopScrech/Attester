#if (os(macOS) || os(iOS) || os(watchOS) || os(tvOS)) && CRYPTO_IN_SWIFTPM && !CRYPTO_IN_SWIFTPM_FORCE_BUILD_API
@_exported import CryptoKit
#else

// For temporary purposes we pretend that ArraySlice is our "bigint" type. We don't really need anything else.
extension ArraySlice: ASN1Serializable where Element == UInt8 {}

extension ArraySlice: ASN1Parseable where Element == UInt8 {}

extension ArraySlice: ASN1IntegerRepresentable where Element == UInt8 {
    // We only use unsigned "bigint"s
    static var isSigned: Bool {
        false
    }
    
    init(asn1IntegerBytes: ArraySlice<UInt8>) throws {
        self = asn1IntegerBytes
    }
    
    func withBigEndianIntegerBytes<ReturnType>(_ body: (ArraySlice<UInt8>) throws -> ReturnType) rethrows -> ReturnType {
        try body(self)
    }
}
#endif
