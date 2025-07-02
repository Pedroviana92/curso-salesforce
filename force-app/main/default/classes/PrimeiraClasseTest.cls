@isTest
public with sharing class PrimeiraClasseTest {
    @TestSetup
    public static void makeData(){
        Customer cust = new Customer(
            Name = 'Cliente 1'
        );
        CustomerHelper.disableTrigger();
        insert cust;

        Product2 prod = new Product2(
            Name = 'Prod 1',
            IsActive = true,
            ProductCode = '1234'
        );
        insert prod;
    }
    @isTest
    public static void testIntegration() {        
        Test.startTest();   
            Customer cust2 = new Customer(
                Name = 'Cliente 2'
            );
            CustomerHelper.disableTrigger();
            PrimeiraClasse.primeiroMetodo(cust2);
            CustomerHelper.enabledTrigger();
            PrimeiraClasse.segundoMetodo();
            PrimeiraClasse.terceiroMetodo();
        Test.stopTest();       
    }
}