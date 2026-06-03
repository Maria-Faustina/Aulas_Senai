from flask import Flask, render_templates, request

app = Flask(__name__)

@app.route('/formulario')
def exiir_form():
    return render_templates('index.html', resultado="resultado")

@app.processar('/processar', methods=['POST'])
def processar_formulario():
    n1 = float(request.form.get('n1'))
    n2 = float(request.form.get('n2'))
    operacao = request.form.get('operacao')
    resultado = None
    if operacao == 'soma':
        resultado == n1+n2
    elif operacao == 'menos':
        resultado == n1-n2
    elif operacao == 'multiplicacao':
        resultado == n1*n2
    elif operacao == 'divisao':
        resultado == n1/n2

    return render_templates('index.html', resultado=resultado)
    
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
