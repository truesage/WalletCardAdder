//
//  SmimeWrapper.m
//  WalletCardAdder
//
//  Created by JSP_MacBookPro on 2018. 8. 25..
//  Copyright © 2018년 TrueSage. All rights reserved.
//

#import "SmimeWrapper.h"

#include <openssl/bio.h>
#include <openssl/cms.h>
#include <openssl/err.h>
#include <openssl/pem.h>
#include <openssl/ssl.h>
#include <openssl/crypto.h>
#include <openssl/rand.h>
#include <openssl/pkcs12.h>

#include <string.h>

@implementation SmimeWrapper

X509 *getCert(const char *certificate) {
    BIO *membuf = BIO_new(BIO_s_mem());
    BIO_puts(membuf, certificate);
    X509 *x509 = PEM_read_bio_X509(membuf, NULL, NULL, NULL);
    return x509;
}

EVP_PKEY *getKey(const char *privateKey) {
    BIO *membuf = BIO_new(BIO_s_mem());
    BIO_puts(membuf, privateKey);
    EVP_PKEY *key = PEM_read_bio_PrivateKey(membuf, NULL, 0, NULL);
    return key;
}

PKCS7 *getContainer(const char *encrypted) {
    BIO* membuf = BIO_new(BIO_s_mem());
    BIO_set_mem_eof_return(membuf, 0);
    BIO_puts(membuf, encrypted);
//    PKCS12* pkcs12 = d2i_PKCS12_bio(membuf, NULL);
    PKCS7* pkcs7 = SMIME_read_PKCS7(membuf, NULL);
    if (!pkcs7) {
        fprintf(stderr, "error: %ld\n", ERR_get_error());
    }
    return pkcs7;
}

STACK_OF(X509) *getSigner(const char *signerCert, PKCS7 *pkcs7) {
    
    int flag = PKCS7_NOINTERN;
    BIO *membuf = BIO_new(BIO_s_mem());
    BIO_puts(membuf, signerCert);
    CMS_ContentInfo *cmss = CMS_data_create(membuf, flag);
    STACK_OF(X509) *signX509 = CMS_get0_signers(cmss);
    STACK_OF(X509) *signer =  PKCS7_get0_signers(pkcs7, signX509, flag);
    return signer;
    
}

char *signData(X509 *cert ,PKCS7 *pkcs7, EVP_PKEY *pkey, STACK_OF(X509) *intermediateCA) {
    int flags = PKCS7_DETACHED | PKCS7_STREAM;
    BIO *out = BIO_new(BIO_s_mem());
//    PKCS7 *sig = PKCS7_sign(cert, pkey, intermediateCA, out, flags);
    if (!PKCS7_sign(cert, pkey, intermediateCA, out, flags)) {
        X509_free(cert);
        EVP_PKEY_free(pkey);
        PKCS7_free(pkcs7);
        fprintf(stderr, "Error sign PKCS#7 object: %ld\n", ERR_get_error());
        return NULL;
    }
    
    BUF_MEM* mem;
    BIO_get_mem_ptr(out, &mem);
    char *data = malloc(mem->length + 1);
    memcpy(data, mem->data, mem->length + 1);
    BIO_flush(out);
    BIO_free(out);
    return data;
    
}

- (NSData *) sign_smime:(char *)content certificate:(char *)certificate privateKey:(char *)privateKey intermediateCA:(char *)intermediateCA {

//-(NSData *) *sign_smime(const char *content, const char *certificate, const char *privateKey, const char *intermediateCA) {
    
    
    
    OpenSSL_add_all_algorithms();
    ERR_load_crypto_strings();
    
    X509 *cert = getCert(certificate);
    if (!cert) {
        return NULL;
    }
    
    EVP_PKEY *pkey = getKey(privateKey);
    if (!pkey) {
        X509_free(cert);
        return NULL;
    }
    
    PKCS7 *pkcs7 = getContainer(content);
    if (!pkcs7) {
        X509_free(cert);
        EVP_PKEY_free(pkey);
        return NULL;
    }
    
    STACK_OF(X509) *signer = getSigner(intermediateCA, pkcs7);
    if (!signer) {
        return NULL;
    }
    
    char *data = signData(cert, pkcs7, pkey, signer);
    
    X509_free(cert);
    EVP_PKEY_free(pkey);
    PKCS7_free(pkcs7);
    
    NSInteger dataLen = strlen(data);
    
    NSData *returnValue = [[NSData alloc]initWithBytes:data length:dataLen];
    
    return returnValue;
}

@end
