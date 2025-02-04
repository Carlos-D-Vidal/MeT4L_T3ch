module.exports = function (app){
    app.get('/cliente/abre_cadastro_cliente', function (request, response) {
        app.app.controllers.cliente.abre_cadastro_cliente(app, request, response)
    })

    app.post('/cliente/cadastrar', function (request, response) {
        app.app.controllers.cliente.cadastroCliente(app, request, response)
    })

}