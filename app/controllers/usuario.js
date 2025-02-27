const modelUsuario = require("../models/modelUsuario")
const usuario = require("../rotas/usuario")
const dados = require("../rotas/usuario")
const Joi = require("joi")

module.exports.abre_cadastro_usuario = function (app,request,response)
{
    const conexao = app.config.conexao
    response.render('usuario/cadastro',{erros : {}, dados : {}})
}

module.exports.login = function (app,request,response)
{
    const conexao = app.config.conexao
    response.render('usuario/login',{erros : {}, usuario : {}})
}

module.exports.cadastroUsuario = function (app,request,response)
{
    const dados = request.body
    const conexao = app.config.conexao
    const modelUsuario = new app.app.models.modelUsuario(conexao)
    const schema = Joi.object({
        nome: Joi.string()
        .min(3)
        .max(30)
        .required()
        .messages({
            "string.empty": "O campo 'Nome' não pode estar vazio!",
            "string.min": "O campo 'Nome' deve ter no mínimo {#limit} caracteres!",
            "string.max": "O campo 'Nome' deve ter no máximo {#limit} caracteres!"
        }),
        email: Joi.string()
        .min(6)
        .email()
        .required()
        .messages({
            "string.empty": "O campo 'Email' não pode estar vazio!",
            "string.min": "O campo 'Email' deve ter no mínimo {#limit} caracteres!",
            "string.email": "Por favor, insira um Email válido."
        })
    })
    
    const { error } = schema.validate(dados, { abortEarly: false });

    if (error) {
        console.log(error.details.map(err => err.message));
    }
    else
    {
        modelUsuario.cadastroUsuario(dados, function(error,result){
            response.redirect('/usuario/login')
        })
    }

}

module.exports.validar = function (app,request,response)
{
    const dados = request.body
    
    const conexao = app.config.conexao
    const modelUsuario = new app.app.models.modelUsuario(conexao)

    modelUsuario.getUsuario(dados, function(error, result){
       if(result.length < 1)
        {
            let erros = [{msg:'Usuario não encontrado'}]
            response.render('usuario/login',{erros:erros, usuario:dados})
        }
        else
        {
            request.session.id_tipo_usuario = result[0].id_tipo_usuario
            request.session.id_usuario = result[0].id
            response.redirect('/')
        }
    })
}
module.exports.sair = function (app,request,response)
{
    request.session.destroy(function(error){
        response.redirect('/usuario/login')
    })
}
module.exports.abre_cadastro_produto = function (app,request,response)
{
    const conexao = app.config.conexao
    const modelUsuario = new app.app.models.modelUsuario(conexao)

    modelUsuario.getCategorias(function (error, categoria) {
        response.render('usuario/cadastro_produto', { categoria: categoria, dados : {}, erros: {} })
    })
}
module.exports.cadastroProduto = function (app, request, response) {
    const dados = request.body
    const conexao = app.config.conexao
    const modelUsuario = new app.app.models.modelUsuario(conexao)
    
    modelUsuario.cadastroProduto(dados, function(error,result){
        console.log(response)
        return response.render('home/index')
    })
}
module.exports.cadastroPromo = function (app,request,response)
{
    const dados = request.body
    const conexao = app.config.conexao
    const modelUsuario = new app.app.models.modelUsuario(conexao)
    const schema = Joi.object({
        nome: Joi.string()
        .required()
        .messages({
            "string.empty": "O campo 'Nome' não pode estar vazio!"
        }),
        desc: Joi.string()
        .required()
        .messages({
            "string.empty": "O campo 'Desconto' não pode estar vazio!"
        })
    })
    
    const { error } = schema.validate(dados, { abortEarly: false });

    if (error) {
        console.log(error.details.map(err => err.message));
    }
    else
    {
        modelUsuario.cadastroPromo(dados, function(error,result){
            response.redirect('/')
        })
    }
}
module.exports.abre_cadastro_promo = function (app,request,response)
{
    const conexao = app.config.conexao
    response.render('usuario/cadastrar_promo',{dados : {}})

}
module.exports.abre_cadastro_venda = function (app, request, response)
{
    const conexao = app.config.conexao
    response.render('usuario/cadastro_venda', {dados : {}})
}
module.exports.cadastroVenda = function (app, request, response){
    const conexao = app.config.conexao
    const modelUsuario = new app.app.models.modelUsuario(conexao)
    modelUsuario.cadastroVenda(dados, function(error,result){
        console.log(response)
        return response.render('home/index')
    })
}
module.exports.abre_cadastro_item_venda = function (app, request, response)
{
    const conexao = app.config.conexao
    response.render('usuario/cadastro_item_venda', {dados : {}})
}
module.exports.cadastroItemVenda = function (app, request, response){
    const conexao = app.config.conexao
    const modelUsuario = new app.app.models.modelUsuario(conexao)
    modelUsuario.cadastroItemVenda(dados, function(error,result){
        console.log(response)
        return response.render('usuario/cadastro_venda')
    })
}
module.exports.abreForma = function (app,request,response)
{
    const conexao = app.config.conexao
    const modelUsuario = new app.app.models.modelUsuario(conexao)

    modelUsuario.getTipoRecebi(function (error, recebimento) {
        response.render('usuario/cadastrar_forma', { recebimento: recebimento, dados : {}, erros: {} })
    })
}
module.exports.cadastroForma = function (app,request,response)
{
    const dados = request.body
    const conexao = app.config.conexao
    const modelUsuario = new app.app.models.modelUsuario(conexao)
    {
        modelUsuario.cadastroForma(dados, function(error,result){
            response.redirect('/')
        })
    }
}