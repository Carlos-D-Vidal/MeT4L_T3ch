function admin(conexao) {
    this._conexao = conexao
}

admin.prototype.cadastroAdmin = function (dados, callback) {
    dados.senha = this._crypto.createHash('md5').update(dados.senha).digest('hex')
    this._conexao.query(`insert into usuario values(null,'${dados.nome}','${dados.senha}','${dados.email}',${dados.id_tipo_usuario})`, dados, callback)
}
admin.prototype.editarUsuario = function(dados,id,callback)
{
    this._conexao.query(`update usuario set nome = '${dados.nome}',email = '${dados.email}',senha = '${dados.senha}',id_tipo_usuario = ${dados.id_tipo_usuario} where id = ${id}`,callback)
}
admin.prototype.cadastroProduto = function (dados, callback) {

    codigoProduto = function(){
        return Math.floor(1000 + Math.random() * 9000)
    }
    
    codigoBarra = function(text, elementId) {
        if (!JsBarcode) {
            console.error("JsBarcode library is not loaded.");
            return;
        }
            
        JsBarcode("#" + elementId, text, {
            format: "CODE128",
            lineColor: "#000",
            width: 2,
            height: 50,
            displayValue: true
        });
    }

    this._conexao.query(`insert into produto values(null,'${dados.descricao}','${dados.preco}','${dados.quant}',${codigoProduto},'${codigoBarra}',${dados.id_categoria},${dados.comissao},'${dados.status}')`, dados, callback)
}
admin.prototype.getProduto = function(id,callback){
    this._conexao.query(`select * from produto where id = ${id}`, callback)
}
admin.prototype.editarProduto = function (dados, id, callback) {
    this._conexao.query(`update produto set descricao = '${dados.descricao}', preco = '${dados.preco}' where id= ${id}`, callback)
}
admin.prototype.excluirProduto = function (id, callback) {
    this._conexao.query(`delete from produto where id = ${id}`, callback)
}
module.exports = function () {
    return admin
}