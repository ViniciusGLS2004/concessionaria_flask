import mysql.connector
from PIL import Image
from io import BytesIO

cs = mysql.connector.connect(
    host='localhost',
    user='root',
    password='',  # senha do seu banco de dados
    database='cs_veiculo'
)

cursor = cs.cursor()


class Veiculo:
    def __init__(self, tipo, cor, ano, estado, kmrodados, leilao, num_placa, tipo_combustivel, direcao, marca, modelo,
                 tipo_desempenho, desempenho, preco, imagem):
        self.tipo = tipo
        self.cor = cor
        self.ano = ano
        self.estado = estado
        self.rodados = kmrodados
        self.leilao = leilao
        self.placa = num_placa
        self.combustivel = tipo_combustivel
        self.direcao = direcao
        self.marca = marca
        self.modelo = modelo
        self.tipo_desempenho = tipo_desempenho
        self.desempenho = desempenho
        self.preco = preco
        self.imagem = imagem

    def create(self):
        comando = (
            'INSERT INTO veiculo (vei_tipo, vei_cor, vei_ano, vei_estado, vei_kmrodados, vei_leilao, '
            'vei_placa, vei_tipo_combustivel, vei_direcao, vei_marca, vei_modelo, vei_tipo_desempenho, vei_desempenho, vei_preco, vei_imagem) '
            'VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'
        )
        # '%s' são espaços reservados que serão preenchidos com valores. Cada %s representa uma coluna na tabela.

        # valores: Esta é uma tupla que contém os valores que serão inseridos nas colunas da tabela. Cada valor na tupla corresponde a um espaço reservado %s na instrução comando.
        valores = (self.tipo, self.cor, self.ano, self.estado, self.rodados, self.leilao, self.placa,
                   self.combustivel, self.direcao, self.marca, self.modelo, self.tipo_desempenho, self.desempenho,
                   self.preco, self.imagem)

        # O comando é a string SQL com espaços reservados, e os valores são fornecidos para preencher esses espaços reservados.
        cursor.execute(comando, valores)

        # cs.commit(): Após a execução bem-sucedida da instrução INSERT, é necessário confirmar a transação usando commit()
        cs.commit()

        comando = f'SELECT * FROM veiculo'  # codigo para printar os dados da tabela
        cursor.execute(comando)
        resultado = cursor.fetchall()  # ler o banco de dados
        print(resultado)

    def update(self, alter, idveiculo, alteracao_veiculo):
        if alter == 1:
            comando = f'UPDATE veiculo SET vei_tipo = "{alteracao_veiculo}" WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 2:
            comando = f'UPDATE veiculo SET vei_cor = "{alteracao_veiculo}" WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 3:
            comando = f'UPDATE veiculo SET vei_ano = {alteracao_veiculo} WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 4:
            comando = f'UPDATE veiculo SET vei_estado = "{alteracao_veiculo}" WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 5:
            comando = f'UPDATE veiculo SET vei_kmrodados = {alteracao_veiculo} WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 6:
            comando = f'UPDATE veiculo SET vei_leilao = "{alteracao_veiculo}" WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 7:
            comando = f'UPDATE veiculo SET vei_placa = {alteracao_veiculo} WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 8:
            comando = f'UPDATE veiculo SET vei_tipo_combustivel = "{alteracao_veiculo}" WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 9:
            comando = f'UPDATE veiculo SET vei_direcao = "{alteracao_veiculo}" WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 10:
            comando = f'UPDATE veiculo SET vei_marca = "{alteracao_veiculo}" WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 11:
            comando = f'UPDATE veiculo SET vei_modelo = "{alteracao_veiculo}" WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 12:
            comando = f'UPDATE veiculo SET vei_tipo_desempenho = "{alteracao_veiculo}" WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 13:
            comando = f'UPDATE veiculo SET vei_desempenho = "{alteracao_veiculo}" WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        elif alter == 14:
            comando = f'UPDATE veiculo SET vei_preco = {alteracao_veiculo} WHERE vei_id = {idveiculo}'
            cursor.execute(comando)
            cs.commit()

        comando = f'SELECT * FROM veiculo'  # codigo para printar os dados da tabela
        cursor.execute(comando)
        resultado = cursor.fetchall()  # ler o banco de dados
        print(resultado)

    def delete(self, nomedelete):
        comando = f'DELETE FROM veiculo WHERE vei_placa = "{nomedelete}"'
        cursor.execute(comando)
        cs.commit()

    comando = f'SELECT * FROM veiculo'  # codigo para printar os dados da tabela
    cursor.execute(comando)
    resultado = cursor.fetchall()  # ler o banco de dados
    print(resultado)

    def adicionar_imagem(self, caminho_imagem):
        # Abra a imagem com o Pillow
        imagem = Image.open(caminho_imagem)

        # Faça o processamento da imagem conforme necessário

        # Salve a imagem de volta em BytesIO
        nova_imagem_bytes = BytesIO()
        imagem.save(nova_imagem_bytes, format='PNG')  # Substitua 'PNG' pelo formato correto, se necessário

        # Converta os dados da imagem de volta em bytes
        nova_imagem_bytes = nova_imagem_bytes.getvalue()

        # Atualize a tabela com a nova imagem
        comando = (
            'UPDATE veiculo '
            'SET vei_imagem = %s '
            'WHERE vei_placa = %s'
        )
        valores = (nova_imagem_bytes, self.placa)
        cursor.execute(comando, valores)
        cs.commit()


# Criação do objeto com seus atributos
vei_tipo = input("Digite o tipo do veiculo:\n")
vei_cor = input("Digite a cor do veiculo:\n")
vei_ano = int(input("Digite o ano do veiculo:\n"))
vei_estado = input("Digite o estado do veiculo:\n")
vei_kmrodados = float(input("Digite os km rodados do veiculo:\n"))
vei_leilao = input("Digite (sim ou nao) se o veiculo é ou não de leilao :\n")
vei_placa = input("Digite o numero da placa do veiculo:\n")
vei_tipo_combustivel = input("Digite o tipo do combustivel do veiculo:\n")
vei_direcao = input("Digite a direção do veiculo:\n")
vei_marca = input("Digite a marca do veiculo:\n")
vei_modelo = input("Digite o modelo do veiculo:\n")
vei_tipo_desempenho = input("Digite o tipo de desempenho do veiculo:\n")
vei_desempenho = input("Digite o desempenho do veiculo:\n")
vei_preco = float(input("Digite o preço do veiculo:\n"))

# Adicione uma imagem ao veículo
caminho_imagem = r'C:\Users\Senai\PycharmProjects\python-Iniciante\imagem\jeep.png'  # Substitua pelo caminho da imagem
with open(caminho_imagem, 'rb') as arquivo_imagem:
    dados_imagem = arquivo_imagem.read()

# Agora crie o objeto Veiculo após ter os dados da imagem
veiculo = Veiculo(vei_tipo, vei_cor, vei_ano, vei_estado, vei_kmrodados, vei_leilao, vei_placa,
                  vei_tipo_combustivel, vei_direcao, vei_marca, vei_modelo, vei_tipo_desempenho, vei_desempenho,
                  vei_preco, dados_imagem)

# Adicione uma imagem ao veículo
caminho_imagem = r'C:\Users\Senai\PycharmProjects\python-Iniciante\imagem\jeep.png'  # Substitua pelo caminho da imagem
with open(caminho_imagem, 'rb') as arquivo_imagem:
    dados_imagem = arquivo_imagem.read()
veiculo.adicionar_imagem(caminho_imagem)
veiculo.create()

alt = input("Deseja fazer alguma alteração na tabela? (sim ou nao):\n")
while alt == "sim":
    menu = int(input("Me diga o que você quer fazer:"
                     "\n 1 - alterar dado:"
                     "\n 2 - deletar dado:"
                     "\n 3 - Sair:\n"))
    if menu == 1:
        alter = int(input("Digite a informação específica a ser alterada:"
                          "\n 1 - alterar tipo:"
                          "\n 2 - alterar cor:"
                          "\n 3 - alterar ano:"
                          "\n 4 - alterar estado:"
                          "\n 5 - alterar km rodados:"
                          "\n 6 - alterar leilão:"
                          "\n 7 - alterar numero de placa:"
                          "\n 8 - alterar tipo do combustivel:"
                          "\n 9 - alterar direção:"
                          "\n 10 - alterar marca:"
                          "\n 11 - alterar modelo:"
                          "\n 12 - alterar tipo de desempenho:"
                          "\n 13 - alterar desempenho:"
                          "\n 14 - alterar preço:\n"))
        if alter >= 1 and alter <= 14:
            ide = int(input("Digite o id do veiculo:\n"))
            altera = input("Digite o novo valor:\n")
            veiculo.update(alter, ide, altera)
            print("Dado alterado!")

    elif menu == 2:
        nomedelete = input("Digite o numero da placa do veiculo que quer deletar da tabela:\n")
        veiculo.delete(nomedelete)
        print("Veiculo deletado!")

    elif menu == 3:
        break

    alt = input("Deseja fazer alguma alteração na tabela veiculo? (sim ou nao):\n")
print("Codigo veiculo fechado!")

# Caminho da imagem que você deseja carregar
caminho_imagem = r'C:\Users\Senai\PycharmProjects\python-Iniciante\imagem\jeep.png'

# Carregar a imagem do caminho fornecido
imagem = Image.open(caminho_imagem)

# Exibir a imagem
imagem.show()

cursor.close()
cs.close()
