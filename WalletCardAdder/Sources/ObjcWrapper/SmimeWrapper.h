//
//  SmimeWrapper.h
//  WalletCardAdder
//
//  Created by JSP_MacBookPro on 2018. 8. 25..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SmimeWrapper : NSObject

- (NSData *) sign_smime:(char *)content certificate:(char *)certificate privateKey:(char *)privateKey intermediateCA:(char *)intermediateCA;

@end
