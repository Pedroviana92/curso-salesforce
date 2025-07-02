@isTest
public with sharing class FirstBatchTest {
    @isTest
    public static void testIntegration() {
        Test.startTest();   
        Aula__c aula = new Aula__c(
            Data__c = System.today()
        );
        insert aula;

        Objeto_para_Testes__c nob = new Objeto_para_Testes__c(
            Name = 'Teste',
            Aula__c = aula.Id,
            Texto_Teste__c = 'Mais de 5',   
            Execu_o_do_Batch__c =  System.now()
        );
        insert nob;

            System.schedule(('Update CustomerGroups'), '0 0 4 * * ?', new secondBatch());
            Database.executeBatch(new FirstBatch(nob.Name), 200);
        Test.stopTest();
       
    }
}