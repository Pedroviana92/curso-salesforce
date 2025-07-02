public with sharing class ExercicioQueuable1 implements Queueable{
    public void execute(QueueableContext context) {
        List<Novo_Objeto_Async__c> novoObjetoList = new List<Novo_Objeto_Async__c>();
        novoObjetoList = [SELECT Id, Horario_Queueable__c, Horario_Queueable_2__c FROM Novo_Objeto_Async__c];

        for(Novo_Objeto_Async__c obj: novoObjetoList) {
            obj.Horario_Queueable__c = System.now();
        }
        NovoObjetoHelper.disableTrigger();
        update novoObjetoList;
    }
}