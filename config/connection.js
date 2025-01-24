const connection = function (){
    const mysql = require('mysql')

    return mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: '',
        database: 'frente_caixa'
    })
}

module.exports = connection