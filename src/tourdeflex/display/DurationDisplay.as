package tourdeflex.display
{
import flash.events.TimerEvent;
import flash.utils.Timer;

import mx.controls.Label;

import spark.formatters.DateTimeFormatter;

public class DurationDisplay extends Label
{
    public function DurationDisplay()
    {
        timer = new Timer(1000);
        timer.addEventListener(TimerEvent.TIMER, updateText);

        formatter = new DateTimeFormatter();
        formatter.dateTimePattern = "HH:mm:ss";
    }

    private var timer:Timer;
    private var formatter:DateTimeFormatter;

    //-----------------------------------
    //  since
    //-----------------------------------

    /**
     * @private
     * Storage for the since property.
     */
    private var _since : Date;

    /**
     * The date since when the duration is calculated.
     */
    public function set since( value : Date ) : void
    {
        _since = value;
        invalidateProperties();
    }

    //-----------------------------------
    //  running
    //-----------------------------------

    /**
     * @private
     * Storage for the running property.
     */
    private var _running : Boolean;

    /**
     * @private
     */
    public function set running( value : Boolean ) : void
    {
        _running = value;
        invalidateProperties();
    }

    override protected function commitProperties():void
    {
        super.commitProperties();
        if (_since)
        {
            timer.start();
            updateText();
        }
        else
        {
            timer.stop();
            text = null;
        }
        if (_running)
        {
            timer.start();
        }
        else
        {
            timer.stop();
        }
    }

    private function updateText( event:TimerEvent = null ):void
    {
        var now:Date = new Date();
        var duration:Date = new Date(now.time - _since.time);
        text = formatter.format(duration);
    }
}
}
