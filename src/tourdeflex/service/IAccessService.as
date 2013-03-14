package tourdeflex.service
{
import flash.events.IEventDispatcher;

/**
 * Dispatched when new data has arrived.
 */
[Event(name="update", type="tourdeflex.service.UpdateEvent")]

public interface IAccessService extends IEventDispatcher
{
    function get running():Boolean;

    function on():void;

    function off():void;
}
}
