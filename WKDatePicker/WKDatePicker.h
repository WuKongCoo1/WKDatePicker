//
//  WKDatePicker.h
//  WKDatePicker
//
//  Created by 吴珂 on 15/1/12.
//  Copyright (c) 2015年 吴珂. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WKDatePicker;
@protocol WKDatePickerDelegate <NSObject>

- (void)WKDatePicker:(WKDatePicker*) datePicker dateChanged:(NSString *)date;

@end

@interface WKDatePicker : UIView

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, assign) BOOL timeLabelHidden;

@property (nonatomic, weak) id<WKDatePickerDelegate> delegate;

- (NSDate *)selectedTimeStr;


- (void)setTime:(NSString *)timeStr;
@end
