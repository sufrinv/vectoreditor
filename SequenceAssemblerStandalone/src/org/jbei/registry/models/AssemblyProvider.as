package org.jbei.registry.models
{
    import flash.events.EventDispatcher;

    /**
     * @author Zinovii Dmytriv
     */
    public class AssemblyProvider extends EventDispatcher
    {
        private var _bins:Vector.<Bin>;
        
        private var _manualUpdateStarted:Boolean = false;
        
        // Constructor
        public function AssemblyProvider()
        {
            _bins = new Vector.<Bin>();
        }
        
        // Properties
        public final function get bins():Vector.<Bin>
        {
            return _bins;
        }
        
        public function get manualUpdateStarted():Boolean
        {
            return _manualUpdateStarted;
        }
        
        // Public Methods
        public function manualUpdateStart():void
        {
            if(!_manualUpdateStarted) {
                _manualUpdateStarted = true;
                
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGING, AssemblyProviderEvent.KIND_MANUAL_UPDATE));
            }
        }
        
        public function manualUpdateEnd():void
        {
            if(_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGED, AssemblyProviderEvent.KIND_MANUAL_UPDATE));
                
                _manualUpdateStarted = false;
            }
        }
        
        public function addBin(bin:Bin, quiet:Boolean = false):void
        {
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGING, AssemblyProviderEvent.KIND_BIN_ADD));
            }
            
            _bins.push(bin);
            
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGED, AssemblyProviderEvent.KIND_BIN_ADD));
            }
        }
        
        public function insertBin(bin:Bin, position:int, quiet:Boolean = false):void
        {
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGING, AssemblyProviderEvent.KIND_BIN_ADD));
            }
            
            _bins.splice(position, 0, bin);
            
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGED, AssemblyProviderEvent.KIND_BIN_ADD));
            }
        }
        
        public function removeBin(bin:Bin, quiet:Boolean = false):void
        {
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGING, AssemblyProviderEvent.KIND_BIN_REMOVE));
            }
            
            var index:int = _bins.indexOf(bin);
            
            if(index >= 0) {
                _bins.splice(index, 1);
            }
            
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGED, AssemblyProviderEvent.KIND_BIN_REMOVE));
            }
        }
        
        public function moveBin(bin:Bin, newPosition:int, quiet:Boolean = false):void
        {
            if(bin == null) {
                return;
            }
            
            var currentBinPosition:int = _bins.indexOf(bin);
            
            if(currentBinPosition == -1) {
                return;
            }
            
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGING, AssemblyProviderEvent.KIND_BIN_MOVED));
            }
            
            _bins.splice(currentBinPosition, 1);
            _bins.splice(newPosition, 0, bin);
            
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGED, AssemblyProviderEvent.KIND_BIN_MOVED));
            }
        }
        
        public function changeBinType(bin:Bin, newFeatureType:FeatureType, quiet:Boolean = false):void
        {
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGING, AssemblyProviderEvent.KIND_BIN_CHANGE_TYPE));
            }
            
            bin.featureType = newFeatureType;
            
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGED, AssemblyProviderEvent.KIND_BIN_CHANGE_TYPE));
            }
        }
        
        public function deleteAssemblyItem(bin:Bin, assemblyItem:AssemblyItem, quiet:Boolean = false):void
        {
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGING, AssemblyProviderEvent.KIND_BIN_CHANGE_TYPE));
            }
            
            bin.deleteItem(assemblyItem);
            
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGED, AssemblyProviderEvent.KIND_BIN_CHANGE_TYPE));
            }
        }
        
        public function updateAssemblyItem(assemblyItem:AssemblyItem, sequence:String, quiet:Boolean = false):void
        {
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGING, AssemblyProviderEvent.KIND_ITEM_UPDATE));
            }
            
            assemblyItem.sequence = sequence;
            
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGED, AssemblyProviderEvent.KIND_ITEM_UPDATE));
            }
        }
        
        public function addAssemblyItem(bin:Bin, assemblyItem:AssemblyItem, quiet:Boolean = false):void
        {
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGING, AssemblyProviderEvent.KIND_ITEM_UPDATE));
            }
            
            bin.items.push(assemblyItem);
            
            if(!quiet && !_manualUpdateStarted) {
                dispatchEvent(new AssemblyProviderEvent(AssemblyProviderEvent.ASSEMBLY_PROVIDER_CHANGED, AssemblyProviderEvent.KIND_ITEM_UPDATE));
            }
        }
    }
}