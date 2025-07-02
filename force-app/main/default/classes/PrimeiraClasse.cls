public class PrimeiraClasse {
    @AuraEnabled
    public static Id primeiroMetodo(Customer cust) {
        insert cust;
        return cust.Id;
    }
    @AuraEnabled
    public static List<Customer> segundoMetodo() {
       return [SELECT Id, Data_de_Nascimento__c, Email__c, Telefone__c, CPF__c, Name FROM Customer]; //SOQL * SQL
    }

    @AuraEnabled
    public static List<Product2> terceiroMetodo() {
       return [SELECT Id, ImagemURL__c, Name, (SELECT Id, UnitPrice FROM PricebookEntries) FROM Product2 WHERE ProductCode LIKE '0%'];
    }
}