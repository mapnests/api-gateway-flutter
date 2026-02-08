//
//  TNApiGatewayCrypto.h
//  TNMapSDK
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TNApiGatewayCrypto : NSObject

/// Equivalent to nativeGenerateAESKey()
+ (NSString *)generateAESKey;

/// Equivalent to nativeMethod()
+ (NSDictionary<NSString *, NSString *> *)encryptPayloadForHeaders:(NSString *)jsonString
                                                     publicKeyPEM:(NSString *)publicKeyPEM
                                                     dataIdentity:(NSString *)dataIdentity
                                                   clientIdentity:(NSString *)clientIdentity;

/// Equivalent to nativeDataIdentityMethod()
+ (NSString *)encryptAESKey:(NSString *)aesKeyBase64
               publicKeyPEM:(NSString *)publicKeyPEM;

/// Equivalent to nativeClientIdentityMethod()
+ (NSString *)encryptClientPayload:(NSString *)jsonString
                     aesKeyBase64:(NSString *)aesKeyBase64;

/// Equivalent to nativeGetServerTime()
+ (NSTimeInterval)fetchServerTime;

@end

NS_ASSUME_NONNULL_END
