public with sharing class PrimeiraIntegracao {
    public static void BuscaCep(String cep) {
        Integracao__mdt intMdt = [SELECT Endpoint__c FROM Integracao__mdt WHERE DeveloperName = 'BrasilAPI'];
        
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(intMdt.Endpoint__c + cep);
        req.setHeader('Content-Type', 'application/json');
        
        Http http = new Http();
        HttpResponse response = http.send(req);

        System.debug(response.getStatusCode() + ' ' + response.getStatus() + ' ' + response.getBody());   
        CepObject cepObj = (CepObject) System.JSON.deserialize(response.getBody(), CepObject.class);

        Boolean exito;
        if(response.getStatusCode() == 200) {
            System.debug(cepObj);
            System.debug(cepObj.state);
            System.debug(cepObj.city);
            exito = true;
        }
        else {
            exito = false;
        }
       Log_de_Integracao__c logInt = LogIntegracaoUtils.createLog(exito, 'Busca CEP', response.getStatusCode() + ' ' + response.getStatus(), response.getBody(), '');
       insert logInt;

    }
    public class CepObject{
        public String cep;	//86047618
        public String state;	//PR
        public String city;	//Londrina
        public String neighborhood;	//Terra Bonita
        public String street;	//Rua Santino Bicudo de Almeida Loteamento Terra Bonita
        public String service;	//open-cep       
    }
    
}