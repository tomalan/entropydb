## Introduction ##

This document contains code examples that explain how to use **EntropyDB** for persistency of objects.

## Opening a database ##

The following piece of code opens the database in a file called _test.db_ in the default document directory of the current iPhone application. The database file is created if it does not exist.

```
		NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString* documentsDirectory = [paths objectAtIndex: 0];
		NSString* dbFileName = [documentsDirectory stringByAppendingFormat: @"/test.db"];
		EXFile* file = [EXFile fileWithName: dbFileName];
		EXContainer* container = [[EXContainer alloc] initWithFile: file];
```

## Closing a database ##

A database is closed by releasing the instance of _EXContainer_.

```
		[container release];
```

Instances of _EXContainer_ should not be autoreleased.

## Storing an object in a database ##

An object can be stored in the database by calling the method _storeObject:_ of _EXContainer_.

```
		id customObject = [[CustomObject alloc] init];
		[container storeObject: customObject];
		[customObject release];
```

The following restrictions apply:
  * Only descendants of _NSObject_ can be stored.
  * One cannot store instances of Cocoa classes directly. Collections (_NSArray_, _NSSet_, _NSDictionary_) can be stored if they are instance variables of custom objects.
  * Instance variables of the following primitive types are stored: _int, long, char, short, long long, float, double_ (unsigned types are not supported in the current version).
  * Instance variables which are instances of objects will be restored with their retain count equal to 1.
  * You cannot store object hierarchies with reference cycles.

## Querying objects from a database ##

All objects of a certain class can be loaded from the database by using the method _queryWithClass:_.

```
		NSArray* resultSet = [container queryWithClass: [CustomObject class]];
		for (id object in resultSet) {
			// processing the object
		}
```

The result set is autoreleased.

One can load all objects of a certain class that conform to a certain condition by using the method _queryWithClass:predicate:_.

```
		EXPredicate* predicate = [[[EXPredicateEqualText alloc] initWithFieldName: @"company" value: @"Apple, Inc."] autorelease];
		NSArray* resultSet = [container queryWithClass: [CustomObject class] predicate: predicate];
		for (id object in resultSet) {
			// processing the object
		}
```

If a predicate operates with an atomic value, the query is optimized (the index for the field defined in the predicate is used) which makes queries significantly faster. Unoptimized queries will instantiate all objects of the queried type and then they will be filtered according to the predicate's expression.

**NB:** If you load an object from the database, potential referenced objects will not be loaded (instantiated) until you access them directly by sending a message. Untouched referenced objects will not be stored while the enclosing object being stored recursively. This strategy (lazy loading) allows for having complex object graphs and storing only changed parts of them instead of all accessible objects.

In the current preview version, there are only three predicate classes, namely _EXPredicateEqualText_, _EXPredicateEqualInt_ and _EXPredicateEqualInt64_, that can be used to load objects with a certain string value, an integer value or a long long integer value, respectively, in an instance variable of type _NSString_/_int_/_long long_ (as shown in the above code example).

## Transactions ##

Each method that modifies the database is performed within a separate transaction by default. If there are many updates to be done, it is significantly faster to perform them within one transaction. The following code sample exemplifies this:

```
	EXTransaction* transaction = [container transaction];
	@try {
		for (id object in objects) [transaction storeObject: object];
		[transaction commit];
	} @catch (NSException* exception) {
		[transaction rollback];
		NSLog(@"exception: %@", exception);
	}
```

The transaction object is autoreleased and it retains the container.