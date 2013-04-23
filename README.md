Pool of Processes
=================

Utils library to create [fluet interface](http://en.wikipedia.org/wiki/Fluent_interface) based on long processes. Support Events and [Promises/A](https://github.com/CodeCatalyst/promise-as3).

## Use Case Example

```actionscript

//Usage with Promises/A

FluentInterface.newProcess()
	.processSuccessful("Ok!").then(function(value:Object):void {
		//Do something
	});

//Definition with Promises/A

class FluentInterface extends ProcessOnPromise {

    private static var _pool:ProcessesPoolOnPromise;

    public static function newProcess():FluentInterface {
        _pool = new ProcessesPoolOnPromise();
        var deferred:Deferred = new Deferred();
        var instance:FluentInterface = new FluentInterface(deferred);
        _pool.store(instance, deferred);
        return instance;
    }

    public function FluentInterface(deferred:Deferred) {
        super(deferred);
    }

    public function processSuccessful(result:*):Promise {
    	//Do some stuff        
        resolveInAMoment(result);
        return _deferred.promise;
    }

    public function processUnsuccessful(result:*):Promise {
    	//Do some stuff
        rejectInAMoment(result);
        return _deferred.promise;
    }
}

```

# Additional info

Syntax Sugar for Testing as3 Promise/A.