public with sharing class CustomerHelper {
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
    public static void callIntegration(List<Customer> custList) {
       Set<Id> setId = new Set<Id>();
       for(Customer cust : custList) {
            setId.add(cust.Id);
       }
       System.debug(setId);
       SegundaIntegracao.TerceiraIntegracao(setId);
    }    
}