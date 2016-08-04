//
//  Service.m
//  KYPFanfou
//
//  Created by trainer on 7/27/16.
//  Copyright © 2016 trainer. All rights reserved.
//

#import "Service.h"
#import <TDOAuth/TDOAuth.h>
#import "APIContant.h"
#import "CoreDataStack+User.h"

@interface Service ()
@property (nonatomic,strong) NSURLSession *session;
@end

@implementation Service
//单例
+(instancetype)sharedInstance {
    static Service *service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[Service alloc] init];
        
    });
    return service;
}
//覆写init
-(instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 60;
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return  self;
}
#pragma mark - XAuth 授权
//xAuth
//最终目的是获取到access token and access secret
- (void)authoriseWithUserName:(NSString *)userName password:(NSString *)password success:(void (^)(NSString *token,NSString *tokenSecret))sucess  {
    
    NSURLRequest *request = [TDOAuth URLRequestForPath:API_ACCESS_TOKEN
                                         GETParameters:[NSDictionary dictionaryWithObjectsAndKeys:
                                                        userName, @"x_auth_username",
                                                        password, @"x_auth_password",
                                                        @"client_auth", @"x_auth_mode",
                                                        nil]
                                                  host:FANFOU_BASE_HOST
                                           consumerKey:CONSUMER_KEY
                                        consumerSecret:CONSUMER_SECRET
                                           accessToken:nil
                                           tokenSecret:nil];
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        
        NSArray *sp1 = [str componentsSeparatedByString:@"="];
        NSString *tokenSecret = sp1[2];
        NSString *ele1 = sp1[1]; //891212-3MdIZyxPeVsFZXFOZj5tAwj6vzJYuLQplzWUmYtWd&oauth_token_secret
        NSArray *sp2 = [ele1 componentsSeparatedByString:@"&"];
        NSString *token = sp2[0];
        
        //        oauth_token=891212-3MdIZyxPeVsFZXFOZj5tAwj6vzJYuLQplzWUmYtWd&oauth_token_secret=x6qpRnlEmW9JbQn4PQVVeVG8ZLPEx6A0TOebgwcuA
        sucess(token,tokenSecret);
        
    }];
    [task resume];
    
}
//获取用户信息
- (void)requestVerifyCredential:(NSDictionary *)parameters accessToken:(NSString *)accessToken tokenSecret:(NSString *)tokenSecret requestMethod:(NSString *)requestMethod sucess:(void (^)(NSDictionary *result))sucess {
    NSURLRequest *request = [TDOAuth URLRequestForPath:API_VERIFY_CREDENTIALS parameters:parameters host:FANFOU_API_HOST consumerKey:CONSUMER_KEY consumerSecret:CONSUMER_SECRET accessToken:accessToken tokenSecret:tokenSecret scheme:@"http" requestMethod:requestMethod dataEncoding:TDOAuthContentTypeUrlEncodedForm headerValues:nil signatureMethod:TDOAuthSignatureMethodHmacSha1];
    
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *result =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        [[CoreDataStack sharedCoreDataStack] insertOrUpdateWithUserProfile:result token:accessToken tokenSecret:tokenSecret];
        
        sucess(result);
    }];
    
    [task resume];
}

#pragma mark - Base Request
//base
//授权时候要使用
- (void)requestWithPath:(NSString *)path parameters:(NSDictionary *)parameters accessToken:(NSString *)accessToken tokenSecret:(NSString *)tokenSecret requestMethod:(NSString *)requestMethod sucess:(void (^)(NSArray *result))sucess failure:(void (^)(NSError *error))failure {
    NSURLRequest *request = [TDOAuth URLRequestForPath:path parameters:parameters host:FANFOU_API_HOST consumerKey:CONSUMER_KEY consumerSecret:CONSUMER_SECRET accessToken:accessToken tokenSecret:tokenSecret scheme:@"http" requestMethod:requestMethod dataEncoding:TDOAuthContentTypeUrlEncodedForm headerValues:nil signatureMethod:TDOAuthSignatureMethodHmacSha1];
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            failure(error);
        } else {
            NSArray *result =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",result);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                sucess(result);
                
            });
        }
    }];
    
    [task resume];
}
//重构base request 方法，把和access token有关的参数把到方法内部
- (void)requestWithPath:(NSString *)path parameters:(NSDictionary *)parameters requestMethod:(NSString *)requestMethod sucess:(void (^)(NSArray *result))sucess failure:(void (^)(NSError *error))failure {
    User *user = [CoreDataStack sharedCoreDataStack].currentUser;
    NSURLRequest *request = [TDOAuth URLRequestForPath:path parameters:parameters host:FANFOU_API_HOST consumerKey:CONSUMER_KEY consumerSecret:CONSUMER_SECRET accessToken:user.token tokenSecret:user.tokenSecret scheme:@"http" requestMethod:requestMethod dataEncoding:TDOAuthContentTypeUrlEncodedForm headerValues:nil signatureMethod:TDOAuthSignatureMethodHmacSha1];
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            failure(error);
        } else {
            NSArray *result =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",result);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                sucess(result);
                
            });
            
        }
    }];
    
    [task resume];
}

#pragma mark - Status
//API_HOME_TIMELINE
- (void)requestStatusWithSucess:(void (^)(NSArray *result))sucess failure:(void (^)(NSError *error))failure {
    [self requestWithPath:API_HOME_TIMELINE parameters:@{@"mode":@"lite",@"count":@60,@"format":@"html"} requestMethod:@"GET" sucess:sucess failure:failure];
}

#pragma mark - POST DATA 发饭
//包含文本和图片
- (void)postData:(NSString *)text imageData:(NSData *)imageData replyToStatusID:(NSString *)replyToStatusID repostStatusID:(NSString *)repostStatusID sucess:(void (^)(NSArray *result))sucess failure:(void (^)(NSError *error))failure   {
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    parameters[@"status"] = text;
    parameters[@"format"] = @"html";
    
    if (replyToStatusID) {
        parameters[@"in_reply_to_status_id"] = replyToStatusID;
    }
    if (repostStatusID) {
        parameters[@"repost_status_id"] = repostStatusID;
    }
    if (imageData) {
        //发布图片的接口
        [self postPhotoWithPath:API_UPLOAD_PHOTO parameters:parameters sucess:sucess failure:failure imageData:imageData];
    } else {
        //发布文本的接口
        [self requestWithPath:API_UPDATE_TEXT parameters:parameters requestMethod:@"POST" sucess:sucess failure:failure];
    }
}
//post photo 在资源文件使用 priviate method
- (void)postPhotoWithPath:(NSString *)path parameters:(NSDictionary *)parameters sucess:(void (^)(NSArray *result))sucess failure:(void (^)(NSError *error))failure imageData:(NSData *)imageData{
    //get current use to aquire token and token secret
    User *user = [CoreDataStack sharedCoreDataStack].currentUser;
    //parameters is nil 是因为后面重新传了这个参数所包含的头
    NSMutableURLRequest *request = [[TDOAuth URLRequestForPath:path parameters:nil host:FANFOU_API_HOST consumerKey:CONSUMER_KEY consumerSecret:CONSUMER_SECRET accessToken:user.token tokenSecret:user.tokenSecret scheme:@"http" requestMethod:@"POST" dataEncoding:TDOAuthContentTypeUrlEncodedForm headerValues:nil signatureMethod:TDOAuthSignatureMethodHmacSha1]mutableCopy];
    NSString *boundary = [self generateBoundaryString];
    
    //与发布文本不同的http头和body
    request.HTTPBody = [self createBodyWithBoundary:boundary parameters:parameters data:imageData fileName:@"photo"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *task = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
            failure(error);
        } else {
            NSArray *result =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",result);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                sucess(result);
                
            });
            
        }
    }];
    
    [task resume];
}

#pragma mark - PhotoUpload
//用图片上传的表单格式的构造
- (NSData *)createBodyWithBoundary:(NSString *)boundary parameters:(NSDictionary *)parameters data:(NSData *)data fileName:(NSString *)fileName
{
    NSMutableData *httpBody = [NSMutableData data];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *parameterKey, NSString *parameterValue, BOOL *stop) {
        [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", parameterKey] dataUsingEncoding:NSUTF8StringEncoding]];
        [httpBody appendData:[[NSString stringWithFormat:@"%@\r\n", parameterValue] dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"photo\"\r\n", fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:data];
    [httpBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [httpBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return httpBody;
}

- (NSString *)generateBoundaryString
{
    return [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
}

#pragma mark - 收藏
- (void)starWithStatusID:(NSString *)statusID sucess:(void(^)(NSArray *))sucess failure:(void (^)(NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"%@:%@.json",API_FAVORITES_CREATE,statusID];
    [self requestWithPath:path parameters:nil requestMethod:@"POST" sucess:sucess failure:failure];
}

@end
