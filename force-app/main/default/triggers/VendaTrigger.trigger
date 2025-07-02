trigger VendaTrigger on Venda__c (before insert, after insert, before update, after update, before delete) {
    if(VendaHelper.isTriggerEnabled() == true) {
        if(Trigger.isBefore) {
            if(Trigger.isInsert) {
                VendaHelper.beforeInsert(Trigger.new);
            }
            if(Trigger.isUpdate) {
                VendaHelper.beforeUpdate(Trigger.new, Trigger.oldMap);
            }
            if(Trigger.isDelete) {
                VendaHelper.beforeDelete(Trigger.old);
            }
        }
        if(Trigger.isAfter) {
            if(Trigger.isInsert) {
                VendaHelper.afterInsert(Trigger.new);
            }
            if(Trigger.isUpdate) {
                VendaHelper.afterUpdate(Trigger.new, Trigger.old);
            }
        }
    }    
}