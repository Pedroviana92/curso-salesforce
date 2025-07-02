public with sharing class primeiroQueuable implements Queueable {

    Set<Id> setId2 = new Set<Id> ();
    public primeiroQueuable(Set<Id> setId) {
        setId2 = setId;
    }

    public void execute(QueueableContext context) {
        System.debug(System.now());
        List<Objeto_para_Testes__c> objTestesList = new List<Objeto_para_Testes__c>();
        objTestesList = [SELECT Id, (SELECT Id FROM Filho_de_Testes__r), Execu_o_do_Batch__c,Execucao_do_Queuable__c, CreatedDate,  Texto_Teste__c, Lista_Teste__c, Checkbox__c, 
        Aula__r.Conteudo__c, ExternalID__c FROM Objeto_para_Testes__c WHERE Id IN :setId2 ORDER BY Lista_Teste__c];

        List<FIlho_de_Testes__c> listaFilho = new List<FIlho_de_Testes__c>();
        for(Objeto_para_Testes__c objTestes : objTestesList) {
            for(FIlho_de_Testes__c filho : objTestes.Filho_de_Testes__r) {
                listaFilho.add(filho);
            }
            objTestes.Execucao_do_Queuable__c = System.now();
        }

        ObjetoTestesHelper.disableTrigger();
        update objTestesList;

        if(!Test.isRunningTest()) {
            System.enqueueJob(new segundoQueuable(listaFilho), 1);
        }
    }
}