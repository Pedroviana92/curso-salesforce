public with sharing class FirstClass {
    public static void LuPedroBreno() {
        Venda__c Venda = new Venda__c();
        Venda.Status__c = 'Iniciada';
        Venda.Parcelas__c = '1 X';
        Venda.RecordTypeId = '012as000000430vAAA';
        Venda.Forma_de_Pagamento__c = 'PIX';
        Venda.Desconto__c = 0;
        Venda.Comiss_o__c = 0;
        Venda.Cliente__c = '0o6as000000006TAAQ';
        insert Venda;
    }
}