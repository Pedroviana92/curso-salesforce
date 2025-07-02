@RestResource(urlMapping='/primeirowebhook')
global with sharing class PrimeiroWebhook {
    @HttpPost 
    global static void doPost() {
        RestRequest req = RestContext.request;
        String json=req.requestBody.toString();    
        Aula aula = (Aula) System.JSON.deserialize(json, Aula.class);
        System.debug(aula);
    }
    @HttpGet 
    global static void doGet() {
        RestRequest req = RestContext.request;
        RestResponse resp = RestContext.response;
        String cpf = req.params.get('Cpf');
        String url = req.requestURI;
        System.debug(url);
        System.debug(cpf);

        Customer cust = [SELECT Id, Type__c, Telefone__c, Email__c, CPF__c, Name FROM Customer WHERE CPF__c = :cpf];
        System.debug(cust);

        if(!Test.isRunningTest()) {
            resp.responseBody = Blob.valueOf(System.JSON.serialize(cust));
        }
    }
    public class Aula {
        public String Data;	//2024-07-20
        public List<Alunos> Alunos;
    }
    public class Alunos {
        public String Nome;	//Pedro
        public String IdAluno;	//12345678
    }
    public class cliente {
        public String cpf;
        public String email;
    }
}