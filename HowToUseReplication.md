## Replication architecture ##

With **EntropyDB**, you can replicate data between database instances automatically. For example, one instance can be on a mobile device and another one on a desktop computer. The replication mechanism ensures that the contents of the database is synchronized all the time.

A database instance (secondary) can share data with one instance only (primary). However, more secondary database instances can communicate with one primary instance.

If you would like an instance of _EXContainer_ to provide its contents to other database instances over the Internet, you must use the method _allowMessagingOnPort:_ (typically, this primary database instance will be running on a server with a permanent network connection).

A local database instance of _EXContainer_ (typically on a mobile device) can synchronize its contents with a server database instance by using the method _synchronizeWithPort:host:_.

**Important:** Only descendants of _EXSharedObject_ which provide _encodeWithCoder:_ or _initWithCoder:_ can be synchronized among database instances.

## Delegates ##

Use the method _setDelegate:_ of _EXContainer_ to set a delegate object which will be notified when an object has been updated or removed in the local database instance; the delegate will receive the message _didReceiveUpdate:_ or _didReceiveDeletion:_, respectively. The argument of the message is the updated or removed object.