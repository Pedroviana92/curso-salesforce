import { LightningElement } from 'lwc';
import buscarProdutos from '@salesforce/apex/PrimeiraClasse.terceiroMetodo';

export default class TelaProduto extends LightningElement {
    listaProdutos = [];
    connectedCallback() {  
        buscarProdutos()
        .then((result)=>{
            var listP = []; 
            console.log(result);

            result.forEach(element => {     
                element.PricebookEntries.forEach(e => {     
                    var ll = {'Nome' : element.Name, 'Img' : element.ImagemURL__c, 'Valor' : e.UnitPrice};           
                    listP.push(ll);
                });
                
            });
            
            console.log(listP);
            this.listaProdutos = listP;
        }) 
    }
}