package tourdeflex.service
{
import flash.events.EventDispatcher;

import mx.messaging.ChannelSet;
import mx.messaging.Consumer;
import mx.messaging.channels.HTTPChannel;
import mx.messaging.channels.RTMPChannel;
import mx.messaging.events.MessageEvent;

public class AccessService extends EventDispatcher implements IAccessService
{
    public function AccessService()
    {
        var channelSet:ChannelSet = new ChannelSet();
        channelSet.addChannel(new RTMPChannel("rtmp", "rtmp://tourdeflex.adobe.com:2037"));
        channelSet.addChannel(new HTTPChannel("http long polling", "http://tourdeflex.adobe.com:8080/lcds-samples/messagebroker/amflongpolling"));
        channelSet.addChannel(new HTTPChannel("http polling", "http://tourdeflex.adobe.com:8080/lcds-samples/messagebroker/amfpolling"));
        consumer = new Consumer();
        consumer.channelSet = channelSet;
        consumer.destination = "tdf.sampleviewingfeed";
        consumer.addEventListener(MessageEvent.MESSAGE, messageHandler);
    }

    private var consumer:Consumer;

    public function get running():Boolean
    {
        return consumer.subscribed;
    }

    public function on():void
    {
        consumer.subscribe();
    }

    public function off():void
    {
        consumer.unsubscribe();
    }

    private function messageHandler( event:MessageEvent ):void
    {
        dispatchEvent(new UpdateEvent(AccessDataItem.fromObject(event.message.body)));
    }
}
}
