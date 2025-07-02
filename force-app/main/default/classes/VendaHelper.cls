public with sharing class VendaHelper {

    public static Boolean isTriggerEnabled = true;

    public static Boolean isTriggerEnabled() {
        return isTriggerEnabled;
    }
    public static Boolean disableTrigger(){
        return isTriggerEnabled = false;
    }
    public static Boolean enabledTrigger(){
        return isTriggerEnabled = true;
    }

    public static void beforeInsert(List<Venda__c> vendaList) {
        for(Venda__c vnd :vendaList) {
            vnd.Desconto__c = 10;
        }
    }
    public static void afterInsert(List<Venda__c> vendaList) {
        List<Produto_da_Venda__c> prodVendList = new List<Produto_da_Venda__c>();
        Product2 prod = [SELECT Id FROM Product2 WHERE Name = 'Cabo HDMI'];

        for(Venda__c vnd :vendaList) {
            Produto_da_Venda__c prodVend = new Produto_da_Venda__c();
            prodVend.Name = 'P2';
            prodVend.Quantidade__c = 3;
            prodVend.Produto__c = prod.Id;
            prodVend.Venda__c = vnd.Id;

            prodVendList.add(prodVend);
        }
        insert prodVendList;
    }
              //Map<Id, Venda__c> mapVenda = new Map<Id, Venda__c>();
    public static void beforeUpdate(List<Venda__c> vendaListNew, Map<Id, Venda__c> mapVenda) {
        for(Venda__c vndNew :vendaListNew) {
            Venda__c vndOld = mapVenda.get(vndNew.Id);
            
            System.debug(vndNew.Name + ' ' + vndOld.Name);                
            System.debug('Entrou no IF');
            if(vndNew.ValorTotal__c != vndOld.ValorTotal__c) {
                vndNew.Comiss_o__c = vndNew.Comiss_o__c + 1;
            }
        }
    }
    public static void afterUpdate(List<Venda__c> vendaList, List<Venda__c> vendaListOld) {
        //Integração
        for(Venda__c vnd :vendaList) {
            vnd.Parcelas__c = '2 X';
        }
        disableTrigger();
        update vendaList;
    }
    public static void beforeDelete(List<Venda__c> vendaList) {

        Set<Id> setCliente = new Set<Id>();
        for(Venda__c vnd :vendaList) {
            setCliente.add(vnd.Cliente__c);
        }
        System.debug(setCliente);
        List<Customer> custList = [SELECT Id, Contato_Principal__c FROM Customer WHERE Id IN :setCliente];
        for(Customer cus :custList) {
            cus.Contato_Principal__c = 'Teste';
        }
        update custList;
    }
}