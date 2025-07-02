import { LightningElement } from 'lwc';

export default class SegundoLWC extends LightningElement {
    valor1;
    valor2;
    resultado;
    metodo1(e) {
        this.valor1 = parseInt(e.target.value);
    }
    metodo2(e) {
        this.valor2 = parseInt(e.target.value);
    }
    handleClick() {
        this.resultado = this.valor1 + this.valor2;
    }
}