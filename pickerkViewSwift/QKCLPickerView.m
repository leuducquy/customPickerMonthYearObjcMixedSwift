//
//  QKPickerView.m
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLPickerView.h"



@interface QKCLPickerView ()
@property (strong, nonatomic) UIWindow *keyWindow;
@end
@implementation QKCLPickerView

- (id)init {
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    self.keyWindow = [[UIApplication sharedApplication] keyWindow];
    self.frame = self.keyWindow.frame;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addPickerView];
    [self addToolbar];
}

- (void)addToolbar {
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height - self.pickerView.frame.size.height - 44, self.frame.size.width, 44)];
    _toolBar.barStyle = UIBarStyleDefault;
    _toolBar.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *leftFixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    leftFixedSpace.width = 7;
    UIBarButtonItem *rightFixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    rightFixedSpace.width = 15;
    
    UIButton  *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 44)];
    //cancelButton.backgroundColor=[UIColor redColor];
    [cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithRed:79.0 / 255.0 green:88.0 / 255.0 blue:104.0 / 255.0 alpha:1]  forState:UIControlStateNormal];
    //[cancelButton sizeToFit];
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    UIButton *doneButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [doneButton setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //doneButton.backgroundColor=[UIColor redColor];
    //[doneButton sizeToFit];
    [doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    
    [_toolBar setItems:[NSArray arrayWithObjects:leftFixedSpace, cancelBarButton, flexibleSpace, doneBarButton, rightFixedSpace, nil]];
    [self addSubview:_toolBar];
}

- (void)addPickerView {
    self.pickerMonthArray = @[@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger month = [gregorian component:NSCalendarUnitMonth fromDate:NSDate.date];
     _selectedIndexMonth = month -1;
   
    NSUInteger year = [gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
     _selectedIndexYear = year;
    self.pickerYear  = [[ NSMutableArray alloc]init];
    [self.pickerYear addObject:[NSString stringWithFormat:@"%lu",(unsigned long)year]];
    for (int i = 0; i < 15; i++){
                year = year + 1;
         [self.pickerYear addObject:[NSString stringWithFormat:@"%lu",(unsigned long)year]];
        
    }
    
    self.pickerView = [[UIPickerView alloc]init];
    self.pickerView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height - self.pickerView.frame.size.height, self.frame.size.width, self.pickerView.frame.size.height );
    
    self.pickerView.delegate = self;
    self.pickerView.backgroundColor = [UIColor colorWithRed:244.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1.0];
    
    [self addSubview:self.pickerView];
}

- (void)show {
    [_keyWindow endEditing:YES];
    [self.pickerView reloadAllComponents];
    if (_selectedIndexMonth >= 0 && _selectedIndexMonth < self.pickerMonthArray.count) {
        
        [self.pickerView selectRow:_selectedIndexMonth inComponent:0 animated:NO];
    }
    if (_selectedIndexYear>= 0 && _selectedIndexYear < self.pickerYear.count) {
        
        [self.pickerView selectRow:_selectedIndexYear inComponent:0 animated:NO];
    }

    [_keyWindow addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:.2 animations: ^{
        self.alpha = 1;
    }];
}

- (void)hide {
    [self removeFromSuperview];
}

- (void)cancel:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelPickerView:)]) {
        [self.delegate cancelPickerView:self];
    }
    [self hide];
}

- (void)done:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(donePickerView:selectedIndexMonth:selectedIndexYear:)]) {
        [self.delegate donePickerView:self selectedIndexMonth:[self.pickerView selectedRowInComponent:0] selectedIndexYear:[self.pickerView selectedRowInComponent:1]];
    }
    [self hide];
}

#pragma mark - Handle Action In View

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!([[touches anyObject] view] == _toolBar)) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(donePickerView:selectedIndexMonth:selectedIndexYear:)]) {
            [self.delegate donePickerView:self selectedIndexMonth:[self.pickerView selectedRowInComponent:0] selectedIndexYear:[self.pickerView selectedRowInComponent:1]];
        }
        [self hide];
    }
}

#pragma mark PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// The number of columns of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return _pickerMonthArray.count;
            break;
        case  1 :
            return _pickerYear.count;
            break;
        default:
            break;
    }
   return 0;
}

// The data to return for the row and component (column) that's being passed in
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return _pickerMonthArray[row];
            break;
        case  1 :
            return _pickerYear[row];
        default:
            break;
    }
 return 0;
}

@end
