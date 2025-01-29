function admin(conexao) {
    this._conexao = conexao
    this._crypto = require('crypto')
}

admin.prototype.cadastroUsuario = function (dados, callback) {
    this._conexao.query(`insert into usuario values(null,'${dados.nome}','${dados.email}',2,1)`)
}
admin.prototype.editarUsuario = function(dados,id,callback)
{
    this._conexao.query(`update usuario set nome = '${dados.nome}',email = '${dados.email}' where id = ${id}`,callback)
}
admin.prototype.cadastroProduto = function (dados, callback) {
    this._conexao.query(`insert into item values(null,'${dados.descricao}','${dados.preco}', '${dados.estoque}', '${dados.codigo}', '${dados.codigoBarra}', '${dados.idCategoria}',1, '${dados.status})`, dados, callback)
}
admin.prototype.getProduto = function(id,callback){
    this._conexao.query(`select * from item where id_item = ${id}`, callback)
}
admin.prototype.editarProduto = function (dados, id, callback) {
    this._conexao.query(`update item set desc_item = '${dados.descricao}', preco_item = '${dados.preco}', quant_item = '${dados.estoque}', status = '${dados.status}' where id= ${id}`, callback)
}
admin.prototype.excluirProduto = function (id, callback) {
    this._conexao.query(`delete from item where id_item = ${id}`, callback)
}
module.exports = function () {
    return admin
}