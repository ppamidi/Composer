//
//  GuestInfoFetcher.h
//  CoreDataDemo
//
//  Created by Priyanka on 2/27/13.
//  Copyright (c) 2013 Capgemini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntityManager : NSObject

+ (id)entityManager;
- (id)entityForFetchRequest:(NSFetchRequest*)request;
- (id)insertNewEntityForEntityName:(NSString*)entityName;
- (void)deleteEntity:(id)entity;
- (void)setManagedContext:(NSManagedObjectContext*)managedObjectContext;
- (BOOL)save;
- (NSFetchedResultsController*)fetchedResultsControllerWithFetchRequest:(NSFetchRequest*)request;
- (NSFetchRequest *)fetchRequestTemplateForName:(NSString *)name;
- (NSArray*)entitiesForFetchRequest:(NSFetchRequest*)request;
- (NSInteger)countForFetchRequest:(NSFetchRequest*)request;

@end
