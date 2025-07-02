global with sharing class FirstBatch implements Database.Batchable<sObject>{

    public String tt;
    public FirstBatch(String ll) {
        System.debug(ll);
        tt = ll;
        System.debug(tt);
    }

    global Database.queryLocator start(Database.BatchableContext batchableContext) { 
        System.debug('Start ' + tt);     
        return Database.getQueryLocator([SELECT Id,Execu_o_do_Batch__c, CreatedDate, Texto_Teste__c, Lista_Teste__c, Checkbox__c, Aula__r.Conteudo__c, ExternalID__c FROM Objeto_para_Testes__c]);
    }

    global void execute(Database.BatchableContext batchableContext, List<Objeto_para_Testes__c> objecttestesList) {  
        System.debug(objecttestesList.size());
        System.debug('execute ' + tt);
        for(Objeto_para_Testes__c obj: objecttestesList) {
            obj.Execu_o_do_Batch__c = System.now();
        }
        update objecttestesList;
    }    
    
    global void finish(Database.BatchableContext param1) {}  
}