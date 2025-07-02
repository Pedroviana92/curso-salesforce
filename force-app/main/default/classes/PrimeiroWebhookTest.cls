@isTest
public with sharing class PrimeiroWebhookTest {
    @TestSetup
    public static void makeData(){
        Customer cust = new Customer(
            Name = 'Cliente 1',
            CPF__c = '04562514472',
            Telefone__c = '4398856725',
            Email__c = 'joao.neves@globant.com',
            Type__c = 'PF', 
            ExternalID__c=''
        );
        CustomerHelper.disableTrigger();
        insert cust;
    }
    @isTest
    public static void testIntegration(){
        Test.setMock(HttpCalloutMock.class, new SegundaIntMOck());
        Test.startTest();
           RestRequest req = new RestRequest();
           req.requestURI = 'https://cursojl-dev-ed.develop.lightning.force.com/services/apexrest/primeirowebhook';
           req.httpMethod = 'POST';
           req.requestBody=Blob.valueOf('{"Aula" : { "Data" : "2024-07-20", "Alunos" : [{ "Nome" : "Pedro", "IdAluno" : "12345678"      }        ]    }}');
           RestContext.request = req;
           PrimeiroWebhook.doPost();

        Test.stopTest();
    }

    @isTest
    public static void testIntegrationGet(){
        Test.setMock(HttpCalloutMock.class, new SegundaIntMOck());
        Test.startTest();

           RestRequest req = new RestRequest();
           req.requestURI = '/services/apexrest/primeirowebhook';
           req.httpMethod = 'GET';
           req.AddParameter('Cpf', '04562514472');
           RestContext.request = req;
           PrimeiroWebhook.doGet();

        Test.stopTest();
    }
}