#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TNApiGatewayCrypto : NSObject

+ (NSArray<NSString *> *)tnGenerateECDHKeypair;
+ (NSString *)tnGenerateAESKeyWithServerPublicKey:(NSString *)serverPublicKey
                                  clientPrivateKey:(NSString *)clientPrivateKey;
+ (NSString *)tnEncryptClientIdentity:(NSString *)payloadJson
                        aesKeyBase64:(NSString *)aesKeyB64;
+ (NSString *)tnEncryptAESKey:(NSString *)aesKeyBase64
                 publicKeyPEM:(NSString *)serverPublicKey;
+ (int64_t)tnGetServerTime;

// ⚡ Add these
+ (NSString *)base64Encode:(NSString *)input;
+ (NSString *)base64EncodeData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
