package org.hyzhak.processor.onpromises {
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;
    import flash.system.System;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import flash.utils.setTimeout;

    import org.flexunit.async.Async;
    import org.hamcrest.assertThat;
    import org.hamcrest.object.nullValue;

    public class ProcessesPoolOnPromiseTests extends EventDispatcher{
        private var _weakLink:Dictionary;

        [Before]
        public function clearPool():void {
            _weakLink = new Dictionary(true);
        }

        [Test(async)]
        public function testDisposeOfProcess() :void {
            var pool:ProcessesPoolOnPromise = new ProcessesPoolOnPromise();
            var instance:FluentInterface = FluentInterface.newProcess(pool);
            instance.processSuccessful("Ok!").then(waitFotAMoment);

            _weakLink[instance] = true;

            var tmpInstance:* = new TestClass();

            _weakLink[tmpInstance] = true;

            _weakLink[pool] = true;

            addEventListener(Event.COMPLETE, Async.asyncHandler(this, assertThatWeakLinkHasDisposed, 1000));
        }

        private function assertThatWeakLinkHasDisposed(event:Event = null, value:* = null):void {
            for(var link:* in _weakLink) {
                assertThat(link, nullValue());
            }
        }

        private function waitFotAMoment(value:*):void {
            System.gc();
            var timer:Timer = new Timer(10, 1);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, checkWeakLink, false, 0, true)
            timer.start();
        }

        private function checkWeakLink(event:Event = null):void {
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }
}

import com.codecatalyst.promise.Deferred;
import com.codecatalyst.promise.Promise;

import flash.system.System;

import flash.utils.Dictionary;

import org.hyzhak.processor.onpromises.ProcessOnPromise;
import org.hyzhak.processor.onpromises.ProcessesPoolOnPromise;

class TestClass {

}

class FluentInterface extends ProcessOnPromise {

    public static function newProcess(pool:ProcessesPoolOnPromise):FluentInterface {
        var deferred:Deferred = new Deferred();
        var instance:FluentInterface = new FluentInterface(deferred);
        pool.store(instance, deferred);
        return instance;
    }

    public function FluentInterface(deferred:Deferred) {
        super(deferred);
    }

    public function processSuccessful(result:*):Promise {
        resolveInAMoment(result);
        return _deferred.promise;
    }

    public function processUnsuccessful(result:*):Promise {
        rejectInAMoment(result);
        return _deferred.promise;
    }
}