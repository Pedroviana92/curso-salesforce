public with sharing class SegundaIntegracaoSerealize {
    public static String serealize() {
        jsonBody jb = new jsonBody();
        jb.newsletter = false;
        jb.document = '09642049910';
        jb.email = 'jlucasnevessouza@gmail.com';
        jb.phone = '43988566725';
        String json = System.JSON.serialize(jb);
        return json;
    }
    public class jsonBody{
        public boolean newsletter;
        public String document;	//09642049910
        public String email;	//jlucasnevessouza@gmail.com
        public String phone;	//43988566725
    }
}