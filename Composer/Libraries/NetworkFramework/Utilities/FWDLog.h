#ifdef DEBUG
    #define FWDLog(xx, ...) NSLog(@"%s(%d): " xx, ((strrchr(__FILE__, '/') ? : __FILE__- 1) + 1), __LINE__, ##__VA_ARGS__)
#else
    #define FWDLog(xx, ...) ((void)0)
#endif

#define FWDLogRect(r) FWDLog(@"%s x=%f, y=%f, w=%f, h=%f", #r, r.origin.x, r.origin.y, r.size.width, r.size.height)