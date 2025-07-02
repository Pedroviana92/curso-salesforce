import { LightningElement } from 'lwc';


const options = [
    {value: 'AC', label: 'Acre'},
    {value: 'AL', label: 'Alagoas'},
    {value: 'AP', label: 'Amapá'},
    {value: 'AM', label: 'Amazonas'},
    {value: 'BA', label: 'Bahia'},
    {value: 'CE', label: 'Ceará'},
    {value: 'DF', label: 'Distrito Federal'},
    {value: 'ES', label: 'Espírito Santo'},
    {value: 'GO', label: 'Goiás'},
    {value: 'MA', label: 'Maranhão'},
    {value: 'MT', label: 'Mato Grosso'},
    {value: 'MS', label: 'Mato Grosso do Sul'},
    {value: 'MG', label: 'Minas Gerais'},
    {value: 'PA', label: 'Pará'},
    {value: 'PB', label: 'Paraíba'},
    {value: 'PR', label: 'Paraná'},
    {value: 'PE', label: 'Pernambuco'},
    {value: 'PI', label: 'Piauí'},
    {value: 'RJ', label: 'Rio de Janeiro'},
    {value: 'RN', label: 'Rio Grande do Norte'},
    {value: 'RS', label: 'Rio Grande do Sul'},
    {value: 'RO', label: 'Rondônia'},
    {value: 'RR', label: 'Roraima'},
    {value: 'SC', label: 'Santa Catarina'},
    {value: 'SP', label: 'São Paulo'},
    {value: 'SE', label: 'Sergipe'},
    {value: 'TO', label: 'Tocantins'},
];
export default class ExercicioLWC extends LightningElement {
    optionsPicklist = options;
    destinatario;
    cep;
    rua;
    numero;
    estado;
    cidade;
    complemento;
    ponto;
    showCard=false;
    listaProdutos = [];

    MudarNome(e) {
        this.destinatario = e.target.value;
        console.log(this.destinatario);
    }
    MudarPonto(e) {
        this.ponto = e.target.value;
    }
    MudarComplemento(e) {
        this.complemento = e.target.value;
    }
    MudarCidade(e) {
        this.cidade = e.target.value;
    }
    MudarEstado(e) {
        this.estado = e.detail.value;
    }
    MudarNumero(e) {
        this.numero = e.target.value;
    }
    MudarRua(e) {
        this.rua = e.target.value;
    }
    MudarCep(e) {
        this.cep = e.target.value;
    }
    saveForm() {
        this.showCard=true;
        console.log(this.listaProdutos);
        var listP = this.listaProdutos; 
        var qualquerNome = {
            'Destinatario' :  this.destinatario,
            'Cep' :  this.cep,
            'Rua' :  this.rua,
            'Numero' :  this.numero,
            'Estado' :  this.estado,
            'Cidade' :  this.cidade,
            'Complemento' :  this.complemento,
            'Ponto' :  this.ponto,
        };
        console.log(qualquerNome);
        listP.push(qualquerNome);
        this.listaProdutos=[];
        setTimeout(() => {
            this.listaProdutos=listP;
        }, 100);
     
    }
}