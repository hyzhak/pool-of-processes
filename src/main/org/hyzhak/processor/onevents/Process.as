package org.hyzhak.processor.onevents {
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    /**
     * Base implementation of any long passed process
     */
    public class Process extends EventDispatcher {
        /**
         * Complete process just in a moment. Works like setTimeout but on Timer
         */
        public function completeInAMoment():void {
            var timer:Timer = new Timer(0);
            timer.addEventListener(TimerEvent.TIMER, processCompletion, false, 0, true);
            timer.start();
        }

        private function processCompletion(event:Event = null):void {
            dispatchEvent(new Event(Event.COMPLETE));
        }

        /**
         * Complete process right now
         */
        public function complete():void {
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }
}
