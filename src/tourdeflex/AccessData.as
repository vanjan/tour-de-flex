package tourdeflex
{
import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.EventDispatcher;

import mx.core.IMXMLObject;

import org.spicefactory.parsley.view.FastInject;

import tourdeflex.service.*;

[Event(name="update", type="tourdeflex.service.UpdateEvent")]

public class AccessData extends EventDispatcher implements IMXMLObject
{
    public var service:IAccessService;

    [Bindable("runningChange")]
    public function get running():Boolean
    {
        return service ? service.running : false;
    }

    public function initialized( document:Object, id:String ):void
    {
        FastInject.view(document as DisplayObject)
            .target(this)
            .property("service")
            .type(IAccessService)
            .complete(function():void
            {
                service.addEventListener(UpdateEvent.UPDATE, dispatchEvent);
            })
            .execute();
    }

    public function toggle():void
    {
        if (service.running)
        {
            service.off();
        }
        else
        {
            service.on();
        }
        // trigger data binding
        dispatchEvent(new Event("runningChange"));
    }
}
}
