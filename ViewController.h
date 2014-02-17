//
//  ViewController.h
//  PersistMe
//
//  Created by Eivind Bakke on 2/16/14.
//  Copyright (c) 2014 HALEALEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstname;
@property (weak, nonatomic) IBOutlet UITextField *lastname;
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)addPersonButton:(id)sender;

- (IBAction)searchPersonButton:(id)sender;

- (IBAction)deletePersonButton:(id)sender;

@end
