package tourdeflex.display
{
import mx.logging.ILogger;
import mx.logging.Log;

import spark.components.supportClasses.SkinnableComponent;

import tourdeflex.service.AccessDataItem;

public class AccessDataDisplay extends SkinnableComponent
{
    private static const LOG : ILogger = Log.getLogger( "tour.de.flex.display" );

    public function AccessDataDisplay()
    {
        model = new AccessPieChartModel();
    }

    [Bindable]
    public var model:AccessPieChartModel;

    private var _running:Boolean;
    private var runningChanged:Boolean;

    [Bindable]
    public function get running():Boolean
    {
        return _running;
    }

    public function set running( value:Boolean ):void
    {
        if (value != _running)
        {
            _running = value;
            runningChanged = true;
            invalidateProperties();
        }
    }

    override protected function commitProperties():void
    {
        super.commitProperties();
        if (runningChanged)
        {
            if (running)
            {
                model.reset();
            }
            runningChanged = false;
        }
        if (model.invalid)
        {
            model.validate();
        }
    }

    public function addDataItem( dataItem:AccessDataItem ):void
    {
        LOG.debug( "new data item arrived {0}", dataItem );
        model.addDataItem(dataItem);
        invalidateProperties();
    }
}
}
