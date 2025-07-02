trigger CustomerTrigger on Customer (after insert, after update) {
    if(CustomerHelper.isTriggerEnabled() == true) {
        CustomerHelper.callIntegration(Trigger.new);
    }
}