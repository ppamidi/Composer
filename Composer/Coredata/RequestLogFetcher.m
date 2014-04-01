//
//  RequestLogFetcher.m
//  Composer
//
//  Created by Prasad Pamidi on 3/12/14.
//  Copyright (c) 2014 Capgemini. All rights reserved.
//

#import "RequestLogFetcher.h"
#import "EntityManager.h"

@implementation RequestLogFetcher


+ (RequestLogFetcher*)fetcher {
    static RequestLogFetcher* requestFetcher;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestFetcher = [[RequestLogFetcher alloc]init];
    });
    
    return requestFetcher;
}

- (NSArray*)getAllRequests {
    
   	NSFetchRequest* request = [[EntityManager entityManager] fetchRequestFromTemplateWithName:@"GetAllRequests" substitutionVariables:nil];
    
    [request setSortDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"requestDateTime" ascending:NO]]];
    return [[EntityManager entityManager] entitiesForFetchRequest:request];
}

- (int)getTotalRequestsCount {
    NSFetchRequest* request = [[EntityManager entityManager] fetchRequestFromTemplateWithName:@"GetAllRequests" substitutionVariables:nil];
    
    return [[EntityManager entityManager] countForFetchRequest:request];
}

@end
