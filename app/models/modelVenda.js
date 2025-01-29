function Venda(conexao){
    this._conexao = conexao
}
Venda.prototype.existePedidoAberto = function (idCliente) {
    return new Promise((resolve, reject) => {
        this._conexao.query(`SELECT * FROM venda WHERE id_cliente = ${idCliente} AND status_venda = 1;`, function(errors, result) {
            if (result.length == 0) {
                resolve(false);
            }
            else {
                resolve(true);
            }
        })
    })
}

Venda.prototype.criarPedido = function (idCliente) {
    return new Promise((resolve, reject) => {
        this._conexao.query(`INSERT INTO venda VALUES(NULL, '1', current_timestamp, ${totalVenda}, ${idCliente}, NULL, ${totalItem}, NULL, NULL, ${observacao});`, function(errors, result) {
            resolve(result);
        })
    })
}
Venda.prototype.getPedidoAberto = function(idCliente){
    return new Promise((resolve, reject)=>{
        this._conexao.query(`select * from venda where id_cliente = ${idCliente} and status = '1'`, function(erros, result){
            resolve(result)
        })
    })
}
Venda.prototype.getIdPedidoAberto = function(idCliente){
    return new Promise((resolve, reject)=>{
        this._conexao.query(`select id_venda from venda where id_cliente = ${idCliente} and status = '1'`, function(erros, result){
            resolve(result[0].id)
        })
    })
}
module.exports = function () {
    return Venda;
}