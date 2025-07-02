public with sharing class segundoQueuable implements Queueable {

    List<FIlho_de_Testes__c> listaFilho2 = new List<FIlho_de_Testes__c>();
    public segundoQueuable( List<FIlho_de_Testes__c> listaFilho) {
        listaFilho2 = listaFilho;
    }

    public void execute(QueueableContext context) {
        System.debug(System.now());
        System.debug(listaFilho2);
        for(FIlho_de_Testes__c filho : listaFilho2) {
            filho.Execucao_do_Queuable__c = System.now();
        }
        update listaFilho2;
    }
}