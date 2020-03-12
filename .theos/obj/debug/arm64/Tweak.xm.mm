#line 1 "Tweak.xm"
#import "Rotaty.h"

static BOOL shouldAnimate = NO;

float rotateDegree = -15;


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
static void (*_logos_orig$_ungrouped$SBIconView$setIcon$)(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST, SEL, SBIcon *); static void _logos_method$_ungrouped$SBIconView$setIcon$(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST, SEL, SBIcon *); 

#line 7 "Tweak.xm"

static void _logos_method$_ungrouped$SBIconView$setIcon$(_LOGOS_SELF_TYPE_NORMAL SBIconView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, SBIcon * arg1) {
    _logos_orig$_ungrouped$SBIconView$setIcon$(self, _cmd, arg1);

    
    CGFloat rotateBy = rotateDegree * pi / 180 ;

    if (shouldAnimate == YES) {
        
        [UIView animateWithDuration:0.5 animations:^{
            self.transform = CGAffineTransformRotate(CGAffineTransformIdentity,rotateBy);
        }
        completion:nil];
    } else {
        
        [self setTransform:(CGAffineTransformRotate(CGAffineTransformIdentity,rotateBy))];
    }
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SBIconView = objc_getClass("SBIconView"); MSHookMessageEx(_logos_class$_ungrouped$SBIconView, @selector(setIcon:), (IMP)&_logos_method$_ungrouped$SBIconView$setIcon$, (IMP*)&_logos_orig$_ungrouped$SBIconView$setIcon$);} }
#line 26 "Tweak.xm"
