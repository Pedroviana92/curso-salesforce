trigger ClienteTrigger on Cliente__c (after insert) {
    if(ClienteHelper.isTriggerEnabled() == true) {
        ClienteHelper.callIntegration(Trigger.new);
    }
}