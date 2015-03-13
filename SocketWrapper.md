The class _LXSocket_ is a convenient wrapper for low-level sockets which allows for sending atomic values and objects over the network. ObjC objects are serialized.

A server socket can be created as follows:

```
	LXSocket* serverSocket = [[LXSocket alloc] init];
	[serverSocket bindToPort: port];
	[serverSocket listen: maxNumberOfConnections];
```

One can then accept connections using the _accept_ method:

```
	LXSocket* socket = [serverSocket accept];
```

To create a client socket, use:

```
	LXSocket* socket = [[LXSocket alloc] init];
	if ([socket connect: host port: port] == NO) { [socket release]; NSLog(@"cannot create socket"); }
```

If the socket has been created successfully, you can send and receive atomic values and objects:

```
	id object = [socket readObject];
	[socket sendObject: object];
```

Sent/received objects must conform to _NSCoding_, i.e., they have to respond to _encodeWithCoder:_ and _initWithCoder:_.