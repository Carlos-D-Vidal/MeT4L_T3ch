const cliente = require("../rotas/cliente")
const dados = require("../rotas/cliente")
const Joi = require("joi")
module.exports.abre_cadastro_cliente = function (app,request,response)
{
    const conexao = app.config.conexao
    const modelCliente = new app.app.models.modelCliente(conexao)

    modelCliente.getMunicipios(function (error, municipio) {
        modelCliente.getPromocao(function(error, promocao){
        response.render('cliente/cadastro_cliente', { municipio: municipio, promocao: promocao, dados : {}, erros: {} })
    })
})
}

module.exports.cadastroCliente = function (app,request,response)
{
    const dados = request.body
    const conexao = app.config.conexao
    const modelCliente = new app.app.models.modelCliente(conexao)
    {
        modelCliente.cadastroCliente(dados, function(error,result){
            response.redirect('/')
        })
    }

}
module.exports.listarCliente = function(app, request, response){
    const conexao = app.config.conexao
    const modelCliente = new app.app.models.modelCliente(conexao)
    modelCliente.getClientes(function (error, result) {
        response.render('usuario/listar_cliente', { cliente: result })
    })
}