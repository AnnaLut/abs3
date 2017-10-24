

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ROOT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ROOT ***

  CREATE OR REPLACE PROCEDURE BARS.ROOT (
	   tt_ IN VARCHAR2, -- операція комісії
	   MaxS IN NUMBER, -- сума на рахунку
	   X OUT NUMBER -- максимальна допустима сума, з врахуванням комісії
) IS
--====================================================================
-- Module      : DPT
-- Author      : vblagun
-- Desc	 : Процедура використовується для розрахунку максимальної допустимої суми переказу з рахунку,
--  		   щоб залишок був рівний комісії, яку потрібно оплатити.
--  		  Для цього ми розвязуємо рівняння S - x - f(x) = 0 методом ділення навпіл :-)
--  			S - залишок на рахунку
--  			х - максимальна допустима сума
--  			f(x) - комісія, що обчислюється в залежності від суми
-- 19-03-2007:  створена
--====================================================================
  a NUMBER; 			   -- лівий край інтервалу
  b NUMBER;				   -- правий край інтервалу
  c NUMBER;
  s_f VARCHAR2(256);  -- формула суми
  s_a NUMBER;		  	 -- значення суми в лівому краю інтервалу
  s_b NUMBER;			 -- значення суми в правому краю інтервалу
  -- обробка помилок
  l_mod CONSTANT VARCHAR2(3) := 'DPT';
BEGIN
a:= 0;
b:= MaxS;
  -- одержуємо формулу суми
  BEGIN
	 SELECT s INTO s_f FROM TTS WHERE tt =tt_;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
	 Bars_Error.raise_nerror(l_mod, 'TT_NOT_FOUND', tt_);
  END;

  -- поки інтервал не збігся в єдину точку продовжуємо
  WHILE (b - a >= 1)
  LOOP
	   -- беремо середню точку
	   c := ((a + b) / 2);
	   -- обчислюємо значення формули на краях інтервалу
	   BEGIN
	   		Doc_Strans('SELECT ROUND(' || REPLACE(s_f,'#(SMAIN)',':SMAIN') || ') from dual', s_a, a);
	   EXCEPTION
	     WHEN OTHERS THEN
		  Bars_Error.raise_nerror(l_mod, 'SUM_EVAL_ERR', REPLACE(s_f,'#(SMAIN)',a));
	   END;

	   BEGIN
	   	   Doc_Strans('SELECT ROUND(' || REPLACE(s_f,'#(SMAIN)',':SMAIN') || ') from dual', s_b, c);
	   EXCEPTION
	     WHEN OTHERS THEN
		  Bars_Error.raise_nerror(l_mod, 'SUM_EVAL_ERR', REPLACE(s_f,'#(SMAIN)',c));
	   END;

	   -- якщо корінь між а і с - зсуваємо правий край
	   IF (MaxS - a - s_a) * (MaxS - c - s_b) < 0 	   THEN b := c;
	   -- інакше зсуваємо лівий край
	   ELSE a := c;
	   END IF;

  END LOOP;

 x := ROUND((a + b) / 2);

END;
 
/
show err;

PROMPT *** Create  grants  ROOT ***
grant EXECUTE                                                                on ROOT            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ROOT            to DPT_ROLE;
grant EXECUTE                                                                on ROOT            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ROOT.sql =========*** End *** ====
PROMPT ===================================================================================== 
