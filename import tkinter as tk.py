import tkinter as tk
from tkinter import  messagebox
janela = tk()
def adicionar():
    ''' adiciona um numero ou operador no display'''
    display.insert(tk.END, valor=None)

def limpar():
    display.delete(0, tk.END)
def calcular():
    try:
        expressao = display.get()
        ''' pega o texto atual do display'''

        expressao.replace("x", "*").replace('÷', '/')
        resultado = eval(expressao)
        display.deslete(0, tk.END)
        display.insert(tk.End, valor=0)
    except ZeroDivisionError:
        messagebox.showerror("erro", 'dvisao por zero')

limpar()

        #interface

janela.tk.Tk()
janela.title(" Calculadora Moveis")
janela.geometry("350x120")
janela.reziable

        #diplay

display = tk.Entry(janela, width=35, borderwidth=5)

        #lista botoes

botoes = [
            'c', '±','%','÷', #linha1
            '7','8','9','X',  #linha2
            '4','5','6','-',  #linha3
            '1','2','3','+',  #linha4
            '0', '.','='      #linhe5 (ocupa 2 coluna)
        ]
        #cores para a calculadora
cor_operador = "#white"
cor_numero = "#ff9500"
cor_especial = "#a6a6a6"

row = 1  #comaca na linha, linha 0 é o display
row = 0 #comeca na coluna 0
for botao in botoes:
    if botao =="=":
                btn = tk.Button(janela, text="botoes",font=(""), bg=cor_operador, fg="white", height=2, command=calcular, )
                btn.grid(column=col, row=row, columnspan=2, padx=3, sticky="nsew" )
                coll +=2
    elif botao  in "÷x-+":
                #operadore matematicos
                btn = tk.Button(janela, text=botao, font=("bold"),fg="white",
                bg=cor_numero, command=lambda v=botao: adicionar(v))
                btn.grid(column=col, row=row, columnspan=2, padx=3, sticky="nsew", pady=3)
                col =+1
    elif botao in 'c±%':
            btn = tk.Button(janela, text=botao, font=("bold"),fg="white",
            bg=cor_numero, command=lambda v=botao: adicionar(v))
            btn.grid(olumn=col, row=row, columnspan=2, padx=3, sticky="nsew", columnspan=2, pady=3)
            col =+1
    else:
                btn = tk.Button(janela, text=botao, font=("bold"),fg="white",
                bg=cor_numero, command=lambda v=botao: adicionar(v))
                btn.grid(olumn=col, row=row, columnspan=2, padx=3, sticky="nsew", columnspan=2, pady=3)
                col =+1
    if col > 3:
           col = 0
           row =+1
janela.mainloop()