import { LightningElement } from 'lwc';
import salvarCliente from '@salesforce/apex/PrimeiraClasse.primeiroMetodo';
import buscarTODOSClientes from '@salesforce/apex/PrimeiraClasse.segundoMetodo';


const options = [
        { label: 'Pessoa Física', value: 'pf' },
        { label: 'Pessoa Jurídica', value: 'pj' },
];
const columns = [
    { label: 'Nome', fieldName: 'Name' },
    { label: 'CPF', fieldName: 'CPF__c'},
    { label: 'Data de Nascimento', fieldName: 'Data_de_Nascimento__c',  type: 'date' },
    { label: 'Telefone', fieldName: 'amount', type: 'Telefone__c'},
    { label: 'Email', fieldName: 'Email__c'},
];
export default class CriarTela extends LightningElement {    
    valueTipoPessoa = 'pf';
    documento = 'CPF';
    isCNPJ = false;
    valueNome;
    valueTel;
    z;
    valueCNPJ;
    valueCPF;
    valueEmail;
    idCliente;
    valueIsActive;
    dataTabela = [];
    valueContato;
    optionsPicklist = options;
    columnsTabela = columns;

   

    MudarTipoPessoa(event) {
        this.valueTipoPessoa = event.detail.value;
        if(this.valueTipoPessoa == 'pf') {
            this.documento = 'CPF';
            this.isCNPJ = false;
        }
        else {
            this.isCNPJ = true;
            this.documento = 'CNPJ';
        }
    }   
    MudarNome(e) {
        this.valueNome = e.target.value;
    }
    MudarEmail(e) {
        this.valueEmail = e.target.value;
    }
    MudarContato(e) {
        this.valueContato = e.target.value;
    }
    MudarTelefone(e) {
        this.valueTel = e.target.value;
    }
    MudarIsActive(e) {
        this.valueIsActive = e.target.value;
    }
    MudarData(e) {
        this.valueData = e.target.value;
    }
    Salvar() {
        var qualquerNome = {
            'CPF__c' :  this.valueCPF,
            'isActive__c' :  this.valueIsActive,
            'Type__c' :  this.valueTipoPessoa,
            'Telefone__c' :  this.valueTel,
            'Email__c' :  this.valueEmail,
            'Contato_Principal__c' :  this.valueContato,
            'CNPJ__c' :  this.valueCNPJ,
            'Data_de_Nascimento__c' :  this.valueData,
            'Name' :  this.valueNome,
        };
        salvarCliente({cust : qualquerNome})
        .then((result)=>{
            console.log('RESULTADO  ' + result);
            this.idCliente=result;
            setTimeout(() => {                
                buscarTODOSClientes() 
                .then((result2)=>{
                   this.dataTabela = result2;
                })
                .catch((error) => {
                    console.log('ERRO ' + error.toString());
                })
            }, 100);

        })
        .catch((error) => {
            console.log('ERRO ' + error.toString());
        })
    }
    MudarDocumento(e) {
        if(this.valueTipoPessoa == 'pf') {
            this.valueCPF = e.target.value;
        }
        else {
            this.valueCNPJ = e.target.value;
        }
    }

}