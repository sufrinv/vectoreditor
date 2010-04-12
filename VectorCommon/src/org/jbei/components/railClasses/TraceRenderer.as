package org.jbei.components.railClasses
{
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	
	import org.jbei.bio.data.Segment;
	import org.jbei.bio.data.TraceAnnotation;
	import org.jbei.components.common.AnnotationRenderer;

	public class TraceRenderer extends AnnotationRenderer
	{
		public static const RAIL_GAP:Number = 10;
		public static const DEFAULT_GAP:int = 7;
		private const MATCH_COLOR:int = 0x31B440;
		private const MISMATCH_COLOR:int = 0xFF0000;
		
		private var alignmentRowIndex:int;
		private var bpWidth:Number;
		private var railMetrics:Rectangle;
		
		// Contructor
		public function TraceRenderer(contentHolder:ContentHolder, traceAnnotation:TraceAnnotation)
		{
			super(contentHolder, traceAnnotation);
		}
		
		// Properties
		public function get traceAnnotation():TraceAnnotation
		{
			return annotation as TraceAnnotation;
		}
		
		// Public Methods
		public function update(railMetrics:Rectangle, bpWidth:Number, alignmentRowIndex:int):void
		{
			this.alignmentRowIndex = alignmentRowIndex;
			this.railMetrics = railMetrics;
			this.bpWidth = bpWidth;
			
			needsMeasurement = true;
			invalidateDisplayList();
		}
		
		// Protected Methods
		protected override function render():void
		{
			var g:Graphics = graphics;
			g.clear();
			
			var startPosition:Number = railMetrics.x + bpWidth * traceAnnotation.start;
			var endPosition:Number = railMetrics.x + bpWidth * traceAnnotation.end;
			
			var yPosition:Number = railMetrics.y - RAIL_GAP - alignmentRowIndex * DEFAULT_GAP;
			
			var matches:ArrayCollection = traceAnnotation.matches;
			var mismatches:ArrayCollection = traceAnnotation.mismatches;
			var deletions:ArrayCollection = traceAnnotation.deletions;
			var insertions:ArrayCollection = traceAnnotation.insertions;
			
			if(matches == null && matches.length == 0) {
				return;
			}
			
			// render matches
			g.lineStyle(2, MATCH_COLOR);
			for(var i1:int = 0; i1 < matches.length; i1++) {
				var matchSegment:Segment = matches[i1] as Segment;
				
				var matchStartPosition:Number = railMetrics.x + bpWidth * matchSegment.start;
				var matchEndPosition:Number = railMetrics.x + bpWidth * matchSegment.end;
				
				if(matchStartPosition == matchEndPosition) {
					matchStartPosition -= bpWidth / 2;
					matchEndPosition += bpWidth / 2;
				}
				
				g.moveTo(matchStartPosition, yPosition);
				g.lineTo(matchEndPosition, yPosition);
			}
			
			// render mismatches
			if(mismatches != null && mismatches.length > 0) {
				g.lineStyle(4, MISMATCH_COLOR);
				for(var i2:int = 0; i2 < mismatches.length; i2++) {
					var mismatchSegment:Segment = mismatches[i2] as Segment;
					
					var mismatchStartPosition:Number = railMetrics.x + bpWidth * mismatchSegment.start;
					var mismatchEndPosition:Number = railMetrics.x + bpWidth * mismatchSegment.end;
					
					if(mismatchSegment.start == mismatchSegment.end) {
						g.lineStyle(2, MISMATCH_COLOR);
						
						g.drawCircle(mismatchStartPosition, yPosition, 1);
					} else {
						g.moveTo(mismatchStartPosition, yPosition);
						g.lineTo(mismatchEndPosition, yPosition);
					}
				}
			}
			
			// render deletions
			if(deletions != null && deletions.length > 0) {
				g.lineStyle(4, MISMATCH_COLOR);
				for(var i3:int = 0; i3 < deletions.length; i3++) {
					var deletionSegment:Segment = deletions[i3] as Segment;
					
					var deletionStartPosition:Number = railMetrics.x + bpWidth * deletionSegment.start;
					var deletionEndPosition:Number = railMetrics.x + bpWidth * deletionSegment.end;
					
					if(deletionSegment.start == deletionSegment.end) {
						g.lineStyle(2, MISMATCH_COLOR);
						
						g.drawCircle(deletionStartPosition, yPosition, 1);
					} else {
						g.moveTo(deletionStartPosition, yPosition);
						g.lineTo(deletionEndPosition, yPosition);
					}
				}
			}
			
			// render insertions
			if(insertions != null && insertions.length > 0) {
				g.lineStyle(4, MISMATCH_COLOR);
				for(var i4:int = 0; i4 < insertions.length; i4++) {
					var insertionSegment:Segment = insertions[i4] as Segment;
					
					var insertionStartPosition:Number = railMetrics.x + bpWidth * insertionSegment.start;
					var insertionEndPosition:Number = railMetrics.x + bpWidth * insertionSegment.end;
					
					if(insertionSegment.start == insertionSegment.end) {
						g.lineStyle(2, MISMATCH_COLOR);
						
						g.drawCircle(insertionStartPosition, yPosition, 1);
					} else {
						g.moveTo(insertionStartPosition, yPosition);
						g.lineTo(insertionEndPosition, yPosition);
					}
				}
			}
		}
		
		protected override function createToolTipLabel():void
		{
			tooltipLabel = traceAnnotation.traceSequence.filename + ", " + (traceAnnotation.start + 1) + ".." + (traceAnnotation.end + 1);
    	}
	}
}
