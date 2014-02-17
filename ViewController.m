//
//  ViewController.m
//  PersistMe
//
//  Created by Eivind Bakke on 2/16/14.
//  Copyright (c) 2014 HALEALEI. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    NSManagedObjectContext *context;
}
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[self firstname]setDelegate:self];
    [[self lastname]setDelegate:self];
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    context = [appdelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (IBAction)addPersonButton:(id)sender {
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSManagedObject *newPerson = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newPerson setValue:self.firstname.text forKey:@"firstname"];
    [newPerson setValue:self.lastname.text forKey:@"lastname"];
    
    NSError *error;
    [context save:&error];
    self.label.text = @"Person Added.";
}

- (IBAction)searchPersonButton:(id)sender {
    
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ and lastname like %@", self.firstname.text, self.lastname.text];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if(matchingData.count <= 0) {
        self.label.text=@"No Person Found.";
    }
    else
    {
        NSString *firstName;
        NSString *lastName;
        
        for (NSManagedObject *obj in matchingData) {
            firstName = [obj valueForKey:@"firstname"];
            lastName = [obj valueForKey:@"lastname"];
        }
        self.label.text = [NSString stringWithFormat:@"Firstname: %@, Lastname: %@", firstName, lastName];
    }
    
}

- (IBAction)deletePersonButton:(id)sender {
    
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@", self.firstname.text];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if(matchingData.count <= 0) {
        self.label.text = @"No person deleted.";
    } else {
        for (NSManagedObject *obj in matchingData) {
            [context deleteObject:obj];
        }
        self.label.text = @"All instances deleted";
        [context save:&error];
        }
    
}
@end
