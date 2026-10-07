#import <UIKit/UIKit.h>

__attribute__((constructor))
static void RyumaGradientInit(void)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = nil;

        for (UIScene *scene in UIApplication.sharedApplication.connectedScenes) {
            if (![scene isKindOfClass:[UIWindowScene class]]) continue;

            for (UIWindow *w in ((UIWindowScene *)scene).windows) {
                if (w.isKeyWindow) {
                    window = w;
                    break;
                }
            }

            if (window) break;
        }

        if (!window) return;

        UILabel *label = [[UILabel alloc]
            initWithFrame:CGRectMake(0, 80, window.bounds.size.width, 45)];

        label.text = @"@Ryumax1";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:24.0];

        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = label.bounds;
        gradient.colors = @[
            (id)[UIColor systemRedColor].CGColor,
            (id)[UIColor systemPurpleColor].CGColor,
            (id)[UIColor systemBlueColor].CGColor,
            (id)[UIColor systemGreenColor].CGColor
        ];
        gradient.startPoint = CGPointMake(0, 0.5);
        gradient.endPoint = CGPointMake(1, 0.5);

        UIGraphicsImageRenderer *renderer =
            [[UIGraphicsImageRenderer alloc] initWithSize:label.bounds.size];

        UIImage *image = [renderer imageWithActions:^(UIGraphicsImageRendererContext *ctx) {
            [gradient renderInContext:ctx.CGContext];
        }];

        label.textColor = [UIColor colorWithPatternImage:image];

        [window addSubview:label];
    });
}
