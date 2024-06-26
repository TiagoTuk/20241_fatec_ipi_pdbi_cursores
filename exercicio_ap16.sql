-- 1.1  Escreva um cursor que exiba as variáveis rank e youtuber de toda tupla que tiver
-- video_count pelo menos igual a 1000 e cuja category seja igual a Sports ou Music.
DO $$
DECLARE
	v_count INT := 1000;
	v_cat1 VARCHAR(200):= 'Sports';
	v_cat2 VARCHAR(200):= 'Music';
	cur_rank CURSOR FOR
	SELECT rank, youtuber FROM tb_youtubers WHERE video_count >= v_count AND category IN(v_cat1, v_cat2);
	tupla RECORD;
	
BEGIN
		OPEN cur_rank;
		LOOP
		
		FETCH cur_rank INTO tupla;
		EXIT WHEN NOT FOUND;
		
		RAISE NOTICE '%', tupla;
		END LOOP;
		
		CLOSE cur_rank;
END; 
$$



-- 1.2 Escreva um cursor que exibe todos os nomes dos youtubers em ordem reversa. Para tal
-- O SELECT deverá ordenar em ordem não reversa
-- O Cursor deverá ser movido para a última tupla
-- Os dados deverão ser exibidos de baixo para cima

DO $$
DECLARE
	cur_yout CURSOR FOR
	SELECT youtuber FROM tb_youtubers ORDER BY youtuber;
	v_nome VARCHAR(200);
	
	
BEGIN
	
	OPEN cur_yout;
	FETCH LAST FROM cur_yout INTO v_nome;
	LOOP
		FETCH BACKWARD FROM cur_yout INTO v_nome;
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', v_nome;
	END LOOP;
	CLOSE cur_yout;
END;
$$

'''
1.3 Faça uma pesquisa sobre o anti-pattern chamado RBAR - Row By Agonizing Row.
Explique com suas palavras do que se trata

R: 	RBAR (Linha por linha agonizante, em português) são uma série de cláusulas e funções que, se usadas
de forma indevida em uma query/solução, acarretam problemas quanto a performance de um SGBD. 
Isso occorre pois essas funções e cláusulas processão valores linha em linha para condicionar
suas necessidades. Essas funções RBAR podem ser categorizadas como tipos não padrões de estruturas
e soluções, conhecidas como anti-pattern, geralmente ineficientes que possuem objetivos singulares
(como a função AVG(), cláusula LOOP e etc).