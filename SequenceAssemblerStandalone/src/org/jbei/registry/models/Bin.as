package org.jbei.registry.models
{
    import mx.utils.UIDUtil;

    /**
     * @author Zinovii Dmytriv
     */
    public class Bin
    {
        private var _featureType:FeatureType;
        private var _uuid:String;
        private var _items:Vector.<AssemblyItem> = new Vector.<AssemblyItem>();
        
        // Constructor
        public function Bin(featureType:FeatureType = null)
        {
            _featureType = featureType;
            _uuid = UIDUtil.createUID();
        }
        
        // Properties
        public function get featureType():FeatureType
        {
            return _featureType;
        }
        
        public function set featureType(value:FeatureType):void
        {
            _featureType = value;
        }
        
        public function get uuid():String
        {
            return _uuid;
        }
        
        public function get items():Vector.<AssemblyItem>
        {
            return _items;
        }
        
        public function set items(value:Vector.<AssemblyItem>):void
        {
            _items = value;
        }
        
        // Public Methods
        public function addItem(item:AssemblyItem):void
        {
            _items.push(item);
        }
    }
}