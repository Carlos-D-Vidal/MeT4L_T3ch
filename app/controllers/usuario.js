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
    //request.assert('nome','Voce deve preencher o campo nome').notEmpty()
    //request.assert('email','Voce deve preencher o campo email').notEmpty()

    //let erros = request.validationErrors() ? request.validationErrors() : []
    
    //if(erros.length>0)
    //{
    //    response.render('usuario/cadastro',{erros : erros, usuario : dados})
    //    return
    //}

    //if(erros.length ==0){
    //    erros = false
    //}
//modelUsuario.getUsuarioByEmail(dados, function(error,result){
//    if (result.length > 0){
//        let erros = [{msg: 'Este email já está em uso'}]
//        response.render('usuario/cadastro',{erros : erros, usuario : dados})
//    }
//    else{
//            modelUsuario.cadastrarUsuario(dados,function (error,result){
//            response.redirect('/usuario/login')
//        })
//    }
//})

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
module.exports.abrirAlterar = function(app,request,response)
{
    if(request.session.id_tipo_usuario != 1 && request.session.id_tipo_usuario != 2)
    {
        response.redirect('/usuario/login')
        return
    }
    const idUsuario = request.session.id_usuario
    const conexao = app.config.conexao
    const modelUsuario = new app.app.models.modelUsuario(conexao)
    modelUsuario.get(idUsuario,function(error,usuario){
        response.render('usuario/alterarDados',{usuario : usuario, erros:{}})
    })
}
module.exports.alterarDados = function(app,request,response)
{
    const dados = request.body
    const idUsuario = request.session.id_usuario
    const conexao = app.config.conexao
    const modelUsuario = new app.app.models.modelUsuario(conexao)
    modelUsuario.alterarDados(dados,idUsuario, function(error, result){
        response.redirect('/')
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
    /*
    const codigoProduto = app.app.models.model
    const schema = Joi.object({
        desc: Joi.string()
        .required()
        .messages({
            "string.empty": "O campo 'Descrição' não pode estar vazio!"
        }),
        preco: Joi.number()
        .required()
        .messages({
            "number.empty": "O campo 'Preço' não pode estar vazio!"
        }),
        quant: Joi.number()
        .required()
        .messages({
            "number.empty": "O campo 'Quantidade' não pode estar vazio!"
        }),
        codigo: codigoProduto,
        codigo_barra: codigoBarra,
        id_categoria: null,
        registra_comissao: null,
        status: null
    })
        */
    {
    modelUsuario.cadastroProduto(dados, function(error,result){
        response.redirect('/')
    })
    }
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