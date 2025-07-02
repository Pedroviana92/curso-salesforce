public with sharing class TirarPedidoController {

    @AuraEnabled
    public static List<Produtos__c> buscarProdutos() {
        List<Produtos__c> prodList = new List<Produtos__c> ();
        prodList = [SELECT Id, Url_Imagem__c, Name, Pre_o__c, Marca__c, Estoque__c FROM Produtos__c WHERE Estoque__c > 0 ORDER BY Name];
        return prodList;
    }

    @AuraEnabled
    public static List<Cliente__c> SearchCustomerName(String nameC) {
        String nname = '%'+nameC+'%';
        List<Cliente__c> clieList = new List<Cliente__c> ();
        clieList = [SELECT Id, Telefone__c, Rua__c, Numero__c, Name, Email__c, Data_de_Nascimento__c, CPF__c, Cidade__c, CEP__c, Bairro__c
        FROM Cliente__c WHERE Name LIKE :nname ORDER BY Name];
        return clieList;
    }

    @AuraEnabled
    public static List<String> SalvarPedido (Decimal totalValue, Decimal desconto, String cliente) {
        Pedido__c pedido = new Pedido__c(
            Valor_Total__c = totalValue,
            Desconto__c = desconto,
            Cliente__c = cliente
        );
        insert pedido;

        Pedido__c pedNew = [SELECT Id, Name FROM Pedido__c WHERE Id = :pedido.Id];
        List<String> retList = new List<String>();
        retList.add(pedido.Id);
        retList.add(pedNew.Name);

        return retList;
    } 

    @AuraEnabled
    public static void SalvarProdPedido (Integer quantidade, String prodId, String pediId) {        

        Produto_do_Pedido__c prodPed = new Produto_do_Pedido__c(
            Quantidade__c = quantidade,
            Produto__c = prodId,
            Pedido__c = pediId
        );
        insert prodPed;
    } 
}