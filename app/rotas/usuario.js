module.exports = function (app) {
    app.get('/usuario/abre_cadastro_usuario', function (request, response) {
        app.app.controllers.usuario.abre_cadastro_usuario(app, request, response)
    })

    app.post('/usuario/cadastro', function (request, response) {
        app.app.controllers.usuario.cadastroUsuario(app, request, response)
    })

    app.post('/usuario/cadastrar', function (request, response) {
        app.app.controllers.usuario.cadastrar(app, request, response)
    })

    app.get('/usuario/login', function (request, response) {
        app.app.controllers.usuario.login(app, request, response)
    })

    app.post('/usuario/validar', function (request, response) {
        app.app.controllers.usuario.validar(app, request, response)
    })

    app.get('/usuario/sair', function (request, response) {
        app.app.controllers.usuario.sair(app, request, response)
    })
   
    app.get('/usuario/abrirAlterar', function(request,response)
    {
        app.app.controllers.usuario.abrirAlterar(app,request,response)
    })
    app.post('/usuario/alterarDados', function (request, response) {
        app.app.controllers.usuario.alterarDados(app, request, response)
    })
    app.get('/usuario/abre_cadastro_produto', function (request, response) {
        app.app.controllers.usuario.abre_cadastro_produto(app, request, response)
    })
    app.post('/usuario/cadastro_produto', function (request, response) {
        app.app.controllers.usuario.cadastroProduto(app, request, response)
    })
}   