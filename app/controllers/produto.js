const produto = require("../rotas/produto")

module.exports.abre_cadastro_produto = function (app,request,response)
{
    const conexao = app.config.conexao
    const modelProduto = new app.app.models.modelProduto(conexao)

    modelCliente.getCategorias(function (error, categoria) {
        response.render('usuario/cadastro_produto', { categoria: categoria, dados : {}, erros: {} })
    })
}