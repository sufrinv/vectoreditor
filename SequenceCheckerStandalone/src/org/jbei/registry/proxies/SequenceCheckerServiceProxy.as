package org.jbei.registry.proxies
{
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.InvokeEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.jbei.lib.utils.Logger;
	import org.jbei.registry.Notifications;
	import org.jbei.registry.utils.StandaloneUtils;

	public class SequenceCheckerServiceProxy extends AbstractServiceProxy
	{
		public static const NAME:String = "SequenceCheckerServiceProxy";
		private static const SEQUENCE_CHECKER_SERVICE_NAME:String = "SequenceCheckerService";
		
		private var _traces:ArrayCollection /* TraceSequence */;
		
		// Constructor
		public function SequenceCheckerServiceProxy()
		{
			super(NAME, SEQUENCE_CHECKER_SERVICE_NAME);
		}
		
		// Properties
		public function get traces():ArrayCollection /* of TraceSequence */
		{
			return _traces;
		}
		
		// Public Methods
		public function fetchTraces(authToken:String, entryId:String):void
		{
			CONFIG::standalone {
				updateTraces(StandaloneUtils.standaloneTraces() as ArrayCollection);
				
				return;
			}
			
			service.getTraces(authToken, entryId);
		}
		
		// Protected Methods
		protected override function onServiceFault(event:FaultEvent):void
		{
			sendNotification(Notifications.APPLICATION_FAILURE, serviceName + " failed!");
		}
		
		protected override function onServiceInvoke(event:InvokeEvent):void
		{
			sendNotification(Notifications.FETCHING_DATA, "Calling " + serviceName + "...");
		}
		
		protected override function registerServiceOperations():void
		{
			service.getTraces.addEventListener(ResultEvent.RESULT, onSequenceCheckerServiceGetTracesResult);
		}
		
		// Private Methods
		private function onSequenceCheckerServiceGetTracesResult(event:ResultEvent):void
		{
			if(!event.result) {
				sendNotification(Notifications.APPLICATION_FAILURE, "Failed to fetch traces!");
				
				return;
			}
			
			sendNotification(Notifications.DATA_FETCHED);
			
			updateTraces(event.result as ArrayCollection);
		}
		
		private function updateTraces(traces:ArrayCollection):void
		{
			_traces = traces;
			
			sendNotification(Notifications.TRACES_FETCHED);
			
			Logger.getInstance().info("Traces fetched successfully");
		}
	}
}