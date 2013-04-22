package org.hyzhak.processor.onevents {
    import flash.events.Event;
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;

    public class ProcessesPool {
        private static var _processedPool:Dictionary = new Dictionary();

        public function store(instance:IEventDispatcher):void {
            _processedPool[instance] = true;
            instance.addEventListener(Event.COMPLETE, removeFromProcessedPool, false, 0, true);
        }

        private function removeFromProcessedPool(event:Event):void {
            delete _processedPool[event.target];
        }
    }
}
