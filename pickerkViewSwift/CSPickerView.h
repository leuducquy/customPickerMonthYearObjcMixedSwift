//
//  QKPickerView.h
//  quicker-cl-ios
//
//  Created by quy on 5/14/16.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CSPickerViewDelegate;

@interface CSPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id <CSPickerViewDelegate> delegate;
@property (nonatomic) NSInteger selectedIndexMonth;
@property (nonatomic) NSInteger selectedIndexYear;
@property (strong, nonatomic) NSArray *pickerMonthArray;
@property (strong, nonatomic) NSMutableArray *pickerYear;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIToolbar *toolBar;

- (void)show;
@end


@protocol CSPickerViewDelegate <NSObject>

- (void)donePickerView:(CSPickerView *)pickerView selectedIndexMonth:(NSInteger)selectedIndexMonth selectedIndexYear:(NSInteger)selectedIndexYear;

@optional
- (void)cancelPickerView:(CSPickerView *)pickerView;
@end
