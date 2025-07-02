public with sharing class SecondClass {
    public static void BrenoCaiu(String var1, Decimal var2) {
        Decimal result = var2 + Decimal.ValueOf(var1.left(2));
        
        List<Venda__c> Venda1List = new List<Venda__c>();
        Venda1List = [SELECT Id,Cliente__c, Cliente__r.CPF__c, Cliente__r.Name, Cliente__r.Email__c, OwnerId, Owner.name, Name,Forma_de_Pagamento__c, 
            Desconto__c, Comiss_o__c, Status__c, ValorTotal__c, (SELECT ID, Name FROM Produtos_da_Venda__r) FROM Venda__c];

            System.debug(Venda1List);
            System.debug(Venda1List.size());

        for(Venda__c cadaItem : Venda1List) {
            cadaItem.Desconto__c = Decimal.ValueOf(cadaItem.Name)*2;
        }
        update Venda1List;
           
    }

    public static void LuFarias() {
        List<Objeto_para_Testes__c> obj1List = new LIst<Objeto_para_Testes__c>();
        obj1List = [SELECT Id, Texto_Teste__c, Aula__r.Conteudo__c, Lista_Teste__c, Checkbox__c, Aula__c, ExternalID__c FROM Objeto_para_Testes__c];
        for(Objeto_para_Testes__c obj1 : obj1List) {
            obj1.Texto_Teste__c =obj1.Aula__r.Conteudo__c; 
            if(obj1.Lista_Teste__c != '2') {
                obj1.Id = null;
                obj1.ExternalID__c = String.valueof(Integer.valueof((Math.random() * 10000)));
            }
        }
        Database.upsert(obj1List, Objeto_para_Testes__c.ExternalID__c, true);   
    }
}
