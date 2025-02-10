
function usuario(conexao) {
    this._conexao = conexao
}

usuario.prototype.cadastroUsuario = function (dados, callback) {
    this._conexao.query(`insert into usuario values(null,'${dados.nome}','${dados.email}',2,1)`,callback)
}
usuario.prototype.editarUsuario = function(dados,id,callback)
{
    this._conexao.query(`update usuario set nome = '${dados.nome}',email = '${dados.email}' where id = ${id}`,callback)
}
usuario.prototype.cadastroProduto = function (dados, callback) {
    this._conexao.query(`insert into item values(null,'${dados.descricao}','${dados.preco}', '${dados.estoque}', '${dados.codigo}', '${dados.codigoBarra}', '${dados.idCategoria}',1, '${dados.status})`, dados, callback)
}
usuario.prototype.getProduto = function(id,callback){
    this._conexao.query(`select * from item where id_item = ${id}`, callback)
}
usuario.prototype.getUsuario = function(dados,callback){
    this._conexao.query(`select * from usuario where nome = '${dados.name}' and email = '${dados.email}'`, callback)
}
usuario.prototype.getCategorias = function(callback){
    this._conexao.query(`select * from categoria`, callback)
}
usuario.prototype.editarProduto = function (dados, id, callback) {
    this._conexao.query(`update item set desc_item = '${dados.descricao}', preco_item = '${dados.preco}', quant_item = '${dados.estoque}', status = '${dados.status}' where id= ${id}`, callback)
}
usuario.prototype.excluirProduto = function (id, callback) {
    this._conexao.query(`delete from item where id_item = ${id}`, callback)
}
usuario.prototype.cadastroProduto = function (dados, callback) {

    let codigoProduto = Math.floor(1000 + Math.random() * 9000);

    let codigoBarra = Math.floor(1000000000000 + Math.random() * 9000000000000).toString();
    
    this._conexao.query(`insert into item values(null,'${dados.descricao}','${dados.preco}','${dados.quant}',${codigoProduto},'${codigoBarra}',${dados.id_categoria},${dados.comissao},'${dados.status}')`, dados, callback)
}
usuario.prototype.cadastroPromo = function (dados, callback) {
    this._conexao.query(`insert into promocao values(null,'${dados.nome}',${dados.desc})`,callback)
}
usuario.prototype.cadastroVenda = function (dados, callback){
    this.conexao.query(`insert into venda values(null,'${dados.status}', current_timestamp, ${dados.total}, ${dados.idCliente}, ${dados.numeroVenda}, ${dados.total_item}, ${dados.desconto}, ${dados.acrescimo}, ${dados.observacao})`)
}
usuario.prototype.cadastroItemVenda = function (dados, callback){
    this.conexao.query(`insert into venda values(null,'${dados.idItem}', ${dados.idVenda}, ${dados.quant}, ${dados.preco}, ${dados.total}, ${dados.desconto}, ${dados.acrescimo}, current_timestamp, ${dados.idUsuario}, ${dados.status})`)
}
usuario.prototype.getTipoRecebi = function(callback){
    this._conexao.query(`select * from tipo_recebimento`, callback)
}
usuario.prototype.cadastroForma = function (dados, callback){
    this.conexao.query(`insert into forma_pagamento values(null,'${dados.descrForma}', '${dados.idTipo}', '${dados.parcelas}', 1)`,callback)
    console.log(dados)
}
module.exports = function () {
    return usuario
}