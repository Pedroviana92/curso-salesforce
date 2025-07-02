public with sharing class ObjetoTestesHelper {
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

    public static void beforeInsert(List<Objeto_para_Testes__c> objTestesList) {
        Map<Id, Aula__c> mapAula = new Map<Id, Aula__c>();
        for(Objeto_para_Testes__c vnd :objTestesList) {
            mapAula.put(vnd.Aula__c, null);
        }

        List<Aula__c> aulaList = [SELECT Id, Data__c FROM Aula__c WHERE Id IN :mapAula.keySet()];

        for(Aula__c aula :aulaList) {
            mapAula.put(aula.Id, aula);
        }

        for(Objeto_para_Testes__c vnd :objTestesList) {
            Aula__c aula = mapAula.get(vnd.Aula__c);
           if(System.today() > aula.Data__c) {
                vnd.Checkbox__c = true;
           }
        }

    }
    public static void beforeUpdate(List<Objeto_para_Testes__c> objTestesList) {
     
    }
}