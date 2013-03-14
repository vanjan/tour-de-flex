package tourdeflex
{
import mx.logging.Log;
import mx.logging.targets.TraceTarget;

public class LogSupport
{
    private static function setUpLogging() : void
    {
        trace("Setting up logging");
        var target : TraceTarget = new TraceTarget();
        target.includeCategory = true;
        target.includeLevel = true;
        target.filters = [
            "tour.de.flex.*"
        ];
        Log.addTarget( target );
    }

    {
        setUpLogging();
    }

}
}
