package org.jbei.registry
{
    import org.jbei.lib.utils.Logger;
    import org.jbei.registry.mediators.ApplicationMediator;
    import org.jbei.registry.mediators.AssemblyPanelMediator;
    import org.jbei.registry.mediators.AssemblyStatusBarMediator;
    import org.jbei.registry.mediators.ResultsPanelMediator;
    import org.jbei.registry.models.AssemblyProvider;
    import org.jbei.registry.models.PermutationSet;
    import org.jbei.registry.utils.StandaloneUtils;
    import org.jbei.registry.view.ui.MainPanel;
    import org.jbei.registry.view.ui.assembly.AssemblyStatusBar;
    import org.puremvc.as3.patterns.facade.Facade;
    import org.puremvc.as3.patterns.mediator.Mediator;
    
    /**
     * @author Zinovii Dmytriv
     */
    public class ApplicationFacade extends Facade
    {
        private var initialized:Boolean = false;
        
        private var _assemblyProvider:AssemblyProvider;
        private var _resultPermutations:PermutationSet;
        
        // Constructor
        public function ApplicationFacade()
        {
            super();
            
            _assemblyProvider = StandaloneUtils.standaloneAssemblyProvider();
        }
        
        // Properties
        public function get assemblyProvider():AssemblyProvider
        {
            return _assemblyProvider;
        }
        
        public function set assemblyProvider(value:AssemblyProvider):void
        {
            _assemblyProvider = value;
        }
        
        public function get resultPermutations():PermutationSet
        {
            return _resultPermutations;
        }
        
        public function set resultPermutations(value:PermutationSet):void
        {
            _resultPermutations = value;
        }
        
        // System Methods
        public static function getInstance():ApplicationFacade
        {
            if(instance == null) {
                instance = new ApplicationFacade();
            }
            
            return instance as ApplicationFacade;
        }
        
        // Public Methods
        public function initialize(mainPanel:MainPanel):void
        {
            registerMediator(new ApplicationMediator(mainPanel));
            registerMediator(new ResultsPanelMediator(mainPanel.resultsPanel));
            registerMediator(new AssemblyPanelMediator(mainPanel.assemblyPanel));
            
            initialized = true;
            
            Logger.getInstance().info("Application initialized");
            
            sendNotification(Notifications.SWITCH_TO_ASSEMBLY_VIEW);
        }
    }
}