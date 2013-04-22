package org.hyzhak.processor.onpromises {
    import com.codecatalyst.promise.Deferred;

    import flash.utils.Dictionary;

    public class ProcessesPoolOnPromise {
        private var _processedPool:Dictionary = new Dictionary();

        public function store(instance:Object, deferred:Deferred):void {
            _processedPool[instance] = true;
            deferred.promise.then(function(value:*):void {
                delete _processedPool[instance];
                instance = null;
            }, function(value:*):void {
                delete _processedPool[instance];
                instance = null;
            });
//            deferred.promise.then(clear, clear);
        }

        private function clear(value:*):void {
            _processedPool = null
        }
    }
}
