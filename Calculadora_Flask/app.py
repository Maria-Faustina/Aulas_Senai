from flask import Flask, render_template, request

app = Flask(__name__)



@app.route('/form', methods=['POST'])
def processar_formulario():

    n1 = float(request.form['n1'])
    n2 = float(request.form['n2'])
    operacao = request.form['operacao']


    if operacao == 'soma':
        resultado = n1 + n2
    elif operacao == 'menos':
        resultado = n1 - n2
    elif operacao == 'vezes':
        resultado = n1 * n2
    elif operacao == 'divisao':
        if n2 == 0:
            resultado = "Não é possível dividir por zero."
        else:
            resultado = n1 / n2
    else:
        resultado = "Operação inválida."

    return render_template('index.html', resultado=resultado)


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
