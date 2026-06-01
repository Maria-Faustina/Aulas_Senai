#importa o flafla
from flask import Flask, render_template
#criar aplicação
app = Flask(__name__)

#rota - define o que acontece quando algum acessa o site
# o '/' significa a pagina principal do site (ex: https://localhost:5000

@app.route('/')
def pagina_inicial():
    #criação de duas variaveis para enviar o html
    texto_p_html = "hahah isso qui é python!"
    mylist =[" composto V, virus super, leite"]
    #render_templates procura o arquivo dentro da pasta 'templates'
    # Os paramêtros após a virgula são enviados paa o HTML
    return render_template("index.html", mensagem=texto_p_html, lista_exemplos=mylist)


if __name__=='__main__':
    #debug=true significa: Atualiza automaticamente
    # port=5000 é a porta padrão
    #host='0.0.0.0' permite acesso a rede local (opcional)
    app.run(debug=True, host='0.0.0.0',port=5000)

