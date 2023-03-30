//
//  MainCustomCell.m
//  Tools
//
//  Created by 刘永吉 on 2023/3/30.
//  Copyright © 2023 lyj. All rights reserved.
//

#import "MainCustomCell.h"


@interface MainCustomCell ()

@property (weak, nonatomic) IBOutlet UILabel *exampleTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *exampleDescLabel;
@end

@implementation MainCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(MainCustomModel *)model{
    _model = model;
    self.exampleTitleLabel.text = model.exampleTitle;
    self.exampleDescLabel.text = model.exampleDesc;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
