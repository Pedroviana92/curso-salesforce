trigger ObjetoTestesTrigger on Objeto_para_Testes__c (before insert, before update, after update) {
    if(ObjetoTestesHelper.isTriggerEnabled() == true) {
        if(Trigger.isBefore) {
            if(Trigger.isInsert) {
                ObjetoTestesHelper.beforeInsert(Trigger.new);
            }
            if(Trigger.isUpdate) {
                ObjetoTestesHelper.beforeUpdate(Trigger.new);
            }
        }
        if(Trigger.isAfter) {       
            if(Trigger.isUpdate) {
                System.debug(System.now());
                Set<Id> setId = new Set<Id>();
                for(Objeto_para_Testes__c objTes : Trigger.New){      
                    if(objTes.Lista_Teste__c != '4') {
                        setId.add(objTes.Id);  
                    }
                } 
                System.enqueueJob(new primeiroQueuable(setId));
            }
        }
    }
}