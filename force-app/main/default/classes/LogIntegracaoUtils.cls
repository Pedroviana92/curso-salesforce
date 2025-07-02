public with sharing class LogIntegracaoUtils {
    public static Log_de_Integracao__c createLog(Boolean exito, String integration, String status, String payloadIn, String payloadOut) {
        return new Log_de_Integracao__c(
            Name = integration,
            Status__c = status,
            PayloadOut__c = payloadOut,
            PayloadIN__c = payloadIn,
            Exito__c = exito
        );
    }
}