//
//  ViewController.m
//  FSNetWorking
//
//  Created by BOOM on 16/11/22.
//  Copyright © 2016年 Devil. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController () <NSXMLParserDelegate>

@property (nonatomic, strong) NSString *xmlString;
@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSMutableString *element;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.element = @"".mutableCopy;
    
    [self urlSessionWork];
}

- (void)observeNetStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    __weak typeof (AFNetworkReachabilityManager) *weakManager = manager;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        __strong typeof(AFNetworkReachabilityManager) *strongManager = weakManager;
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: NSLog(@"%@", [strongManager localizedNetworkReachabilityStatusString]); break;
            case AFNetworkReachabilityStatusNotReachable: NSLog(@"%@", [strongManager localizedNetworkReachabilityStatusString]); break;
            case AFNetworkReachabilityStatusReachableViaWWAN: NSLog(@"%@", [strongManager localizedNetworkReachabilityStatusString]); break;
            case AFNetworkReachabilityStatusReachableViaWiFi: NSLog(@"%@", [strongManager localizedNetworkReachabilityStatusString]); break;
        }
    }];
    
    [manager startMonitoring];
}

- (void)urlSessionWork
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://10.17.130.104:80/mobile/getCmsVersion"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        self.xmlString = [NSString stringWithCString:data.bytes encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", self.xmlString);
        
        self.parser = [[NSXMLParser alloc] initWithData:data];
        self.parser.delegate = self;
        BOOL ret = [self.parser parse];
        NSLog(@"%d", ret);
    }];
    
    [dataTask resume];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Start Parse");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"EndParse");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
//    if ([elementName isEqualToString:@"CmsVersion"])
//    {
//        NSLog(@"%@", [attributeDict objectForKey:@"CmsVersion"]);
//    }
//    
//    
//    NSLog(@"ElementName is %@", elementName);
//    
//    NSLog(@"Dictionary is %@", [attributeDict description]);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.element setString:@""];
    [self.element appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSString *str=[[NSString alloc] initWithString:self.element];
    
    if ([elementName isEqualToString:@"CmsVersion"])
    {
        NSLog(@"creator=%@",str);
    }
    if ([elementName isEqualToString:@"Status"])
    {
        NSLog(@"name=%@",str);
    }
    if ([elementName isEqualToString:@"Description"])
    {
        NSLog(@"age=%@",str);
    }
}

@end
