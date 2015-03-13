**Please check out the latest changes from the SVN repository**

Let's declare a simple entity class:

```
@interface Person : NSObject {
	NSString* name;
	unsigned age;
}

- (id)initWithName:(NSString*)_name age:(unsigned)_age;
- (unsigned)age;

@end

@implementation Person

- (id)initWithName:(NSString*)_name age:(unsigned)_age {
	if (self = [super init]) {
		name = [_name retain];
		age = _age;
	}
	return self;
}

- (unsigned)age {
	return age;
}

- (NSString*)description {
	return [NSString stringWithFormat: @"%@ %u", name, age];
}

- (void)dealloc {
	[name release];
	[super dealloc];
}

@end
```

Now we'll store some objects:

```
	EXContainer* container = [[[EXContainer alloc] initWithFile: [EXFile fileWithName: [@"~/blocks.db" stringByExpandingTildeInPath]]] autorelease];
	[container storeObject: [[[Person alloc] initWithName: @"Pedro" age: 30] autorelease]];
	[container storeObject: [[[Person alloc] initWithName: @"Juanita" age: 20] autorelease]];
```

And here's how we can query for objects using blocks (closures):

```
	NSArray* result = [container queryWithClass: [Person class] condition: ^BOOL(id person) { return [person age] <= 25; }];
	NSLog(@"%@", result);
```