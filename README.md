# Códigos para o Wolfram Mathematica desenvolvidos ao longo da tese de doutorado na Unicamp

# Título da tese: Interseção de Esferas e Álgebra Geométrica
# autor: Marcelo Santos Carielo
# Campinas, junho de 2019


## Link para download no repositório de teses da Unicamp:
## http://repositorio.unicamp.br/jspui/handle/REPOSIP/334844

## Resumo:

O problema de interseção de esferas aparece em diferentes aplicações da geometria de
distâncias. Esferas cujos raios são intervalares têm especial interesse quando os dados
provém de experimentos físicos, onde há incertezas nas medições. Utilizando a álgebra
geométrica conforme, desenvolvemos uma maneira eficiente de realizar a interseção entre
esferas e cascas esféricas. Comparamos os resultados obtidos com a abordagem clássica,
baseada na álgebra linear, e fizemos experimentos computacionais para validar a abordagem
proposta.

## DESCRIÇÃO DOS CÓDIGOS:

#3 - Testes com instâncias artificiais (não vindas de experimentos NMR).

#4 - Contém mais de 20 testes, onde fomos gradualmente aumentando a dificuldade dos testes.

#5 - Testes com a versão do BP via AGC proposta na tese. Há um exemplo comparando o BP via AGC e clássico para n=10, ..., 100.

#6 - Testes com respeitos às dificuldades do pacote clifford.m e CliffordBasic.m em termos de precisão.

#7 - Testes com respeitos às dificuldades do pacote clifford.m.

#8 - Teste simles sobre interseção via AGC onde se escolhe a quantidade de esferas e dimensões.

#9 - Novos testes comparando a abordagem clássica e a via AGC, proposta na tese.



## OBSERVAÇÕES:

(1) Nos códigos desenvolvidos utilizamos o pacote para AGC denominado *clifford.m* 
https://github.com/jlaragonvera/Geometric-Algebra
https://arxiv.org/abs/0810.2412

(2) Utilizamos ainda a seguinte implementação para o algoritmo BP, em sua versão para álgebra linear:
https://github.com/michaelsouza/bioinfo/blob/master/codes/IMPA2017/mdgp.nb



