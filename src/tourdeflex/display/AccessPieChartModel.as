package tourdeflex.display
{
import mx.collections.ArrayCollection;

import tourdeflex.service.AccessDataItem;

public class AccessPieChartModel
{
    public var stats:ArrayCollection = new ArrayCollection();

    private var statsByCountry:Object = {};
    private var dataItemQueue:Array = [];

    [Bindable]
    public var firstVisitDate:Date;

    [Bindable]
    public var lastVisitDate:Date;

    public function addDataItem( dataItem:AccessDataItem ):void
    {
        _invalid = true;
        dataItemQueue.push(dataItem);
        if (!firstVisitDate)
        {
            firstVisitDate = new Date();
        }
        lastVisitDate = new Date();
    }

    private var _invalid:Boolean = false;

    public function get invalid():Boolean
    {
        return _invalid;
    }

    public function validate():void
    {
        while (dataItemQueue.length > 0)
        {
            var dataItem:AccessDataItem = dataItemQueue.pop();
            var countryStats:CountryStats = getStatsFor(dataItem.country);
            countryStats.visits++;
        }
        _invalid = false;
    }

    public function getStatsFor( country:String ):CountryStats
    {
        if (!statsByCountry.hasOwnProperty(country))
        {
            stats.addItem(statsByCountry[country] = new CountryStats(country));
        }
        return statsByCountry[country];
    }

    public function reset():void
    {
        stats.removeAll();
        statsByCountry = {};
        firstVisitDate = null;
        lastVisitDate = null;
    }
}
}
