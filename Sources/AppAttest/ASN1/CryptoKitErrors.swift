#if (os(macOS) || os(iOS) || os(watchOS) || os(tvOS)) && CRYPTO_IN_SWIFTPM && !CRYPTO_IN_SWIFTPM_FORCE_BUILD_API
@_exported import CryptoKit
#else
/// Errors thrown in CryptoKit
/// - incorrectKeySize: A key is being deserialized with an incorrect key size.
/// - incorrectParameterSize: The number of bytes passed for a given argument is incorrect.
/// - authenticationFailure: The authentication tag or signature is incorrect.
/// - underlyingCoreCryptoError: An unexpected error at a lower-level occured.
/*public enum CryptoKitError: Error {
 case incorrectKeySize,
 incorrectParameterSize,
 authenticationFailure,
 underlyingCoreCryptoError(error: Int32)
 }*/

/// Errors encountered when parsing ASN.1 formatted keys.
public enum CryptoKitASN1Error: Error {
    /// The ASN.1 tag for this field is invalid or unsupported.
    case invalidFieldIdentifier,
         
         /// The ASN.1 tag for the parsed field does not match the required format.
         unexpectedFieldType,
         
         /// An invalid ASN.1 object identifier was encountered.
         invalidObjectIdentifier,
         
         /// The format of the parsed ASN.1 object does not match the format required for the data type
         /// being decoded.
         invalidASN1Object,
         
         /// An ASN.1 integer was decoded that does not use the minimum number of bytes for its encoding.
         invalidASN1IntegerEncoding,
         
         /// An ASN.1 field was truncated and could not be decoded.
         truncatedASN1Field,
         
         /// The encoding used for the field length is not supported.
         unsupportedFieldLength,
         
         /// It was not possible to parse a string as a PEM document.
         invalidPEMDocument
}
#endif
