		# Aluno: Igor Ronsoni #
# Atividade Avaliativa de Organização de Computadores "
	
	.data
	
menu:	 	.string 	"Selecione... \n 1: Inserir\n 2: Remover\n 3: Imprimir\n 4: Sair\nOpcao: "
retorno:	.string		"Retorno da funcao: "
quebra_linha:	.string		"\n\n"
erro:		.string		"\nOpcao inexistente. Tente novamente\n\n"
erroRetorno: 	.string		"\nOcorreu um erro. Tente novamente\n"
opcao_insere: 	.string		"\nDigite o valor a ser inserido\nValor: "
opcao_remove:	.string		"\nSelecione...\n 1: Remover elemento por indice\n 2: Remover elemento por valor\nOpcao: "	
opcao_remove_index: .string	"\nDigite o indice a ser removido\nIndice: "
opcao_remove_valor: .string	"\nDigite o valor a ser removido\nvalor: "
inicio_da_lista: .string	"\n["
espacamento:	.string		" "
fim_da_lista:	.string		"]"
stringFimInsercao: .string	"\nQuantidade de insercoes: "
stringFimRemocao: .string	"\nQuantidade de remocoes: "
	
	.text
	
	#### Registradores com valores pre definidos #### 
	li	s0, -1	 	# Registrador s2 responsavel por armazenar primeiro endereco da lista. Inicializado com -1 para nao ocasionar problemas
	li 	s1, -1	 	# Registrador especifico para o teste de memoria ja encadeada
	li	s2, 0		# Registrador para soma das inserções
	li	s3, 0		# Registrador para soma das remoções
		
main:
	#### Mostra menu ########
	la 	a0, menu	# Carrega em a0 a frase contida no endereco [menu]	
	li	a7, 4 		# Argumento de valor 4 indicando a impressao de uma string
	ecall 			# Chamada de sistema
	
	#### Espera o numero de uma opcao ####
	# a0 <- valor inserido via terminal
	li 	a7, 5 		# Argumento de valor 5 indicando que vai esperar um inteiro ser inserido no terminal
	ecall 			# Chamada de sistema 

	#### Realiza os teste para saber qual a opcao foi selecionada ####
	
	### Inserir ###
	teste_insere:
		addi	t0, zero, 1	# Atribui valor 1 para testar se a opcao selecionada foi "inserir"
	
		bne	a0, t0, teste_remove # Em caso da opcao selecionada for diferente de 'insere', e feito um desvio para testar se a opcao e 'remove' 
	
		#### Valor a ser inserido ########
		la 	a0, opcao_insere # Carrega em a0 a frase contida no endereco [opcao_insere]	
		li	a7, 4 		# Argumento de valor 4 indicando a impressao de uma string
		ecall 			# Chamada de sistema
	
		#### Espera o valor a ser inserido ####
		# a0 <- valor inserido via terminal
		li 	a7, 5		# Argumento de valor 5 indicando que vai esperar um inteiro ser inserido no terminal
		ecall 			# Chamada de sistema
		 
		add	t0, zero, a0	# Salva temporariamente o valor a ser inserido
	
		chama_funcao_insere:
		#### Prepara argumentos nos registradores indicados pela funcao ####
		add	a0, zero, s0	# a0 <- s0 endereco da primeira alocacao
		add 	a1, zero, t0	# a1 <- valor a ser inserido
		
		jal 	insere		# Chamada para a funcao
	
		beq 	a0, s1, erros	# Em caso de retornar -1 no a0 será tratado erros
		
		addi	s2, s2, 1	# Soma a quantidade de inserções
		add	s0, zero, a1	# Salva em s0 o endereco de memoria do primeiro elemento da lista
	
		j 	reinicia_menu	# Chamda de desvio para a impressao do retorno da funcao e chamada do menu

	### Remover ###	
	teste_remove:	
		addi	t0, zero, 2	# Atribui valor 2 para testar se a opcao selecionada foi "remover"	
	
		bne	a0, t0, teste_imprime # Em caso da opcao selecionada for diferente de 'remove', e feito um desvio para testar se a opcao e 'teste_imprime'

		#### Menu de Remocao ####
		la 	a0, opcao_remove # Carrega em a0 a frase contida no endereco [opcao_remove]	
		li	a7, 4 		# Argumento de valor 4 indicando a impressao de uma string
		ecall 			# Chamada de sistema
	
		#### Espera o numero de uma opcao ####
		# a0 <- valor inserido via terminal
		li 	a7, 5 		# Argumento de valor 5 indicando que vai esperar um inteiro ser inserido no terminal
		ecall 			# Chamada de sistema 

		remove_index:	
			addi	t0, zero, 1	# Carrega o valor de 1 para testar se a opcao de remocao foi via indice	
		
			bne	a0, t0, remove_value # Testa se a opcao escolhida é a remocao por indice
	
			#### Menu de Remocao via indice ####
			la 	a0, opcao_remove_index # Carrega em a0 a frase contida no endereco [opcao_remove_index]	
			li	a7, 4 		# Argumento de valor 4 indicando a impressao de uma string
			ecall 			# Chamada de sistema
	
			#### Espera o numero de indice ####
			# a0 <- indice inserido via terminal
			li 	a7, 5 		# Argumento de valor 5 indicando que vai esperar um inteiro ser inserido no terminal
			ecall 			# Chamada de sistema 
		
			#### Prepara argumentos para a chamada da funcao ####
			add 	a1, zero, a0	# Carrega em a1 o indice declarado em a0
			add	a0, zero, s0	# Carrega para a0 o endereco do primeiro elemento da lista
	
			jal 	remove_indice	# Chama para a funcao 'remove_indice'
		
			beq	a0, s1, erros	# Em caso de retornar -1 no a0 será tratado erros 
		
			addi	s3, s3, 1	# Soma a quantidade de remocoes
			add	a0, zero, a1	# Salva em a0 o valor contido no indice retirado
	
			j	reinicia_menu	# Chamda de desvio para a impressao do retorno da funcao e chamada do menu
	
		remove_value:
			addi	t0, zero, 2	# Carrega o valor de 1 para testar se a opcao de remocao foi via valor
	
			bne	a0, t0, erro_remove # Testa se a opcao escolhida é a removao via valor  
	
			#### Menu de Remocao via valor ####
			la 	a0, opcao_remove_valor # Carrega em a0 a frase contida no endereco [opcao_remove_valor]	
			li	a7, 4 		# Argumento de valor 4 indicando a impressao de uma string
			ecall 			# Chamada de sistema
		
			#### Espera o numero de indice ####
			# a0 <- indice inserido via terminal
			li 	a7, 5 		# Argumento de valor 5 indicando que vai esperar um inteiro ser inserido no terminal
			ecall 			# Chamada de sistema 
		
			#### Prepara argumentos para a chamada da funcao ####
			add 	a1, zero, a0	# Carrega para a1 o valor declarado em a0
			add	a0, zero, s0	# Carrega para a0 o endereco do primeiro elemento da lista
		
			jal 	remove_valor	# Chama para a funcao remove_valor
				
			beq	a0, s1, erros	# Em caso de retornar -1 no a0 será tratado erros 
		
			addi	s3, s3, 1	# Soma a quantidade de remocoes
			add	a0, zero, a1	# Salva em a0 o indice que valor estava contido
		
			j	reinicia_menu	# Chamda de desvio para a impressao do retorno da funcao e chamada do menu
		
		erro_remove:
			la	a0, erro	# Carrega em a0 a frase contida no endereco erro
			li	a7, 4		# Argumento de valor 1 indicando a impressao de uma string
			ecall			# Chamada de sistema
	
			j	teste_remove	# Chamada de desvio para teste_remove
	
	### Imprimir ###
	teste_imprime:
		addi	t0, zero, 3	# Atribui valor 3 para testar se a opcao selecionada foi "imprimir"
	
		bne	a0, t0, teste_fim # Em caso da opcao selecionada for diferente de 'imprime', e feito um pulo para testar se a opcao e 'teste_fim' 
	
		#### Prepara argumentos para a chamada da funcao ####
		add	a0, zero, s0	# Carrega para a0 o endereco do primeiro elemento da lista
		
		jal 	imprime_lista	# Chama para a funcao imprime_lista
	
		j 	main		# Chamada de desvio para o menu
	### Sair ###
	teste_fim:
		addi	a3, zero, 4	# Atribui valor 4 para testar se a opcao selecionada foi "sair"
	
		bne	a0, a3, teste_erro # Em caso da opcao selecionada for diferente de 'sair', e feito um pulo para erro na opcao
	
		la	a0, stringFimInsercao # Carrega em a0 a frase contida no endereco 'stringFimInsercao'
		li	a7, 4		# Argumento de valor 1 indicando a impressao de uma string
		ecall			# Chamada de sistema
	
		add	a0, zero, s2 	# Carrega para a0 o valor de insercoes ocorridas no programa
		li	a7, 1		# Argumento de valor 1 indicando a impressao de uma string
		ecall			# Chamada de sistema
	
		la	a0, stringFimRemocao # Carrega em a0 a frase contida no endereco 'stringFimRemocao'
		li	a7, 4		# Argumento de valor 1 indicando a impressao de uma string
		ecall			# Chamada de sistema
	
		add	a0, zero, s3 	# Carrega para a0 o valor de remocoes ocorridas no programa
		li	a7, 1		# Argumento de valor 1 indicando a impressao de uma string
		ecall			# Chamada de sistema
		
		la	a0, quebra_linha # Carrega em a0 a frase contida no endereco quebra_linha
		li	a7, 4		# Argumento de valor 4 indicando a impressao de uma string
		ecall			# Chamada de sistema
	
		j 	fim		# Chamada de desvio para o fim do programa
	
	### Teste de erro ao selecioanr uma opcao ###
	teste_erro:
		la	a0, erro	# Carrega em a0 a frase contida no endereco erro
		li	a7, 4		# Argumento de valor 1 indicando a impressao de uma string
		ecall			# Chamada de sistema
		j 	main		# Chamada de desvio para o menu

	### Rotulo com a intencao de imprimir o retorno das funcoes e reiniciar a main ###
	reinicia_menu:
		add	t0, zero, a0	# Salva temporariamente o valor do retorno da funcao
	
		#### Imprime o retorno da funcao ####
		la	a0, retorno	# Carrega em a0 a frase contida no endereco retorno
		li	a7, 4		# Argumento de valor 4 indicando a impressao de uma string
		ecall			# Chamada de sistema
	
		add	a0, zero, t0	# Salva novamente em a0 o retorno da funcao
		li	a7, 1		# Argumento de valor 1 indicando a impressao de um inteiro
		ecall			# Chamada de sistema
		
		la	a0, quebra_linha # Carrega em a0 a frase contida no endereco quebra_linha
		li	a7, 4		# Argumento de valor 4 indicando a impressao de uma string
		ecall			# Chamada de sistema
		
		j 	main		# Termina impressoes da funcao e reinicia menu

	### Erro nos retornos das funcoes ###
	erros:	
		la	a0, erroRetorno	# Carrega em a0 a frase contida no endereco 'erroRetorno'
		li	a7, 4		# Argumento de valor 4 indicando a impressao de uma string
		ecall	
	
		add	a0, zero, s1	# Carrega para a0 o valor de erro
		j 	reinicia_menu	# Chamada de desvio para reiniciar o menu
	
# Funcoes Secundarias #

########################################################################
#   				malloc				       # 
# Argumentos: void						       #
# Retorno: a0 <- endereco de memoria				       #
# Registradores ocupados:  a0 - quantidade de celulas a serem alocadas #
#				e o retorno da funcao		       #
# 			   a7 - argumento de chamada de ecall          #
# Comentarios: A funcao tem como objetivo apenas   		       #
#   alocar um endereco de memoria de 8 celulas e retornar 	       #
#   o endereco da primeira celula pelo registrador		       #
########################################################################

malloc:
	li 	a0, 8 		# Indicado quantas celulas devera ser alocado na memoria
	li 	a7, 9 		# Argumento de valor 9 indicando a alocacao de um espaco na memoria
	ecall 			# Chamada de sistema
	
	sw	zero, 0(a0) 	# Insere valor 0 no deslocamento 0 da alocacao
	sw	s1, 4(a0)	# Insere valor -1 no deslocamento 4 da alocacao
	
	ret 			# Retorno da funcao

########################################################################
#   				free				       # 
# Argumentos: a0 <- endereco de memoria				       #
# Retorno: void							       #
# Registradores ocupados:  nenhum				       #
# Comentarios: A funcao tem como objetivo zerar os valores contidos    #
#   em um endereco de memoria (Liberar memoria)			       #
########################################################################

free:
	sw	zero, 0(a0)	# Carrega o valor zero pro primeiro deslocamento do endereco
	sw	zero, 4(a0)	# Carrega o valor zero para o quarto deslocamento
	
	ret			# Retorno da funcao
	
# Funcoes Primarias #

########################################################################
#   				insere				       # 
# Argumentos: a0 - endereco do primeiro elemento		       #
#	      a1 - valor inteiro a ser inserido			       #
# Retorno: a0 <- (-1) em caso de erro / ( indice do valor inserido ) em#
#		caso de sucesso					       #
#	   a1 <- endereco do primeiro elemento da lista		       #
# Registradores ocupados:  a0 - retorno da funcao ( -1 ou indice )     #
#			   	argumento de entrada ( endereco )      #
#			   a1 -	argumento de entrada ( valor inteiro ) #
#			   	retorno da funcao (endereco)	       #
#			   s1 - valor fixo -1			       #
#			   t0 - guardar valor de ra para o retorno     #
#			   t1 - endereco do alocamnto anterior 	       #
#			   t2 - endereco do proximo alocamento	       #
#			   t3 - contador de laco / indice	       #
#			   t4 - valor da alocacao atual		       #
# Comentarios: A funcao tem como objetivo tentar inserir um valor      #
#   especificado no endereco de memoria adquirido, em caso de sucesso  #
#   sera retornado a posicao na lista e o endereco do primeiro elemento#
#   e em caso de erro sera retornado o valor -1   		       #
########################################################################

insere:
	#### Preparacao dos registradores ####
	add 	t0, zero, ra 	# Salva o endereco da chamada da funcao 'insere' na main para o retorno
	add	t1, zero, a0	# Salva em t1 o endereco de a0
	add	t2, zero, a0	# Salva em t2 o endereco de a0
	add	t3 ,zero, zero	# Inciar o contador do laco/ indice da lista
	
	beq 	a0, s1, i_aloca	# Compara se é a primeira alocacao do sistema	
		
	i_laco_insere:
		beq	t2, s1, i_aloca	# Caso t2 for igual a -1 quer dizer que esta na ultima alocacao, entao e so alocar
	
		lw	t4, 0(t2)	# Carrega o valor do alocamento atual
	
		blt	a1, t4, i_aloca	# Caso o valor contido no alocamento atual for menor que o passado por arumento entao devera ser feito a preparacao dos registradores para a nova insercao
	
		beq	t1, t2, i_continua_laco # Caso t1 e t2 forem iguais quer dizer que a comparacao esta sendo feita nos dois primeiros alocamentos
	
		add	t1, zero, t2	# Carrega em t1 o endereco do alocamento testado
	 
		i_continua_laco:	
			lw 	t2, 4(t2)	# Carrega em t2 o endereco do proximo alocamanto
			addi 	t3, t3 ,1	# Adiciona 1 ao controlador do laco	

		j 	i_laco_insere	# Chama um desvio para voltar para o inicio do laco	 

	i_aloca:
		jal 	malloc		# Cria uma nova alocacao
		sw	a1, 0(a0) 	# Carrega o valor do argumento a1 para a alocamento atual
		sw	t2, 4(a0)	# É inserido o valor -1 no deslocamento 4 da alocacao para indicar que e a ultima alocacao
	
		beq 	t1, s1, i_termina_funcao_insere # Caso o endereco anterior do alocamente atual é -1 entao e a primeira insercao
		beq	t1, t2, i_termina_funcao_insere # Ou caso o endereco de t1 for igual a t2 entao deve ser inserido antes da primeira alcacao
	
		sw 	a0, 4(t1)	# Salva no 4 deslocamento do alocamento anterior o endereco da alocacao atual
		add	a0, zero, s0	# Carrega em a0 o endereco da primeira alocacao para que nao haja mudanca 
	
	i_termina_funcao_insere:
		add	a1, zero, a0	# Carrega em a1 o endereco do elemento atual da primeira posicao 
		add	a0, zero, t3	# Carrega para a0 o valor do contador do laco para retorno
		add	ra,zero,t0	# Carrega pra ra o valor da chamada do inicio da funcao
		ret			# Chama o retorno com o endereco em ra ja incluido retornando a main

########################################################################
#   			  remove_indice 			       # 
# Argumentos: a0 - endereco do primeiro elemento		       #
#	      a1 - indice a ser removido			       #
# Retorno: a0 <- (-1) em caso de erro / ( 1 ) em caso de sucesso       #
#	   a1 <- valor contido no indice 			       #
# Registradores ocupados:  a0 - retorno da funcao ( -1 ou 1 )	       #
#			   	argumento de entrada ( endereco )      #
#				endereco alocamento atual	       #
#			   a1 -	argumento de entrada ( indice )	       #
#			   t0 - guardar valor de ra para o retorno     #
#			   t1 - alocamento anterior	 	       #
#			   t2 - contatodor do laco		       #
#			   t3 - endereco do proximo alocamento         #
# Comentarios: A funcao tem como objetivo tentar remover um valor      #
#   atraves de um indice, em caso de sucesso, a funcao retorna o valor #
#   presente no alocamenteo removido e em caso de erro, a funcao       #
#   retorna -1							       #  
########################################################################

remove_indice:
	#### Preparacao dos registradores ####
	add 	t0, zero, ra 	# Salva o endereco da chamada da funcao 'remove_indice' na main para o retorno
	add	t1, zero, s1	# Salva em t1 o valor -1 de inicio
	add	t2, zero, zero	# Inicia o contador de laco
		
	beq	a0, s1, ri_erro # Caso a lista estiver vazia, ocorrera um erro pois nao ha o indice escolhido
	blt	a1, zero, ri_erro # Caso o indice indicado for negatvo entao nao existe	
	
	ri_laco_remove_indice:
		beq	a1, t2, ri_remove_indice # Compara se o indice informado e o mesmo que o laco esta testando
	
		addi	t2, t2, 1	# Soma o contador do laco
	
		add	t1, zero, a0	# Salva em t1 o endereco atual testado
		lw 	a0, 4(a0)	# Carrega para a0 a proxima alocacao
	
		beq	a0, s1, ri_erro	# Se o enedereco que sera testado for igual a -1 entao o indice solicitado nap foi encontrado, portanto retornara um erro
	
		j	ri_laco_remove_indice # Chama um desvio para inicio do laco

	ri_remove_indice:
		lw	t3, 4(a0)	# Salva em t3 o endereco contido no 4 deslocamente de a0
		
		beq	t1, s1, ri_novo_primeiro_indice # Caso o endereco de t1 seja igual a -1, quer dizer que e o primeiro elemento da lista que deve ser apagado
	
		sw	t3, 4(t1)	# Salva o novo endereco que t1 deve apontar
	
	ri_reendereca:
		lw	a1, 0(a0)	# Salva o valor contido no alocamento para retorno
	
		jal 	free		# Chama a funcao free para limpar as celulas de memoria
	
		addi	a0, zero, 1	# Salva em a0 o valor 1 para retorno indicando sucesso
		j	ri_termina_funcao_remove_indice # Chama um desvio para terminar a funcao

	ri_novo_primeiro_indice:
		add	s0, zero, t3	# Salva t3 como novo primerio item
		j	ri_reendereca	# Chama um desvio para continuar a preparacao de remocao
	
	ri_erro: 
		add	a0, zero , s1 	# Salva em a0 o valor -1 para indicar que ocorreu um erro
		add	a1, zero, zero  # Salva o valor zero no registrador a1 para nao haver saida de lixo
	
	ri_termina_funcao_remove_indice:
		add	ra,zero,t0	# Carrega pra ra o valor da chamada do inicio da funcao
		ret	

########################################################################
#   			  remove_valor				       # 
# Argumentos: a0 - endereco do primeiro elemento		       #
#	      a1 - valor a ser removido			      	       #
# Retorno: a0 <- (-1) em caso de erro / ( 1 ) em caso de sucesso       #
#	   a1 <- indice do valor removido			       #
# Registradores ocupados:  a0 - retorno da funcao ( -1 ou 1 )          #
#			   	argumento de entrada ( endereco )      #
#				endereco do proximo alocamento	       #
#			   a1 -	argumento de entrada ( indice )	       #
#			   t0 - guardar valor de ra para o retorno     #
#			   t1 - alocamento anterior do testado 	       #
#			   t2 - contador do laco		       #
#			   t3 - endereco do proximo alocamento	       #
#			   t4 - valor do alocamento atual	       #
# Comentarios: A funcao tem como objetivo tentar remover uma alocacao  #
#   atraves de um valor, em caso de sucesso, a funcao retorna o indice #
#   relacionado ao alocamenteo removido e em caso de erro, a funcao    #
#   retorna -1							       #  
########################################################################

remove_valor:
	#### Preparacao dos registradores ####
	add 	t0, zero, ra 	# Salva o endereco da chamada da funcao 'remove_indice' na main para o retorno
	add	t1, zero, s1	# Salva em t1 o valor -1 de inicio
	add	t2, zero, zero	# Inicia o contador de laco
		
	beq	a0, s1, ri_erro # Caso a lista estiver vazia, ocorrera um erro pois nao ha o indice escolhido
	
	rv_laco_remove_valor:
		lw	t4, 0(a0) 	# Carrega para t4 o valor do endereco atual
			
		beq	a1, t4, rv_remove_valor # Testa se o valor passado e o mesmo do alocamento atual
		blt	a1, t4, rv_erro	# Se o valor que eu quero retirar for menor que o valor que esta sendo testado, ocasionara um erro, pois o valor n esta na lista
		
		addi	t2, t2, 1	# Soma o contador do laco
	
		add	t1, zero, a0	# Salva em t1 o endereco atual tertado
		lw 	a0, 4(a0)	# Carrega para a0 a proxima alocacao
	
		beq	a0, s1, rv_erro	# Se o enedereco que sera testado for igual a -1 entao o indice solicitado nap foi encontrado, portanto retornara um erro
	
		j	rv_laco_remove_valor # Chama um desvio para inicio do laco

	rv_remove_valor:
		lw	t3, 4(a0)	# Salva em t3 o endereco contido no 4 deslocamente de a0
	
		beq	t1, s1, rv_novo_primeiro_indice # Caso o endereco de t1 seja igual a -1, quer dizer que e o primeiro elemento da lista que deve ser apagado
	
		sw	t3, 4(t1)	# Salva o novo endereco que t1 deve apontar
	
	rv_reendereca:
		add	a1, zero, t2	# Salva o indice do alocamento para retorno
	
		jal 	free		# Chama a funcao free para limpar as celulas de memoria
	
		addi	a0, zero, 1	# Salva em a0 o valor 1 para retorno indicando sucesso
		j	rv_termina_funcao_remove_valor # Chama um desvio para terminar a funcao

	rv_novo_primeiro_indice:
		add	s0, zero, t3	# Salva t3 como novo primerio item
		j	rv_reendereca	# Chama um desvio para continuar a preparacao de remocao
	
	rv_erro: 
		add	a0, zero , s1 	# Salva em a0 o valor -1 para indicar que ocorreu um erro
		add	a1, zero, zero  # Salva o valor zero no registrador a1 para nao haver saida de lixo
	
	rv_termina_funcao_remove_valor:
		add	ra,zero,t0	# Carrega pra ra o valor da chamada do inicio da funcao
		ret	

########################################################################
#   			  imprime_lista 			       # 
# Argumentos: a0 - endereco do primeiro elemento		       #
# Retorno: void						   	       # 
# Registradores ocupados:  a0 - valores de impresssao na chamada de    #
#   sistema							       #
#			   t0 - guardar valor de ra para o retorno     #
#			   t1 - alocamento atual para pegar os valores #
# Comentarios: A funcao tem como objetivo imprimir os valores presentes#
#   na lista encadeada	 					       #  
########################################################################

imprime_lista:
	#### Preparacao dos registradores ####
	add 	t0, zero, ra 	# Salva o endereco da chamada da funcao 'remove_valor' na main para o retorno
	add	t1, zero, a0	# Faz uma copia de a0 para deslocar-se pelo vetor
	
	la	a0, inicio_da_lista # Carrega em a0 a string 'inicio_da_lista'
	li	a7, 4		# Argumento de valor 4 indicando a impressao de uma string
	ecall			# Chamada de sistema
	
	il_laco_imprime:
		beq	t1, s1, il_termina_funcao_imprime
	
		la	a0, espacamento	 # Carrega em a0 a string
		li	a7, 4		# Argumento de valor 4 indicando a impressao de uma string
		ecall			# Chamada de sistema
	
		lw	a0, 0(t1)	# Carrega em a0 a o valor do alocamento atual
		li	a7, 1		# Argumento de valor 1 indicando a impressao de um inteiro
		ecall			# Chamada de sistema
	
		lw	t1, 4(t1)	# Passa para o proximo alocamento
		j	il_laco_imprime	# Chama desvio para o laco

	il_termina_funcao_imprime:
		la	a0, espacamento	# Carrega em a0 a string 'espacamento'
		li	a7, 4		# Argumento de valor 4 indicando a impressao de uma string
		ecall			# Chamada de sistema
		la	a0, fim_da_lista # Carrega em a0 a string 'fim_da_lista'
		li	a7, 4		# Argumento de valor 4 indicando a impressao de uma string
		ecall			# Chamada de sistema
	
		la	a0, quebra_linha # Carrega em a0 a frase contida no endereco quebra_linha
		li	a7, 4		# Argumento de valor 1 indicando a impressao de uma string
		ecall			# Chamada de sistema

	fim_funcao_imprime:	
		add	ra,zero,t0	# Carrega pra ra o valor da chamada do inicio da funcao
		ret
		
### Fim do programa ###
fim:
	nop 			# Termina programa