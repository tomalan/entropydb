## Description ##

**EntropyDB** is an embedded object database for Mac OS X 10.5 and iPhone OS written in Objective-C. It is built on top of SQLite.
You can embed it in your own application or you can use it for RAD (**Rapid Application Development**) or **Rapid Prototyping** for iPhone with the open source **[Rapid](http://code.google.com/p/rappid/) tool**.
It has the following advantages:

  * It is simple to use since it is an object database, i.e., you don't have to use SQL but you only work with Objective-C objects.
  * The database can be embedded in both OS X 10.5 applications and iPhone applications (the current version can be used in the iPhone Simulator).
  * No configuration is required.
  * Instances of descendants of _NSObject_ can be stored directly without providing any additional information.
  * Database contents can be **synchronized** among multiple database instances automatically.

**EntropyDB** can be used similarly to db4objects (db4o). The current preview version is distributed as a static library and can be embedded in Xcode projects by adding the header files and the file _libEntropyLib.a_ to _Classes_ and _Frameworks_, respectively.

## License ##

The code is licensed under LGPL.