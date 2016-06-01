//
//  ViewController.m
//  KuaiBaoDemo
//
//  Created by 王保霖 on 16/6/1.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "ViewController.h"
#import "VideoTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "FullViewController.h"
#import "VideoPlayView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,VideoPlayViewDelegate>{

    UITableView *_tableView;
    NSMutableArray *_VideoArr;
    
    NSIndexPath __block * SelectIndexPath;
    CGRect lastFrame;

}


@property (strong, nonatomic)  VideoPlayView *player;
@property (nonatomic, strong) FullViewController *fullVc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self initViewData];
    [self setupAvPlayer];
    
 
}
-(VideoPlayView *)player{
    
    if(_player == nil){
        
        _player = [VideoPlayView videoPlayView];
    }
    
    return _player;
}


-(void)initViewData{

    //_VideoArr = [[NSMutableArray alloc]init];
    
    NSString *path  =[[NSBundle mainBundle] pathForResource:@"VideoList" ofType:@"plist"];
    
    _VideoArr = [NSMutableArray arrayWithContentsOfFile:path];
    
    [_VideoArr addObjectsFromArray:_VideoArr];
    
    
    [_tableView reloadData];
    
    
}

-(void)setupAvPlayer{

    self.player.delegate = self;
    
    
    [self.player setHidden:YES];

    
}

- (FullViewController *)fullVc
{
    if (_fullVc == nil) {
        self.fullVc = [[FullViewController alloc] init];
    }
    
    return _fullVc;
}

-(void)videoplayViewSwitchOrientation:(BOOL)isFull{

    if (isFull) {
        
        lastFrame = self.player.frame;
        [self presentViewController:self.fullVc animated:YES completion:^{
            self.player.frame = self.fullVc.view.bounds;
            [self.fullVc.view addSubview:self.player];
        }];
    } else {
        [self.fullVc dismissViewControllerAnimated:YES completion:^{
            self.player.frame = lastFrame;
            [self.view addSubview:self.player];
        }];
    }
}

-(void)setupTableView{

    _tableView =[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerNib:[UINib nibWithNibName:@"VideoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];;
    [self.view addSubview:_tableView];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dic =[_VideoArr objectAtIndex:indexPath.row];
    cell.Title.text = dic[@"Title"];
    [cell.VideoImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]]];
    
    cell.PlayButton.layer.cornerRadius = 25;
    cell.PlayButton.clipsToBounds = YES;
    cell.indexpath = indexPath;
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    
    cell.playBlock = ^(NSIndexPath *indexpath){
    
        [self.player removeFromSuperview];
        
        
        CGRect cellRect = [_tableView rectForRowAtIndexPath:indexpath];

        
        self.player.frame = CGRectMake(0,cellRect.origin.y+25,CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame)/1.7);
        
        NSLog(@"%@",dic[@"videourl"]);
        
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://v1.mukewang.com/3e35cbb0-c8e5-4827-9614-b5a355259010/L.mp4"]];
        
        SelectIndexPath = indexpath;
        
        [self.player setPlayerItem:item];
        
        [self.player setHidden:NO];
        
        [_tableView addSubview:self.player];
    };
//    [cell.PlayButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    return  cell;
    

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSLog(@"contentOffset = %.2f",scrollView.contentOffset.y);
    
    CGRect cellRect = [_tableView rectForRowAtIndexPath:SelectIndexPath];
    
    if((scrollView.contentOffset.y - cellRect.origin.y - cellRect.size.height > 0 )||(cellRect.origin.y - scrollView.contentOffset.y - _tableView.frame.size.height > 0)){
    
        [self.player removeFromSuperview];
        self.player.frame = CGRectMake(CGRectGetWidth(self.view.frame)-200,CGRectGetHeight(self.view.frame)-200/1.7, 200, 200/1.7);
        
        [self.view addSubview:self.player];
        
    }else{
    
        [self.player removeFromSuperview];
        
        self.player.frame = CGRectMake(0,cellRect.origin.y+25,CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame)/1.7);
        [_tableView addSubview:self.player];
    }
    
    
    
}

//-(void)playAction:(UIButton *)sender{
//
//   
//    VideoTableViewCell *cell = ( VideoTableViewCell *)[sender superview];
//    
//    NSLog(@"%@",cell.indexpath);
//    
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _VideoArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return CGRectGetWidth(self.view.frame)/1.7+10+20;
}


@end
