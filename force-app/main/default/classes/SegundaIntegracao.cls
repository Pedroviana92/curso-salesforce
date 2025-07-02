public with sharing class SegundaIntegracao {
   @future(callout=true)
    public static void TerceiraIntegracao(Set<Id> setId) {
        Integracao__mdt intMdt = [SELECT Endpoint__c FROM Integracao__mdt WHERE DeveloperName = 'LavoroInt'];

        String body = TerceiraIntegracaoSerealize.serealize(setId);
        System.debug(body);
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(intMdt.Endpoint__c);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Bearer ' + Autenticacao());
        req.setBody(body);
        
        Http http = new Http();
        HttpResponse response = http.send(req);

        System.debug(response.getStatusCode() + ' ' + response.getStatus() + ' ' + response.getBody());  
        Dese2 resp = (Dese2) System.JSON.deserialize(response.getBody(), Dese2.class); 
        System.debug(resp); 
        String ExternalId = resp.ExternalId;

        List<Customer> custList = [SELECT Id,ExternalID__c, Type__c, Email__c, Telefone__c, CPF__c, Name FROM Customer WHERE Id IN :setId];
        for(Customer cust : custList) {
            cust.ExternalID__c = ExternalId;
        }
        CustomerHelper.disableTrigger();
        update custList;
    }   


    public static void SegundaIntegracao() {
        Integracao__mdt intMdt = [SELECT Endpoint__c FROM Integracao__mdt WHERE DeveloperName = 'LavoroInt'];

        String body = SegundaIntegracaoSerealize.serealize();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(intMdt.Endpoint__c);
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Bearer ' + Autenticacao());
        req.setBody(body);
        
        Http http = new Http();
        HttpResponse response = http.send(req);

        System.debug(response.getStatusCode() + ' ' + response.getStatus() + ' ' + response.getBody());   
    }   


    public static String Autenticacao() {
        Integracao__mdt intMdt = [SELECT Endpoint__c, username__c, password__c, clientId__c, clientsecrete__c FROM Integracao__mdt WHERE DeveloperName = 'Lavoro'];

        String body = SegundaIntegracaoSerealize.serealize();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(intMdt.Endpoint__c);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody(
            'grant_type=password' + 
            '&client_id='+intMdt.clientId__c + 
            '&client_secret='+intMdt.clientsecrete__c + 
            '&username=' +intMdt.username__c + 
            '&password=' + intMdt.password__c
        );

        Http http = new Http();
        HttpResponse response = http.send(req);

        System.debug(response.getStatusCode() + ' ' + response.getStatus() + ' ' + response.getBody());   
        Dese tokenObj = (Dese) System.JSON.deserialize(response.getBody(), Dese.class);
        return tokenObj.access_token;

    }   
    public class Dese{
        public String access_token;
    }
    public class Dese2{
        public String ExternalId;
    }
}