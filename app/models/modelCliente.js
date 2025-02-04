function cliente (conexao)
{
    this._conexao = conexao
}
cliente.prototype.cadastroCliente = function (dados,callback){
    this._conexao.query(`insert into cliente values(null,'${dados.nome}',0,'${dados.natureza}','${dados.cnpj_cpf}','${dados.rj}','${dados.nascimento}',1,'${dados.ie}','${dados.bairro}','${dados.numero}','${dados.logradouro}','${dados.email}',null,1)`, dados,callback)
}
cliente.prototype.getCliente = function(dados,callback)
{
    this._conexao.query(`select * from cliente where cnpj_cpf = '${dados.cnpj_cpf}'`, callback)
}
cliente.prototype.getMunicipios = function(callback)
{
    this._conexao.query(`select * from municipio`, callback)
}
cliente.prototype.getClientes = function(callback)
{
    this._conexao.query('select * from cliente',callback)
}
cliente.prototype.get = function(id,callback)
{
    this._conexao.query(`select * from cliente where id_cliente = ${id}`,callback)
}
cliente.prototype.excluirUsuario = function(id,callback)
{
    this._conexao.query(`delete from cliente where id_cliente = ${id}`, callback)
}
cliente.prototype.alterarDados = function(dados,id,callback)
{
    this._conexao.query(`update cliente set nome_cliente = '${dados.nome}', natureza = '${dados.natureza}', cnpj_cpf = ${dados.cnpj_cpf}, rg = ${dados.rg}, nascimento = '${dados.nascimento}', id_municipio = ${dados.id_municipio}, ie = ${dados.ie}, bairro = '${dados.bairro}', numero = ${dados.numero}, logradouro = '${dados.logradouro}', email = '${dados.email}' where id_cliente = ${id}`, callback)
}
cliente.prototype.addPromocao = function (dados,id,callback){
    this._conexao.query(`update cliente set pacote_promocao = ${dados.pacote_promocao} where id_cliente = '${id}'`)
}
cliente.prototype.editarStatusCliente = function(dados, id, callback){
    this._conexao.query(`update cliente set status = ${dados.status} where id_cliente = ${id}`)
}
module.exports = function()
{
    return cliente
}