package tourdeflex.service
{
import flash.events.EventDispatcher;
import flash.events.TimerEvent;
import flash.utils.Timer;

import mx.logging.ILogger;
import mx.logging.Log;

public class MockAccessService extends EventDispatcher implements IAccessService
{
    private static const LOG:ILogger = Log.getLogger("tour.de.flex.service");

    private var timer:Timer;

    public function MockAccessService():void
    {
        timer = new Timer(1000);
        timer.addEventListener(TimerEvent.TIMER, sendRandomResult);
    }

    private function sendRandomResult( event:TimerEvent ):void
    {
        var times:int = Math.floor(Math.random() * 3) + 1;
        LOG.debug( "dispatching {0} updates", times );
        for ( var i:int = 0; i < times; i++ )
        {
            var dataItem:AccessDataItem = dataItems[i];
            dispatchEvent(new UpdateEvent(dataItem));
        }
    }

    public function get running():Boolean
    {
        return timer.running;
    }

    public function on():void
    {
        timer.start();
    }

    public function off():void
    {
        timer.stop();
    }

    private static var dataItems:Array /* of AccessDataItem */ = [
        AccessDataItem.fromObject({
            city: "London",
            country: "United Kingdom"
        }),
        AccessDataItem.fromObject({
            city: "Berlin",
            country: "Germany"
        }),
        AccessDataItem.fromObject({
            city: "Paris",
            country: "France"
        })
    ];
}
}
