/**
 * Created by Jan Klosinski on 10/03/2013
 */
package tourdeflex.service
{
import flash.events.Event;

public class UpdateEvent extends Event
{
    public static const UPDATE:String = "update";

    public function UpdateEvent( dataItem:AccessDataItem )
    {
        super(UPDATE);
        this.dataItem = dataItem;
    }

    public var dataItem:AccessDataItem;

    override public function clone():Event
    {
        return new UpdateEvent(dataItem);
    }
}
}
