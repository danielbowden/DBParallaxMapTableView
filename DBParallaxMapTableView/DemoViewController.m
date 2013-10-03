//
//  DemoViewController.m
//  DBParallaxMapTableView
//
//  Created by Daniel Bowden on 13/09/13.
//  Copyright (c) 2013 Daniel Bowden. All rights reserved.
//

#import "DemoViewController.h"

#import "DBParalaxMapTableView.h"

@interface DemoViewController ()

@property (nonatomic, strong) DBParalaxMapTableView *paralaxMapTableView;
@property (nonatomic, strong) NSMutableArray *sampleData;

@end

@implementation DemoViewController

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
    
    self.sampleData = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 10; i++)
    {
        [self.sampleData addObject:[NSString stringWithFormat:@"Row %i", i]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.paralaxMapTableView = [[DBParalaxMapTableView alloc] initWithFrame:self.view.frame];
    self.paralaxMapTableView.delegate = self;
    self.paralaxMapTableView.dataSource = self;
    
    [self.view addSubview:self.paralaxMapTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sampleData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"TableCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.sampleData objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
