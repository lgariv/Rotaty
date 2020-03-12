#line 1 "Tweak.xm"
#import "Rotaty.h"

static BOOL isEnabled = NO;
static BOOL shouldAnimate;

static float animDuration = 0.5;
static float rotateDegree;

static void loadPrefs();


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SBIconView; 


#line 11 "Tweak.xm"
static void (*_logos_orig$enableTweak$SBIconView$setIcon$)(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST, SEL, SBIcon *); static void _logos_method$enableTweak$SBIconView$setIcon$(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST, SEL, SBIcon *); 

static void _logos_method$enableTweak$SBIconView$setIcon$(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, SBIcon * arg1) {
    _logos_orig$enableTweak$SBIconView$setIcon$(self, _cmd, arg1);

    
    CGFloat rotateBy = rotateDegree * pi / 180 ;

    if (shouldAnimate == YES) {
        
        [UIView animateWithDuration:animDuration animations:^{
            self.transform = CGAffineTransformRotate(CGAffineTransformIdentity,rotateBy);
        }
        completion:nil];
    } else {
        
        [self setTransform:(CGAffineTransformRotate(CGAffineTransformIdentity,rotateBy))];
    }
}



static void loadPrefs() {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.stoinks.rotatyprefs.plist"];
    if ( [prefs objectForKey:@"isEnabled"] ? [[prefs objectForKey:@"isEnabled"] boolValue] : isEnabled ) {
        {Class _logos_class$enableTweak$SBIconView = objc_getClass("SBIconView"); MSHookMessageEx(_logos_class$enableTweak$SBIconView, @selector(setIcon:), (IMP)&_logos_method$enableTweak$SBIconView$setIcon$, (IMP*)&_logos_orig$enableTweak$SBIconView$setIcon$);}
        shouldAnimate = [[prefs objectForKey:@"shouldAnimate"] boolValue];
        rotateDegree = ![[prefs objectForKey:@"rotateDegree"] floatValue];
    }
}

static __attribute__((constructor)) void _logosLocalCtor_d26df6f8(int __unused argc, char __unused **argv, char __unused **envp) {
    loadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.stoinks.rotatyprefs/prefschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
