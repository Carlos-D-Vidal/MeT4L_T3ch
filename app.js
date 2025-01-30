const app = require('./config/server') ()
app.listen(5500, function(){
    console.log('Servidor conectado com sucesso.')
});