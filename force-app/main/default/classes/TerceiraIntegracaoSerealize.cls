public with sharing class TerceiraIntegracaoSerealize {
    public static String serealize(Set<Id> setId) {
        List<Customer> custList = [SELECT Id, Type__c, Email__c, Telefone__c, CPF__c, Name FROM Customer WHERE Id IN :setId];


        List<jsonBody> jbList = new List<jsonBody>();

        for(Customer cust : custList) {
            jsonBody jb = new jsonBody();           
            jb.newsletter = cust.Type__c == 'PF' ? true : false;
            jb.document = cust.CPF__c;
            jb.email = cust.Email__c;
            jb.phone = cust.Telefone__c;
            jbList.add(jb);
            System.debug(jb);
        }
        System.debug(jbList);
        String json = System.JSON.serialize(jbList);
        return json;
    }
    public class jsonBody{
        public boolean newsletter;
        public String document;	//09642049910
        public String email;	//jlucasnevessouza@gmail.com
        public String phone;	//43988566725
    }
}