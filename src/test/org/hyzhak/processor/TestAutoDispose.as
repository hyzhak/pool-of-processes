package org.hyzhak.processor {
    import flash.display.Sprite;

    public class TestAutoDispose extends Sprite {
        public function TestAutoDispose() {
            ContinuousState.newState()
                    .withSetInterval();

            ContinuousState.newState()
                    .withWeakTimer();
        }
    }
}
