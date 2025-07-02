trigger NovoObjetoTrigger on Novo_Objeto_Async__c (before insert, before update, after update) {
    if(NovoObjetoHelper.isTriggerEnabled() == true) {
        if(Trigger.isBefore) {
            if(Trigger.isInsert) {
                NovoObjetoHelper.beforeInsert(Trigger.new);
            }
            if(Trigger.isUpdate) {
                NovoObjetoHelper.beforeUpdate(Trigger.new);
            }
        }
        if(Trigger.isAfter) {       
            if(Trigger.isUpdate) {
                NovoObjetoHelper.afterUpdate(Trigger.new, Trigger.oldMap);
            }
        }
    }
}