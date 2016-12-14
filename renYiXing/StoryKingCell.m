//
//  StoryKingCell.m
//  柴火圈
//
//  Created by JOYSW on 16/8/12.
//  Copyright © 2016年 JOYSW. All rights reserved.
//

#import "StoryKingCell.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@implementation StoryKingCell
{
    UIImageView *_headerView;
    UILabel *_userNameLabel;
    UILabel *_storyContentLabel;
    UILabel *_goodLabel;
    UILabel *_discusLabel;
    UILabel *_shareLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self)
    {
        self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView0 = [UIImageView new];
//        imageView0.backgroundColor = [UIColor redColor];
        _headerView = imageView0;
        
        UILabel *label0 = [UILabel new];
//        label0.backgroundColor = [UIColor greenColor];
        _userNameLabel = label0;
        
        UILabel *label1 = [UILabel new];
        label1.textColor = [UIColor grayColor];
        label1.font = [UIFont systemFontOfSize:14];
//        label1.numberOfLines = 0;

//        label1.backgroundColor = [UIColor blackColor];
        _storyContentLabel = label1;
        
        UIView *goodView = [UIView new];
//        goodView.backgroundColor = [UIColor grayColor];
        
        UIImageView *goodImageView = [UIImageView new];
//        goodImageView.backgroundColor = [UIColor redColor];
        [goodImageView setImage:[UIImage imageNamed:@"zan"]];
        [goodView addSubview:goodImageView];
        
        UILabel *label2 = [UILabel new];
//        label2.backgroundColor = [UIColor orangeColor];
        _goodLabel = label2;
        [goodView addSubview:label2];
        
        UIView *discusView = [UIView new];
//        discusView.backgroundColor = [UIColor grayColor];
        
        UIImageView *discusImageView = [UIImageView new];
//        discusImageView.backgroundColor = [UIColor redColor];
        [discusImageView setImage:[UIImage imageNamed:@"pinglun"]];
        [discusView addSubview:discusImageView];
        
        UILabel *label3 = [UILabel new];
//        label3.backgroundColor = [UIColor orangeColor];
        _discusLabel = label3;
        [discusView addSubview:label3];
        
        UIView *shareView = [UIView new];
//        shareView.backgroundColor = [UIColor grayColor];
        
        UIImageView *shareImageView = [UIImageView new];
//        shareImageView.backgroundColor = [UIColor redColor];
        [shareImageView setImage:[UIImage imageNamed:@"fenxiang-2"]];
        [shareView addSubview:shareImageView];
        
        UILabel *label4 = [UILabel new];
//        label4.backgroundColor = [UIColor orangeColor];
        _shareLabel = label4;
        [shareView addSubview:label4];
        
        UIButton *redBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [redBtn setImage:[UIImage imageNamed:@"hongbao"] forState:UIControlStateNormal];
        
        
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor colorWithRed:229/255.0 green:231/255.0 blue:232/255.0 alpha:1.0];
        
        [self.contentView sd_addSubviews:@[_headerView,_userNameLabel,_storyContentLabel,goodView,discusView,shareView,bottomView,redBtn]];
        
        _headerView.sd_layout
        .widthIs(self.contentView.bounds.size.width/7)
        .heightIs(self.contentView.bounds.size.width/7)
        .topSpaceToView(self.contentView,10)
        .leftSpaceToView(self.contentView,10);
        _headerView.layer.cornerRadius = self.contentView.bounds.size.width/7 / 2;
        _headerView.layer.masksToBounds = YES;
        
        _userNameLabel.sd_layout
        .heightRatioToView(_headerView,1)
        .topEqualToView(_headerView)
        .leftSpaceToView(_headerView,5);
        [_userNameLabel setSingleLineAutoResizeWithMaxWidth:200];
        
        _storyContentLabel.sd_layout
        .topSpaceToView(_headerView,5)
        .leftEqualToView(_headerView)
        .rightSpaceToView(self.contentView,10)
        .autoHeightRatio(0);
//        可以设置显示几行
//        [_storyContentLabel setMaxNumberOfLinesToShow:2];
        [_storyContentLabel setIsAttributedContent:YES];
        
        goodView.sd_layout
        .topSpaceToView(_storyContentLabel,10)
        .leftEqualToView(_headerView)
        .widthIs(self.contentView.bounds.size.width/5)
        .heightIs(15);
        
        goodImageView.sd_layout
        .topEqualToView(goodView)
        .bottomEqualToView(goodView)
        .leftEqualToView(goodView)
        .widthIs(15);
        
        _goodLabel.sd_layout
        .topEqualToView(goodView)
        .bottomEqualToView(goodView)
        .leftSpaceToView(goodImageView,5);
        [_goodLabel setSingleLineAutoResizeWithMaxWidth:self.contentView.bounds.size.width/5-20];
        
        discusView.sd_layout
        .topEqualToView(goodView)
        .leftSpaceToView(goodView,10)
        .bottomEqualToView(goodView)
        .widthIs(self.contentView.bounds.size.width/5);
        
        discusImageView.sd_layout
        .topEqualToView(discusView)
        .bottomEqualToView(discusView)
        .leftEqualToView(discusView)
        .widthIs(15);
        
        _discusLabel.sd_layout
        .topEqualToView(discusView)
        .bottomEqualToView(discusView)
        .leftSpaceToView(discusImageView,5);
        [_discusLabel setSingleLineAutoResizeWithMaxWidth:self.contentView.bounds.size.width/5-20];
        
        shareView.sd_layout
        .topEqualToView(goodView)
        .leftSpaceToView(discusView,10)
        .bottomEqualToView(goodView)
        .widthIs(self.contentView.bounds.size.width/5);
        
        shareImageView.sd_layout
        .topEqualToView(shareView)
        .bottomEqualToView(shareView)
        .leftEqualToView(shareView)
        .widthIs(15);
        
        _shareLabel.sd_layout
        .topEqualToView(shareView)
        .bottomEqualToView(shareView)
        .leftSpaceToView(shareImageView,5);
        [_shareLabel setSingleLineAutoResizeWithMaxWidth:self.contentView.bounds.size.width/5-20];
        
        redBtn.sd_layout
        .rightSpaceToView(self.contentView,10)
        .topSpaceToView(_storyContentLabel,1)
        .bottomEqualToView(goodView)
        .widthIs(15);
        
        bottomView.sd_layout
        .topSpaceToView(goodView,10)
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(15);
        
        [self setupAutoHeightWithBottomView:goodView bottomMargin:25];
        
        
    }
    return self;
}



-(void)setModel:(StoryKingModel *)model
{
    _model = model;
    _headerView.image = [UIImage imageNamed:model.headerImageName];
    _userNameLabel.text = model.userName;
    _storyContentLabel.text = model.StoryContent;
    _goodLabel.text = model.good;
    _discusLabel.text = model.discus;
    _shareLabel.text = model.share;
    
    //        调整行距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_storyContentLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_storyContentLabel.text length])];
    _storyContentLabel.attributedText= attributedString;
    [_storyContentLabel sizeToFit];
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
