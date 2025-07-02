public with sharing class NovoObjetoHelper {
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

    public static void beforeInsert(List<Novo_Objeto_Async__c> objList) {
        for(Novo_Objeto_Async__c obj :objList) {
            if(obj.Campo_para_Atualizar__c == true) {
                obj.Horario_Trigger_1__c = System.now();
            }
        }

    }
    public static void beforeUpdate(List<Novo_Objeto_Async__c> objList) {
        for(Novo_Objeto_Async__c obj :objList) {
            if(obj.Campo_para_Atualizar__c == false) {
                obj.Horario_Trigger_2__c = System.now().addHours(Integer.valueof((Math.random() * 10)));
            }
        }
       
    }
    public static void afterUpdate(List<Novo_Objeto_Async__c> objList, Map<Id, Novo_Objeto_Async__c> mapObj) {
        System.debug(objList);
        for(Novo_Objeto_Async__c objNew :objList) {
            System.debug(objNew);
            Novo_Objeto_Async__c objOld = mapObj.get(objNew.Id);            
            System.debug(objOld);
            if(objNew.Campo_para_Atualizar__c != objOld.Campo_para_Atualizar__c) {
                System.debug(objNew.Horario_Trigger_3__c);
                objNew.Horario_Trigger_3__c = System.now(); 
                System.debug(objNew.Horario_Trigger_3__c);
            }
        }
        
    }
}