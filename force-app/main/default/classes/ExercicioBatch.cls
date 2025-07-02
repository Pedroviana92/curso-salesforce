global with sharing class ExercicioBatch implements Database.Batchable<sObject>, Schedulable {
    global void execute(SchedulableContext context) {
        Database.executeBatch(this, 200);
    } 

    global Database.queryLocator start(Database.BatchableContext batchableContext) { 
        return Database.getQueryLocator([SELECT Id, Horario_Batch__c FROM Novo_Objeto_Async__c]);
    }

    global void execute(Database.BatchableContext batchableContext, List<Novo_Objeto_Async__c> novoObjetoList) {  
        System.debug(novoObjetoList.size());
        for(Novo_Objeto_Async__c obj: novoObjetoList) {
            obj.Horario_Batch__c = System.now();
        }
        update novoObjetoList;
    }    
    
    global void finish(Database.BatchableContext param1) {}  
}