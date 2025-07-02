@isTest
public with sharing class ExercicioBatchTest {
    @TestSetup
    public static void makeData(){
        Novo_Objeto_Async__c nob = new Novo_Objeto_Async__c(
            Name = 'Teste',
            Campo_para_Atualizar__c = true,
            Horario_Batch__c = System.now()
        );
        insert nob;

        Novo_Objeto_Async__c nob2 = new Novo_Objeto_Async__c(
            Name = 'Teste',
            Campo_para_Atualizar__c = false,
            Horario_Batch__c = System.now()
        );
        insert nob2;
    }
    @isTest
    public static void testIntegration() {
        Test.startTest();   
            System.schedule(('Update CustomerGroups'), '0 0 4 * * ?', new ExercicioBatch());
            //Database.executeBatch(new ExercicioBatch(), 200);
        Test.stopTest();
       
    }
    @isTest
    public static void testIntegration2() {
        Test.startTest();   
            NovoObjetoHelper.disableTrigger();
            NovoObjetoHelper.enabledTrigger();
        Test.stopTest();        
    }
}