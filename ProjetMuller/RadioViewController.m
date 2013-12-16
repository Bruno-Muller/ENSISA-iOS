//
//  RadioViewController.m
//  Projet Muller (Monôme)
//
//  Created by Bruno Muller on 16/12/2013.
//  Copyright (c) 2013 Muller Bruno. All rights reserved.
//

#import "RadioViewController.h"
#import "AppDelegate.h"

@interface RadioViewController ()

@end

@implementation RadioViewController

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
    
    self.player = [[MPMoviePlayerController alloc] init];
    self.player.movieSourceType = MPMovieSourceTypeStreaming;
    self.player.view.hidden = YES;
    [self.view addSubview:self.player.view];
    self.player.shouldAutoplay = NO;
    [self.player prepareToPlay];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.nameField.text = [self.radio valueForKey:@"name"];
    self.categoryField.text = [self.radio valueForKey:@"category"];
    self.urlField.text = [self.radio valueForKey:@"url"];
}

- (IBAction)play:(id)sender {
    [self.player stop];
    
    if ([@"Cosmology" compare:[self.radio valueForKey:@"name"]]==NSOrderedSame) {
          self.player.movieSourceType = MPMovieSourceTypeFile;
         self.player.contentURL = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/easter-egg.aiff", [[NSBundle mainBundle] resourcePath]]];
    } else {
        self.player.movieSourceType = MPMovieSourceTypeStreaming;
        self.player.contentURL = [NSURL URLWithString:[self.radio valueForKey:@"url"]];
    }
    [self.player play];
    
}

- (IBAction)pause:(id)sender {
    [self.player pause];
}

- (IBAction)nameEditingDidEnd:(id)sender {
    [self.radio setValue:self.nameField.text forKey:@"name"];

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
}

- (IBAction)categoryEditingDidEnd:(id)sender {
    [self.radio setValue:self.categoryField.text forKey:@"category"];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
}

- (IBAction)urlEditingDidEnd:(id)sender {
    [self.radio setValue:self.urlField.text forKey:@"url"];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate saveContext];
}

- (IBAction)trash:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    [context deleteObject:self.radio];
    [appDelegate saveContext];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
