public with sharing class ClienteHelper {
    public static Boolean isTriggerEnabled = true;

    public static Boolean isTriggerEnabled() {
        return isTriggerEnabled;
    }
    public static Boolean disableTrigger(){
        return isTriggerEnabled = false;
    }
    public static Boolean enabledTrigger(){
        return isTriggerEnabled = true;
    }
    public static void callIntegration(List<Cliente__c> clieList) {
       Set<Id> setId = new Set<Id>();
       for(Cliente__c cust : clieList) {
            setId.add(cust.Id);
       }
       System.debug(setId);

       System.enqueueJob(new ClienteIntegrationQueuable(setId));
    }    
}