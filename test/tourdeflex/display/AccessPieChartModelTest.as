package tourdeflex.display
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.setTimeout;

import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertFalse;
import org.flexunit.asserts.assertNotNull;
import org.flexunit.asserts.assertNull;
import org.flexunit.asserts.assertTrue;
import org.flexunit.async.Async;

import tourdeflex.service.AccessDataItem;

public class AccessPieChartModelTest extends EventDispatcher
{
    private var model:AccessPieChartModel;

    [Before]
    public function setup():void
    {
        model = new AccessPieChartModel();
    }

    [Test]
    public function calculate():void
    {
        model.addDataItem(AccessDataItem.fromObject({
            country: "United Kingdom",
            city: "London"
        }));
        assertTrue("model should be invalid after new item has been added", model.invalid);

        model.validate();
        assertFalse("model should be valid after validate() has been called", model.invalid);

        var ukStats:CountryStats = model.getStatsFor("United Kingdom");
        assertEquals("UK has received one visit", 1, ukStats.visits);
    }

    [Test]
    public function firstVisit():void
    {
        model.addDataItem(AccessDataItem.fromObject({
            country: "United Kingdom",
            city: "London"
        }));
        var firstVisitDate:Date = model.firstVisitDate;
        assertNotNull("the date of the first visit should be recorded", firstVisitDate);

        model.addDataItem(AccessDataItem.fromObject({
            country: "United Kingdom",
            city: "London"
        }));
        assertTrue("the date of first visit should stay unchanged", firstVisitDate.time == model.firstVisitDate.time);
    }

    [Test(async)]
    public function lastVisit():void
    {
        model.addDataItem(AccessDataItem.fromObject({
            country: "United Kingdom",
            city: "London"
        }));
        assertNotNull("the date of the last visit should be recorded", model.lastVisitDate);

        Async.handleEvent(this, this, "carryOn", function():void
        {
            model.addDataItem(AccessDataItem.fromObject({
                country: "United Kingdom",
                city: "London"
            }));
            assertFalse("the date of the first and last visit should change after the next visit",
                model.lastVisitDate.time == model.firstVisitDate.time);
        });
        setTimeout(dispatchEvent, 100, new Event("carryOn"));
    }

    [Test]
    public function reset():void
    {
        model.addDataItem(AccessDataItem.fromObject({
            country: "United Kingdom",
            city: "London"
        }));
        model.validate();
        model.reset();
        assertEquals("stats should be cleared after reset", 0, model.stats.length);
        assertNull("first visit date should be cleared after reset", model.firstVisitDate);
        assertNull("last visit date should be cleared after reset", model.lastVisitDate);
    }
}
}
