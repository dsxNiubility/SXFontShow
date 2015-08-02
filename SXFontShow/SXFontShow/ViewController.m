//
//  ViewController.m
//  SXFontShow
//
//  Created by dongshangxian on 15/8/2.
//  Copyright (c) 2015年 Sankuai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)UITableView * tableView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    //字体家族总数
    return [[UIFont familyNames] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //字体家族包括的字体库总数
    //    return [[UIFont fontNamesForFamilyName:[[UIFont familyNames] objectAtIndex:section] ] count];
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //字体家族名称
    return [[UIFont familyNames] objectAtIndex:section];
}



- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    return index;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //字体家族名称
    NSString *familyName= [[UIFont familyNames] objectAtIndex:indexPath.section];
    
    //字体家族中的字体库名称
    NSString *fontName  = [[UIFont fontNamesForFamilyName:[[UIFont familyNames] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    //    NSLog(@"%@",fontName);
    cell.textLabel.font = [UIFont fontWithName:fontName size:18.0f];
    
    cell.textLabel.text=@"董铂然DSXNiubility-2015";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", familyName, fontName ];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //字体家族名称
    //    NSString *familyName= [[UIFont familyNames] objectAtIndex:indexPath.section];
    
    //字体家族中的字体库名称
    NSString *fontName  = [[UIFont fontNamesForFamilyName:[[UIFont familyNames] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    NSLog(@"%@",fontName);
    
}

@end
