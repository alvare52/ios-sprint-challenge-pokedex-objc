# Manual Reference Counting

Answer the following questions inline with this document.

1. Are there memory leaks with this code? (If so, where are the leaks?) - Yes. punctuationSet was never released. And the if/else inside the for loop should be wrapped in an @NSAutoreleasePool {}

	```swift
	NSString *quote = @"Your work is going to fill a large part of your life, and the only way to be truly satisfied is to do what you believe is great work. And the only way to do great work is to love what you do. If you haven't found it yet, keep looking. Don't settle. As with all matters of the heart, you'll know when you find it. - Steve Jobs";

	NSCharacterSet *punctuationSet = [[NSCharacterSet punctuationCharacterSet] retain];

	NSString *cleanQuote = [[quote componentsSeparatedByCharactersInSet:punctuationSet] componentsJoinedByString:@""];
	NSArray *words = [[cleanQuote lowercaseString] componentsSeparatedByString:@" "];

	NSMutableDictionary<NSString *, NSNumber *> *wordFrequency = [[NSMutableDictionary alloc] init];

	for (NSString *word in words) {
		NSNumber *count = wordFrequency[word];
		if (count) {
			wordFrequency[word] = [NSNumber numberWithInteger:count.integerValue + 1];
		} else {
			wordFrequency[word] = [[NSNumber alloc] initWithInteger:1];
		}
	}

	printf("Word frequency: %s", wordFrequency.description.UTF8String);

	```

	2. Rewrite the code so that it does not leak any memory with ARC disabled

2. Which of these objects is autoreleased?  Why?

1. `NSDate *yesterday = [NSDate date];` // YES autorelease. We don't won this
	
	2. `NSDate *theFuture = [[NSDate dateWithTimeIntervalSinceNow:60] retain];` // NO autorelease. We own this (retain)
	
	3. `NSString *name = [[NSString alloc] initWithString:@"John Sundell"];` // NO autorelease. We own this (init)
	
	4. `NSDate *food = [NSDate new];` // NO autorelease. We own this (new)
	
	5. `LSIPerson *john = [[LSIPerson alloc] initWithName:name];`// NO autorelease. We own this (init)
	
	6. `LSIPerson *max = [[[LSIPerson alloc] initWithName:@"Max"] autorelease];`// NO autorelease. We own this (init)

3. Explain when you need to use the `NSAutoreleasePool`.

- We need to use NSAutoreleasePool when we are using for loops that will be creating thousands of objects
, which can potentially take up more memory than the app is allowed, even if the objects will go out of scope after the loop stops.


4. Implement a convenience `class` method to create a `LSIPerson` object that takes a `name` property and returns an autoreleased object.

```swift
@interface LSIPerson: NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name {

    if (self = [super init]) {
        _name = name;
    }
    return [self autorelease];
}


@end
```
