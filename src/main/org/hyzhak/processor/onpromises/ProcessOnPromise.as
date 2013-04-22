package org.hyzhak.processor.onpromises {
    import com.codecatalyst.promise.Deferred;

    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    public class ProcessOnPromise {
        protected var _deferred:Deferred;
        private var _result:*;
        private var _successful:Boolean;

        public function ProcessOnPromise(deferred:Deferred) {
            _deferred = deferred;
        }

        /**
         * Complete process just in a moment. Works like setTimeout but on Timer
         */
        public function completeInAMoment(result:*, successful:Boolean):void {
            _result = result;
            _successful = successful;

            var timer:Timer = new Timer(0, 1);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, processCompletion, false, 0, true);
            timer.start();
        }

        /**
         * Short version of function completeInAMmoment()
         * @param result
         */
        public function resolveInAMoment(result:*):void {
            completeInAMoment(result, true);
        }

        public function rejectInAMoment(result:*):void {
            completeInAMoment(result, false);
        }

        private function processCompletion(event:Event = null):void {
            complete(_result, _successful);
        }

        /**
         * Complete process right now
         */
        public function complete(result:*, successful:Boolean):void {
            if (successful) {
                _deferred.resolve(result);
            } else {
                _deferred.reject(result);
            }
        }
    }
}
