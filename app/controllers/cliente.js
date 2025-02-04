const cliente = require("../rotas/cliente")
const dados = require("../rotas/cliente")
const Joi = require("joi")

module.exports.abre_cadastro_cliente = function (app,request,response)
{
    const conexao = app.config.conexao
    response.render('cliente/cadastro_cliente',{erros : {}, dados : {}})
}

module.exports.cadastroCliente = function (app,request,response)
{
    const dados = request.body
    const conexao = app.config.conexao
    const modelCliente = new app.app.models.modelCliente(conexao)
    
    modelCliente.cadastroCliente(dados, function(error,result){
            response.redirect('/home')
        })
}