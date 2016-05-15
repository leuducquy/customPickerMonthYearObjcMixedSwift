//
//  QKPickerView.h
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QKCLPickerViewDelegate;

@interface QKCLPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id <QKCLPickerViewDelegate> delegate;
@property (nonatomic) NSInteger selectedIndexMonth;
@property (nonatomic) NSInteger selectedIndexYear;
@property (strong, nonatomic) NSArray *pickerMonthArray;
@property (strong, nonatomic) NSMutableArray *pickerYear;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIToolbar *toolBar;

- (void)show;
@end


@protocol QKCLPickerViewDelegate <NSObject>

- (void)donePickerView:(QKCLPickerView *)pickerView selectedIndexMonth:(NSInteger)selectedIndexMonth selectedIndexYear:(NSInteger)selectedIndexYear;

@optional
- (void)cancelPickerView:(QKCLPickerView *)pickerView;
@end
