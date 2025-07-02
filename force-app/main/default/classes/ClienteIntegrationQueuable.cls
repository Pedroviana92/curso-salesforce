public with sharing class ClienteIntegrationQueuable implements Queueable, Database.AllowsCallouts{
    Set<Id> setId2 = new Set<Id> ();
    public ClienteIntegrationQueuable(Set<Id> setId) {
        setId2 = setId;
    }
    public void execute(QueueableContext context) {
        List<Cliente__c> clieList = [SELECT Id, Rua__c,Bairro__c, Numero__c, Cidade__c, CEP__c FROM Cliente__c WHERE Id IN :setId2];
        Integracao__mdt intMdt = [SELECT Endpoint__c FROM Integracao__mdt WHERE DeveloperName = 'BrasilAPI2'];

        for(Cliente__c clie : clieList) {
            HttpRequest req = new HttpRequest();
            req.setMethod('GET');
            req.setEndpoint(intMdt.Endpoint__c + clie.CEP__c);
            req.setHeader('Content-Type', 'application/json');

            Http http = new Http();
            HttpResponse response = http.send(req);

            System.debug(response.getStatusCode() + ' ' + response.getStatus() + ' ' + response.getBody());  
            CepObject cepObj = (CepObject) System.JSON.deserialize(response.getBody(), CepObject.class);
            System.debug(cepObj);

            clie.Rua__c = cepObj.street;
            clie.Bairro__c = cepObj.neighborhood;
            clie.Cidade__c =  cepObj.city + ' / ' + cepObj.state;

            System.debug(cepObj.location);
            System.debug(cepObj.location.type);
            System.debug(cepObj.location.coordinates.longitude);
            System.debug(cepObj.location.coordinates.latitude);
            System.debug(cepObj.location.coordinates);
        }

        ClienteHelper.disableTrigger();
        update clieList;
    }

    public class CepObject {

        public String cep;
        public String state;
        public String city;
        public String neighborhood;
        public String street;
        public String service;
        public Location location;   
    }

    public class Coordinates {
        public String longitude;
        public String latitude;
    }

    public class Location {
        public String type;
        public Coordinates coordinates;
    }
}