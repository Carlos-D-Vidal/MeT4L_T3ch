const cliente = require("../rotas/cliente")
const dados = require("../rotas/cliente")
const Joi = require("joi")
const modelCliente = require("../models/modelCliente")
module.exports.abre_cadastro_cliente = function (app,request,response)
{
    const conexao = app.config.conexao
    const modelCliente = new app.app.models.modelCliente(conexao)

    modelCliente.getMunicipios(function (error, municipio) {
        response.render('cliente/cadastro_cliente', { municipio: municipio, dados : {}, erros: {} })
    })
}

module.exports.cadastroCliente = function (app,request,response)
{
    const dados = request.body
    const conexao = app.config.conexao
    const modelCliente = new app.app.models.modelCliente(conexao)
    
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
            }),
            natureza: Joi.string()
            .required()
            .messages({
                "string.empty": "O campo 'Natureza' deve ser preenchido."
            }),
            cnpj_cpf: Joi.string()
            .required()
            .messages({
                "string.empty": "O campo 'CNPJ/CPF' não pode estar vazio!"
            }),
            rg: Joi.number()
            .required()
            .integer()
            .messages({
                "number.empty": "O campo 'RG' não pode estar vazio!"
            }),
            nascimento: Joi.date()
            .required()
            .iso()
            .less('now')
            .messages({
                "date.empty": "O campo 'Nascimento' não pode estar vazio!"
            }),
            bairro: Joi.string()
            .required()
            .messages({
                "string.empty": "O campo 'Bairro' não pode estar vazio!"
            }),
            numero: Joi.number()
            .required()
            .integer()
            .positive()
            .messages({
                "number.empty": "O campo 'Número' não pode estar vazio!"
            }),
            logradouro: Joi.string()
            .required()
            .messages({
                "string.empty": "O campo 'logradouro' não pode estar vazio!"
            })

    })
        
    // const { error } = schema.validate(dados, { abortEarly: false });
    
    
    
        var model = modelCliente.cadastroCliente(dados);
        response.render('cliente/cadastro_cliente')
    
}