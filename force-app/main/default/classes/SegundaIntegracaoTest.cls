@isTest
public with sharing class SegundaIntegracaoTest {
    @isTest
    public static void SegundaIntegracaoTest() {
        Test.setMock(HttpCalloutMock.class, new SegundaIntMOck());
        Test.startTest();
            SegundaIntegracao.SegundaIntegracao();
            PrimeiraIntegracao.BuscaCep('86047610');
        Test.stopTest();
    }
    @isTest
    public static void PrimeiraIntegracaoTest() {
        Test.setMock(HttpCalloutMock.class, new PrimeiraIntMockErro());
        Test.startTest();
            PrimeiraIntegracao.BuscaCep('86047610');
        Test.stopTest();
    }
    @isTest
    public static void TerceiraIntegracaoTest() {
        Test.setMock(HttpCalloutMock.class, new TerceiraIntMock());
        Test.startTest();
            Customer cust = new Customer(
                Name = 'Cliente 1',
                CPF__c = '04562514472',
                Telefone__c = '4398856725',
                Email__c = 'joao.neves@globant.com',
                Type__c = 'PF', 
                ExternalID__c=''
            );
            insert cust;
        Test.stopTest();
    }
}