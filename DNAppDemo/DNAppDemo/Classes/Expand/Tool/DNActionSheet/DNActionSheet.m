//
//  DNActionSheet.m
//  DNAppDemo
//
//  Created by mainone on 16/4/22.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "DNActionSheet.h"

#define SPACE_SMALL 5
#define TITLE_FONT_SIZE 13
#define BUTTON_FONT_SIZE 14
#define BUTTON_HEIGHT 48

#define BUTTON_TitlecColor [UIColor colorWithRed:30 / 255.0 green:30 / 255.0 blue:30 / 255.0 alpha:1.0]
#define BUTTON_WHITEALPHA [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:.5]

@interface DNActionSheet ()

@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UIView *buttonView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) UIButton *cancelButton;

@property (strong, nonatomic) NSMutableArray *buttonTitleArray;

@end

CGFloat contentViewWidth;
CGFloat contentViewHeight;

@implementation DNActionSheet

- (id)initWithTitle:(NSString *)title delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _title             = title;
        _delegate          = delegate;
        _cancelButtonTitle = cancelButtonTitle;
        _buttonArray       = [NSMutableArray array];
        _buttonTitleArray  = [NSMutableArray array];
        
        va_list args;
        va_start(args, otherButtonTitles);
        if (otherButtonTitles) {
            [_buttonTitleArray addObject:otherButtonTitles];
            while (1) {
                NSString *otherButtonTitle = va_arg(args, NSString *);
                if (otherButtonTitle == nil) {
                    break;
                } else {
                    [_buttonTitleArray addObject:otherButtonTitle];
                }
            }
        }
        va_end(args);
        
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        _backgroundView                              = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.alpha                        = 0;
        _backgroundView.backgroundColor              = [UIColor colorWithRed:0 green:0 blue:0 alpha:.6];
        [_backgroundView addGestureRecognizer:tapGestureRecognizer];
        [self addSubview:_backgroundView];
        
        [self initContentView];
    }
    return self;
}

- (void)initContentView {
    contentViewWidth             = self.frame.size.width;
    contentViewHeight            = 0;

    _contentView                 = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:.9];

    _buttonView                  = [[UIView alloc] init];
    _buttonView.backgroundColor = BUTTON_WHITEALPHA;
    
    [self initTitle];
    [self initButtons];
    [self initCancelButton];
    
    _contentView.frame = CGRectMake((self.frame.size.width - contentViewWidth ) / 2, self.frame.size.height, contentViewWidth, contentViewHeight);
    [self addSubview:_contentView];
}

- (void)initTitle {
    if (_title != nil && ![_title isEqualToString:@""]) {
        _titleLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentViewWidth, 40)];
        _titleLabel.text            = _title;
        _titleLabel.textAlignment   = NSTextAlignmentCenter;
        _titleLabel.textColor       = [UIColor grayColor];
        _titleLabel.font            = [UIFont systemFontOfSize:TITLE_FONT_SIZE];
        _titleLabel.backgroundColor = BUTTON_WHITEALPHA;
        [_buttonView addSubview:_titleLabel];
        contentViewHeight           += _titleLabel.frame.size.height;
    }
}

- (void)initButtons {
    if (_buttonTitleArray.count > 0) {
        NSInteger count = _buttonTitleArray.count;
        for (int i = 0; i < count; i++) {
            UIView *lineView         = [[UIView alloc] initWithFrame:CGRectMake(0, contentViewHeight, contentViewWidth, 1)];
            lineView.backgroundColor = [UIColor colorWithRed:230 / 255.0 green:230 / 255.0 blue:230 / 255.0 alpha:1.0];
            [_buttonView addSubview:lineView];
            UIButton *button         = [[UIButton alloc] initWithFrame:CGRectMake(0, contentViewHeight + 1, contentViewWidth, BUTTON_HEIGHT)];
            button.backgroundColor   = BUTTON_WHITEALPHA;
            button.titleLabel.font   = [UIFont systemFontOfSize:18];
            [button setTitle:_buttonTitleArray[i] forState:UIControlStateNormal];
            [button setTitleColor:BUTTON_TitlecColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonArray addObject:button];
            [_buttonView addSubview:button];
            contentViewHeight        += lineView.frame.size.height + button.frame.size.height;
        }
        _buttonView.frame = CGRectMake(0, 0, contentViewWidth, contentViewHeight);
        [_contentView addSubview:_buttonView];
    }
}

- (void)initCancelButton {
    if (_cancelButtonTitle != nil) {
        _cancelButton                 = [[UIButton alloc] initWithFrame:CGRectMake(0, contentViewHeight + SPACE_SMALL, contentViewWidth, BUTTON_HEIGHT)];
        _cancelButton.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:.8];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
        [_cancelButton setTitleColor:BUTTON_TitlecColor forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:_cancelButton];
        contentViewHeight             += SPACE_SMALL + _cancelButton.frame.size.height;
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self initContentView];
}

- (void)setCancelButtonTitle:(NSString *)cancelButtonTitle {
    _cancelButtonTitle = cancelButtonTitle;
    [_cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
}

- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    [window addSubview:self];
    [self addAnimation];
}

- (void)hide {
    [self removeAnimation];
}

- (void)setTitleColor:(UIColor *)color fontSize:(CGFloat)size {
    if (color != nil) {
        _titleLabel.textColor = color;
    }
    if (size > 0) {
        _titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size atIndex:(int)index {
    UIButton *button = _buttonArray[index];
    if (color != nil) {
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    if (bgcolor != nil) {
        [button setBackgroundColor:bgcolor];
    }
    if (size > 0) {
        button.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)setCancelButtonTitleColor:(UIColor *)color bgColor:(UIColor *)bgcolor fontSize:(CGFloat)size {
    if (color != nil) {
        [_cancelButton setTitleColor:color forState:UIControlStateNormal];
    }
    if (bgcolor != nil) {
        [_cancelButton setBackgroundColor:bgcolor];
    }
    if (size > 0) {
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:size];
    }
}

- (void)addAnimation {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height - _contentView.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        _backgroundView.alpha = 0.7;
    } completion:^(BOOL finished) {
    }];
}

- (void)removeAnimation {
    [UIView animateWithDuration:0.3 delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        _contentView.frame = CGRectMake(_contentView.frame.origin.x, self.frame.size.height, _contentView.frame.size.width, _contentView.frame.size.height);
        _backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)buttonPressed:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheet:clickedButtonIndex:)]) {
        for (int i = 0; i < _buttonArray.count; i++) {
            if (button == _buttonArray[i]) {
                [_delegate actionSheet:self clickedButtonIndex:i];
                break;
            }
        }
    }
    [self hide];
}

- (void)cancelButtonPressed:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheetCancel:)]) {
        [_delegate actionSheetCancel:self];
    }
    [self hide];
}


@end
