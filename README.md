<h2 align="center">Assembly RISC V - Lista encadeada</h2>

##### Instruções:
- Trabalho em dupla
- Data de entrega parcial: 05/11/2020 (obrigatória)
- Data de entrega final: 19/11/2020
- Entregar o arquivo .asm através do ambiente Moodle
- Nome do arquivo de entrega: seunome_matricula.asm

##### Itens avaliados:
- Atendimento das instruções e especificação;
- Funcionalidade e corretude;
- Organização e identação do código fonte;
- Menus, mensagens e interface;
- Documentação e comentários do código fonte.

##### Especificação:
Faça um programa que implementa a gerencia de uma lista encadeada ordenada com capacidade de armazenar números inteiros.
O programa deve ser implementado utilizando o conjunto de instruções do RISC V (RV32I) e deve ser executado no simulador RARS.
A gerencia da memória pode ser realizada via chamada ao sistema operacional (ecall 9) ou diretamente utilizando o registrador sp. Cada elemento ocupa 8 células de memória (4 células para armazenar o número inteiro e 4 células para armazenar o ponteiro para o próximo elemento da lista).
Os valores a serem inseridos na lista devem ser obtidos via teclado utilizando a ecall 1.
Exemplo: A figura abaixo mostra 4 elementos presentes na lista ordenada (-6, 3, 11 e 19), os endereços de memória onde cada um está armazenado e o ponteiro para a posição de memória do próximo elemento da lista. No exemplo, ptr_start representa o endereço de memória inicial da lista.

ptr_start = [200]
![Exemplo](/src/imgs/exemplo.png)

O programa deve ter uma função main, a qual deve conter um menu com o acesso as seguintes funcionalidades:
  - **Inserir elemento na lista**\
      Recebe como parâmetros: posição de memória do primeiro elemento e o número inteiro a ser inserido;\
      Retorna se operação foi realizada com sucesso ou não; caso sucesso retorna a posição do elemento na lista;\
  - **Remover elemento da lista por indice**\
      Recebe como parâmetros: posição de memória do primeiro elemento e o indice do elemento a ser removido;\
      Retorna se operação foi realizada com sucesso ou não; caso sucesso mostra o número retirado da lista;\
  - **Remover elemento da lista por valor (primeiro encontrado)**\
      Recebe como parâmetros: posição de memória do primeiro elemento e o número a ser removido;\
      Indica se operação foi realizada com sucesso ou não; caso sucesso mostra o indice do valor retirado da lista;\
  - **Listar todos os elementos da lista**\
      Imprime na tela todos os elementos da lista;\
      Recebe como parâmetros: posição de memória do primeiro elemento;\
  - **Sair do programa**\
      Encerra a execução do programa mostrando a quantidade total de elementos inseridos e removidos;
      
Segue o protótipo de cada uma das funções a serem implementadas pelo programa:\

**int insere(int _lista[], int _elemento);**
  - retorna -1 caso não tenha sido possível inserir na lista e o indice da posição inserida em caso de sucesso;
  - a função deve inserir o elemento de forma ordenada na lista;
  
**int remove_indice(int _lista[], int indice);**
  - retorna -1 caso não tenha sido possível retirar da lista e o elemento retirado da posição caso contrário;
 
**int remove_valor(int _lista[], int valor);**
  - retorna -1 caso não tenha sido possível retirar da lista e o indice do elemento retirado caso contrário;
  - deve retirar o primeiro elemento encontrado com o valor informado presente na lista;

**void imprime_lista(int _lista[]);**
  - a função deve mostrar na tela todos os elementos presentes na lista;

Devem ser utilizadas as convenções de passagem e retorno de parâmetros do processador RISC V.\
Podem ser criadas outras funções auxiliares caso julgar necessário.\
O programa deve retornar ao menu principal depois de cada operação, encerrando-se somente quando o usuário solicitar (ocasião em que deve ser apresentada a quantidade total de elemetos inseridos na lista e a quantidade total de elementos removidos da lista);
