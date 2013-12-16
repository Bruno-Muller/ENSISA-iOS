//
//  RadioViewController.h
//  Projet Muller (Monôme)
//
//  Created by Bruno Muller on 16/12/2013.
//  Copyright (c) 2013 Muller Bruno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface RadioViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *categoryField;
@property (weak, nonatomic) IBOutlet UITextField *urlField;
@property (strong, nonatomic) NSManagedObject *radio;
@property (strong, nonatomic) MPMoviePlayerController *player;
- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)nameEditingDidEnd:(id)sender;
- (IBAction)categoryEditingDidEnd:(id)sender;
- (IBAction)urlEditingDidEnd:(id)sender;
- (IBAction)trash:(id)sender;

@end
