//
//  ViewController.m
//  WKDatePicker
//
//  Created by 吴珂 on 15/1/12.
//  Copyright (c) 2015年 吴珂. All rights reserved.
//

#import "ViewController.h"
#import "WKDatePicker.h"

#define RGB(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0]

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, WKDatePickerDelegate>
@property (weak, nonatomic) IBOutlet WKDatePicker *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickerView.delegate = self;
    
}




#pragma mark - dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 20;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"第%d行", row];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor = RGB(0, 183, 238).CGColor;
    textField.layer.borderWidth = 2.0f;
    textField.layer.cornerRadius = 13.0f;
    
    [_pickerView setTime:textField.text];
    return NO;
}

- (void)WKDatePicker:(WKDatePicker *)datePicker dateChanged:(NSString *)date
{
    _textField.text = date;
}
@end
