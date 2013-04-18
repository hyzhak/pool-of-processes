package org.hyzhak.processor {
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import flash.utils.setInterval;

    public class ContinuousState extends EventDispatcher {
        private static var _processedPool:Dictionary = new Dictionary();

        public static function newState():ContinuousState {
            var instance:ContinuousState = new ContinuousState();
            _processedPool[instance] = true;
            instance.addEventListener(Event.COMPLETE, removeFromProcessedPool, false, 0, true);

            return instance;
        }

        private static function removeFromProcessedPool(event:Event):void {
            var instance:ContinuousState = event.target as ContinuousState;
            delete _processedPool[instance];
        }

        private var _type:String;
        private var _count:int = 10;
        private var _iteration:int = 0;

        public function withSetInterval():ContinuousState {
            setInterval(process, 10);
            _type = "setInterval";
            return this;
        }

        public function withWeakTimer():ContinuousState {
            var timer:Timer = new Timer(10);
            timer.addEventListener(TimerEvent.TIMER, process, false, 0, true);
            timer.start();
            _type = "weak timer";
            return this;
        }

        private function process(event:Event = null):void {
            if (++_iteration >= _count) {
                dispatchEvent(new Event(Event.COMPLETE));
            }
            trace(_type + " still alive", _iteration, _count);
        }
    }
}
