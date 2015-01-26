//
//  WKDatePicker.m
//  WKDatePicker
//
//  Created by 吴珂 on 15/1/12.
//  Copyright (c) 2015年 吴珂. All rights reserved.
//

#import "WKDatePicker.h"
#import <UIKit/UIKit.h>

typedef enum{
    kYearComponent = 0,
    kMonthComponent,
    kDayComponent,
    kHourComponent,
    kMinuteComponent
}WKDatePickerComponent;

#define kRepeatCount 100

@interface WKDatePicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *yearArr;

@property (nonatomic, strong) NSMutableArray *monthArr;


@property (nonatomic, strong) NSMutableArray *bigMonthDayArr;

@property (nonatomic, strong) NSMutableArray *hourArr;

@property (nonatomic, strong) NSMutableArray *minuteArr;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation WKDatePicker

- (void)awakeFromNib
{
    [self createUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createDataSource];
        
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    
    [self createDataSource];
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectInset(self.bounds, 5, 0)];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    
    [self addSubview:_pickerView];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20)];
    
    _timeLabel.text = @"请选择时间";
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_timeLabel];
  
    [self setTime:@"2015-12-12 13:58:00"];
    
}

- (void)layoutSubviews
{
    _pickerView.frame = CGRectInset(self.bounds, 5, 0);
    _timeLabel.frame = CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20);
}

- (void)createDataSource
{
    _yearArr = [NSMutableArray array];
    _monthArr = [NSMutableArray array];
    _bigMonthDayArr = [NSMutableArray array];
    _minuteArr = [NSMutableArray array];
    _hourArr = [NSMutableArray array];
    int year = 1990;
    for (int i = 0; i < 50; i++) {
        year++;
        
        [_yearArr addObject:[NSString stringWithFormat:@"%d年", year]];
    }
    
    int month = 0;
    
    for (int i = 0; i < 12; i++) {
        month++;
        
        [_monthArr addObject:[NSString stringWithFormat:@"%02d月", month]];
    }
    
   
    int day = 0;

    for (int i = 0; i < 31; i++) {
        day++;

        [_bigMonthDayArr addObject:[NSString stringWithFormat:@"%02d日", day]];
    }
    
    
    int hour = 0;
    
    for (int i = 0; i < 24; i++) {
        
        [_hourArr addObject:[NSString stringWithFormat:@"%02d时", hour]];
        
        hour++;
    }
    
    int minute = 0;
    
    for (int i = 0; i < 60; i++) {
        
        
        [_minuteArr addObject:[NSString stringWithFormat:@"%02d分", minute]];
        
        minute++;
    }


    
    _dataSource = [NSMutableArray arrayWithObjects:_yearArr, _monthArr, _bigMonthDayArr, _hourArr, _minuteArr, nil];
}




#pragma mark - 数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _yearArr.count * kRepeatCount;
    }
    
    if (component == 1) {
        return _monthArr.count * kRepeatCount;
    }
    
    if (component == 2) {
        return _bigMonthDayArr.count * kRepeatCount;
    }
    
    if (component == 3) {
        return _hourArr.count * kRepeatCount;
    }
    
    if (component == 4) {
        return _minuteArr.count * kRepeatCount;
    }
    return 0;
}

#pragma mark - 代理方法
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return _yearArr[row % _yearArr.count];
    }
    
    if (component == 1) {
        return _monthArr[row % _monthArr.count];
    }
    
    if (component == 2) {
        return _bigMonthDayArr[row % _bigMonthDayArr.count];
    }
    
    if (component == 3) {
        return _hourArr[row % _hourArr.count];
    }
    
    if (component == 4) {
        return _minuteArr[row % _minuteArr.count];
    }
    
    return @"没有数据";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        [self judgeIsNeedMoveDayComponent:pickerView didSelectRow:row % [_dataSource[component] count] inComponent:component];
    }
    
    if (component == 1) {
        [self judgeIsNeedMoveDayComponent:pickerView didSelectRow:row % [_dataSource[component] count] inComponent:component];
        
    }
    
    if (component == 2) {
        [self judgeIsNeedMoveDayComponent:pickerView didSelectRow:row % [_dataSource[component] count] inComponent:component];
    }
    
    //修改时间
    NSString *yearStr = (NSString *)_yearArr[[pickerView selectedRowInComponent:kYearComponent]% [_dataSource[kYearComponent] count]];
    
    NSString *monthStr = (NSString *)_monthArr[[pickerView selectedRowInComponent:kMonthComponent]% [_dataSource[kMonthComponent] count]];
    
    NSString *dayStr = (NSString *)_bigMonthDayArr[[pickerView selectedRowInComponent:kDayComponent]% [_dataSource[kDayComponent] count]];
    
    NSString *hourStr = [(NSString *)_hourArr[[pickerView selectedRowInComponent:kHourComponent]% [_dataSource[kHourComponent] count]] stringByReplacingOccurrencesOfString:@"时" withString:@""];
    
    NSString *minuteStr = [(NSString *)_minuteArr[[pickerView selectedRowInComponent:kMinuteComponent]% [_dataSource[kMinuteComponent] count]] stringByReplacingOccurrencesOfString:@"分" withString:@""];
    
    NSString *timeStr = [NSString stringWithFormat:@"%@%@%@ %@:%@",yearStr, monthStr, dayStr, hourStr, minuteStr];
    
    _timeLabel.text = [timeStr stringByAppendingString:@":00"];
    
    if ([self.delegate respondsToSelector:@selector(WKDatePicker:dateChanged:)]) {
        NSString *timeStr = _timeLabel.text;
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
        timeStr = [timeStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
        [self.delegate WKDatePicker:self dateChanged:timeStr];
    }
    
    [self selectedTimeStr];
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = (UILabel *)[view viewWithTag:20];
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:CGRectInset(view.bounds, 0, 0)];
        label.tag = 20;
        [view addSubview:label];
    }
    label.text = _dataSource[component][row % [_dataSource[component] count]];
    
    return label;
}

- (BOOL)judgeIsLeapYear:(NSInteger)year
{
    if ((year%4 == 0 && year % 100 !=0) || year %400==0) {
        return YES;
    }else{
        return NO;
    }
}

- (void)judgeIsNeedMoveDayComponent:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger selectedRowYear = [pickerView selectedRowInComponent:kYearComponent];
    NSInteger selectedRowMonth = [pickerView selectedRowInComponent:kMonthComponent];
    NSInteger selectedRowDay = [pickerView selectedRowInComponent:kDayComponent];

    NSString *yearStr = (NSString *)_yearArr[selectedRowYear% [_dataSource[kYearComponent] count]];
    

    NSString *monthStr = (NSString *)_monthArr[selectedRowMonth % [_dataSource[kMonthComponent] count]];
    

    NSString *dayStr = (NSString *)_bigMonthDayArr[selectedRowDay % [_dataSource[kDayComponent] count]];
    
    
    NSInteger month = [[monthStr stringByReplacingOccurrencesOfString:@"月" withString:@""] integerValue];
    
    NSInteger day = [dayStr integerValue];
    
    NSInteger year = [yearStr integerValue];
    
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:

            break;
        case 4:
        case 6:
        case 9:
        case 11:

            if (day == 31) {
                [pickerView selectRow:selectedRowDay / 31 * 31 + 29 inComponent:kDayComponent animated:YES];
            }
            break;
        case 2:

            if ([self judgeIsLeapYear:year]) {
                if (day > 29) {

                    [pickerView selectRow:selectedRowDay / 31 * 31 + 28 inComponent:kDayComponent animated:YES];
                }
            }else{
                if (day > 28) {
                    [pickerView selectRow:selectedRowDay / 31 * 31 + 27 inComponent:kDayComponent animated:YES];
                }
            }
            break;
            
        default:
            break;
    }
}

- (NSDate *)selectedTimeStr
{
    NSString *timeStr = _timeLabel.text;
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"日" withString:@""];
    
    NSDateFormatter *fm =[[NSDateFormatter alloc] init];
    fm.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *selectedDate = [fm dateFromString:timeStr];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: selectedDate];
    
    NSDate *localeDate = [selectedDate  dateByAddingTimeInterval: interval];
    
    return localeDate;
}

- (void)setTime:(NSString *)timeStr
{

    NSCharacterSet *cSet = [NSCharacterSet characterSetWithCharactersInString:@"- :"];
    NSArray *timeArr = [timeStr componentsSeparatedByCharactersInSet:cSet];
    

    NSString *yearStr = [(NSString *)timeArr[0] stringByAppendingString:@"年"];
    NSString *monthStr = [(NSString *)timeArr[1] stringByAppendingString:@"月"];
    NSString *dayStr = [(NSString *)timeArr[2] stringByAppendingString:@"日"];
    NSString *hourStr = [(NSString *)timeArr[3] stringByAppendingString:@"时"];
    NSString *minuteStr = [(NSString *)timeArr[4] stringByAppendingString:@"分"];
    
    [_pickerView selectRow:[_dataSource[kYearComponent] count] * kRepeatCount / 2 + [_yearArr indexOfObject:yearStr] inComponent:0 animated:NO];
    
    [_pickerView selectRow:[_dataSource[kMonthComponent] count] * kRepeatCount / 2 + [_monthArr indexOfObject:monthStr] inComponent:1 animated:NO];
    
    [_pickerView selectRow:[_dataSource[kDayComponent] count] * kRepeatCount / 2 + [_bigMonthDayArr indexOfObject:dayStr] inComponent:2 animated:NO];
    
    [_pickerView selectRow:[_dataSource[kHourComponent] count] * kRepeatCount / 2 + [_hourArr indexOfObject:hourStr] inComponent:3 animated:NO];
    
    [_pickerView selectRow:[_dataSource[kMinuteComponent] count] * kRepeatCount / 2 + [_minuteArr indexOfObject:minuteStr] inComponent:4 animated:NO];
}

- (void)setTimeLabelHidden:(BOOL)timeLabelHidden
{
    _timeLabel.hidden = timeLabelHidden;
}
@end
