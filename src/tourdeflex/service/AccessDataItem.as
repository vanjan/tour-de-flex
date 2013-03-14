/**
 * Created by Jan Klosinski on 10/03/2013
 */
package tourdeflex.service
{
import mx.utils.StringUtil;

public class AccessDataItem
{
    public static function fromObject( obj:Object ):AccessDataItem
    {
        var item:AccessDataItem = new AccessDataItem();
        item.city = obj.city;
        item.country = obj.country;
        return item;
    }

    public var city:String;
    public var country:String;

    public function toString():String
    {
        return StringUtil.substitute("[AccessDataItem(city={0}, country={1})]", city, country);
    }
}
}
