import { LightningElement } from 'lwc';
import buscarProdutos from '@salesforce/apex/TirarPedidoController.buscarProdutos';
import SearchCustomerName from '@salesforce/apex/TirarPedidoController.SearchCustomerName';
import SalvarPedido from '@salesforce/apex/TirarPedidoController.SalvarPedido';
import SalvarProdPedido from '@salesforce/apex/TirarPedidoController.SalvarProdPedido';
import { NavigationMixin } from 'lightning/navigation';


export default class TirarPedido extends NavigationMixin(LightningElement) {
    headerObject={};

    stepProd = 'slds-path__item slds-is-current slds-is-active';
    stepClie = 'slds-path__item slds-is-incomplete';
    stepFin = 'slds-path__item slds-is-incomplete';
    nextButton = false;
    backButton = true;
    step = 1;
    stepProdBL = true;
    stepClieBL = false;
    stepFinBL = false;
    customerAtual;
    selectedRecord;
    recordsList=null;
    changeColorSelectedRecord = 'slds-var-p-vertical_xx-small slds-var-p-horizontal_small selected-record slds-list_horizontal slds-media_center slds-grid_align-spread';
    listaProdutos=[];
    listaProdutosCarrinho=[];
    mapProdutos = new Map();
    mapCarrinho = new Map();
    desconto = 0.0;
    FinalValue;
    idPedido;

    connectedCallback() {
		this.construirHeader();  
        this.buscarProdutos();     
	}
    getDescount(event) {
        this.listaProdutosCarrinho =  this.mapCarrinho.values();
        var desc = event.target.value;
        this.desconto = desc;
        this.FinalValue = this.headerObject.totalValue - (this.headerObject.totalValue * (desc/100));
    }
    handleTyping(event) {        
        this.customerAtual = event.target.value;
        this.handleGetRecords();
    }

    handleClearSelected() {
        this.selectedRecord = null;   
    }
    handleSelectRecord(event) {
        const { value } = event.target.dataset;
        const record = this.recordsList.find(item => item.Id === value);
        this.selectedRecord = record;    
        this.changeColorSelectedRecord = 'slds-var-p-vertical_xx-small slds-var-p-horizontal_small selected-record-blocked slds-list_horizontal slds-media_center slds-grid_align-spread';       
        var headerObject = { 
            "Data" : this.headerObject.Data,
            "OrderNumber" : this.headerObject.OrderNumber,
            "ItensLength" : this.headerObject.ItensLength,
            "CustomerName" : record.Name,
            "totalValue" : this.headerObject.totalValue
        }
        this.headerObject = headerObject;
    }
    handleOnFocus(event) {
        this.handleGetRecords();
    }
    
    handleOnFocusOut(event) {
        setTimeout(() => { this.recordsList = [] }, 300);
    }

    handleGetRecords() {
        SearchCustomerName({nameC : this.customerAtual})
        .then((result)=>{              
            this.recordsList = result;
        }) 
    }

    construirHeader() {
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();        
        today = dd + '/' + mm + '/' + yyyy;
        var headerObject = { 
            "Data" : today,
            "OrderNumber" : "-----",
            "ItensLength" : 0,
            "CustomerName" : "-----",
            "totalValue" : 0.00
        }
        this.headerObject = headerObject;
    }

    buscarProdutos() {
        buscarProdutos()
        .then((result)=>{           
            console.log(result);          
            this.listaProdutos = result;

            result.forEach(prod => {
                var prodCarrinho = {
                    "Produto" : prod,
                    "ItensTotal" : 0,
                    "ValorTotal" : 0.00
                }
                this.mapProdutos.set(prod.Id, prodCarrinho);
            });
            console.log(this.mapProdutos);     
        }) 
    }

    nextScreen(){   
        var step = this.step;     
        if(step == 1){      
            this.listaProdutosCarrinho =  this.mapCarrinho.values();
            this.backButton = false;

            this.stepProdBL = false;
            this.stepClieBL = true;

            this.step = 2;

            this.stepProd = 'slds-path__item slds-is-complete';
            this.stepClie = 'slds-path__item slds-is-current slds-is-active'; 
        }
        else if(step == 2){
            this.listaProdutosCarrinho =  this.mapCarrinho.values();
            this.nextButton = true;
            this.step = 3;
            this.FinalValue = this.headerObject.totalValue

            this.stepClie = 'slds-path__item slds-is-complete';
            this.stepFin = 'slds-path__item slds-is-current slds-is-active';

            this.stepClieBL = false;
            this.stepFinBL = true;
        }        
    }

    backScreen(){
        var step = this.step;     
        if(step == 2){
            this.listaProdutosCarrinho =  this.mapCarrinho.values();
            this.backButton = true;
            this.step = 1;

            this.stepProdBL = true;
            this.stepClieBL = false;

            this.stepProd = 'slds-path__item slds-is-current slds-is-active';
            this.stepClie = 'slds-path__item slds-is-incomplete'; 
        }
        else if(step == 3){
            this.listaProdutosCarrinho =  this.mapCarrinho.values();
            this.nextButton = false;
            this.step = 2;

            this.stepClieBL = true;
            this.stepFinBL = false;
           
            this.stepClie = 'slds-path__item slds-is-current slds-is-active';
            this.stepFin = 'slds-path__item slds-is-incomplete'; 
        }       
    }

    addProdutos(event) {
        
        var prod = this.mapProdutos.get(event.target.value);  
        console.log(prod);    
        prod.ValorTotal += prod.Produto.Pre_o__c;
        prod.ItensTotal += 1;

        if(prod.ItensTotal == prod.Produto.Estoque__c) {
            prod.DisabledButton = true;
        }
        console.log(this.mapProdutos);

        this.mapCarrinho.set(prod.Produto.Id, prod);
        
        setTimeout(() => { 
            this.listaProdutosCarrinho =  this.mapCarrinho.values();

            var headerObject = { 
                "Data" : this.headerObject.Data,
                "OrderNumber" : this.headerObject.OrderNumber,
                "ItensLength" : this.headerObject.ItensLength += 1,
                "CustomerName" : this.headerObject.CustomerName,
                "totalValue" : this.headerObject.totalValue += prod.Produto.Pre_o__c
            }
            this.headerObject = headerObject;

        }, 500);
    }
    subProdutos(event) {
        var prod = this.mapProdutos.get(event.target.value);      
        prod.ValorTotal -= prod.Produto.Pre_o__c;
        prod.ItensTotal -= 1;
        console.log(this.mapProdutos);

        if(prod.ItensTotal > 0) {
            this.mapCarrinho.set(prod.Produto.Id, prod);
        }
        else {
            this.mapCarrinho.delete(prod.Produto.Id);
        }
        
        setTimeout(() => { 
            this.listaProdutosCarrinho =  this.mapCarrinho.values();

            var headerObject = { 
                "Data" : this.headerObject.Data,
                "OrderNumber" : this.headerObject.OrderNumber,
                "ItensLength" : this.headerObject.ItensLength -= 1,
                "CustomerName" : this.headerObject.CustomerName,
                "totalValue" : this.headerObject.totalValue -= prod.Produto.Pre_o__c
            }
            this.headerObject = headerObject;
        }, 500);
    }

    SalvarPedidoJS() {
        SalvarPedido({totalValue : this.FinalValue, desconto : this.desconto, cliente : this.selectedRecord.Id})
        .then((result)=>{           
            console.log(result);          
            this.idPedido = result[0];
            var headerObject = { 
                "Data" : this.headerObject.Data,
                "OrderNumber" : result[1],
                "ItensLength" : this.headerObject.ItensLength,
                "CustomerName" : this.headerObject.CustomerName,
                "totalValue" : this.headerObject.totalValue
            }
            this.headerObject = headerObject;

            setTimeout(() => { 
                this.mapCarrinho.values().forEach(element => { 
                    SalvarProdPedido({quantidade : element.ItensTotal, prodId : element.Produto.Id, pediId : result[0]})   
                });  
            }, 1000);
            setTimeout(() => { 
                this.navigateToRecord(result[0]);        
            }, 3000);
                             
        }) 
    }

    navigateToRecord(id) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: id,
                actionName: 'view'
            }
        });
    }
}