from flask import Flask, render_template, request, url_for, flash
from werkzeug.utils import redirect
from flask_mysqldb import MySQL


app = Flask(__name__, static_folder='static', static_url_path='/static')
app.secret_key = 'many random bytes'

app.config['MYSQL_HOST'] = 'localhost'# isso isso, #esse aqui é o flask e o outro é o direto no banco de dados?
app.config['MYSQL_USER'] = 'root' #me liguei, essa senha aqui tá braba viu kkkk
app.config['MYSQL_PASSWORD'] = 'odeiolol' # top senhas kkkkk
app.config['MYSQL_DB'] = 'cs_veiculo'

mysql = MySQL(app)

@app.route('/')

@app.route('/home')
def home():
    return render_template('index.html')



@app.route('/cadastrar') # nome da pagina
def Index():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM veiculo")
    data = cur.fetchall()
    cur.close()
    
    return render_template('cadastrar.html', cs_veiculo=data)

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/cadastrar') # nome da pagina
def cadastrar():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM veiculo")
    data = cur.fetchall()
    cur.close()
    
    return render_template('cadastrar.html', cs_veiculo=data)

@app.route('/insert', methods = ['POST']) # caminho para a pagina
def insert():
    if request.method == "POST":
        flash("Veiculo adcionado com sucesso!")
        tipo = request.form['tipo']
        cor = request.form['cor']
        ano = request.form['ano']
        estado = request.form['estado']
        
        leilao = request.form['leilao']
        placa = request.form['placa']
      
        marca = request.form['marca']
        modelo = request.form['modelo']
        preco = request.form['preco']

        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO veiculo (vei_tipo, vei_cor, vei_ano, vei_estado, vei_leilao, vei_placa, vei_marca, vei_modelo, vei_preco) "
                    "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)", (tipo, cor, ano, estado, leilao, placa, marca, modelo, preco))
        mysql.connection.commit()
        return redirect(url_for('Index')) # Vai retornar a pagina de inserir dados


@app.route('/delete/<string:id>', methods = ['GET'])
def delete(id):
    flash("Veiculo deletado com sucesso!")
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM veiculo WHERE vei_id=%s", (id,))
    mysql.connection.commit()
    return redirect(url_for('Index'))


@app.route('/update', methods= ['POST', 'GET'])
def update():
    if request.method == 'POST':
        id = request.form['id']
        tipo = request.form['tipo']
        cor = request.form['cor']
        ano = request.form['ano']
        estado = request.form['estado']
        leilao = request.form['leilao']
        placa = request.form['placa']
        marca = request.form['marca']
        modelo = request.form['modelo']
        preco = request.form['preco']


        cur = mysql.connection.cursor()
        cur.execute("""
        UPDATE veiculo SET vei_tipo=%s, vei_cor=%s, vei_ano=%s, vei_estado=%s, vei_leilao=%s, vei_placa=%s, vei_marca=%s, vei_modelo=%s, vei_preco=%s
        WHERE vei_id=%s
        """, (tipo, cor, ano, estado, leilao, placa, marca, modelo, preco, id))
        flash("Veiculo alterado com sucesso!")
        mysql.connection.commit()
        return redirect(url_for('Index')) #alterar augm dado do veiculo

    id = request.args.get('id')
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM veiculo WHERE vei_id=%s", (id,))
    data = cur.fetchone()
    cur.close()
    return render_template('alterar.html', cs_veiculo=data) # não tem um html para alterar os dados


if __name__ == "__main__":
    app.run(debug=True)