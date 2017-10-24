

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_VAR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_VAR ***

  CREATE OR REPLACE PROCEDURE BARS.P_VAR (dat_ DATE, a_95 NUMBER, a_99 NUMBER)
IS

/* ANI.  Var-анализ
   Вместе : патч patchP18.ani + PROCEDURE P_Var.sql + Bin\v_balans.apd
   История изменений:
   22.04.08 - создание (STA + MARY)
   23.05.08 - при рассчете используются логарифмы, а не их модули
   12.11.08 - если при выборе курса за последнюю дату <= нужной курсов нет,
              берется курс за первую дату > нужной (MARY)
*/

   TYPE vector IS VARRAY(20) OF NUMBER;   -- по валютам
   TYPE matrix IS VARRAY(100) OF vector;  -- по датам
   kvlist  vector := vector();		  -- список валют (для фиксации порядка)
   x_avg   vector := vector();		  -- список средних x для каждой валюты
   sigm    vector := vector();		  -- "волатильности" каждой валюты
   v       vector := vector();		  -- валютная позиция каждой валюты
   e       matrix := matrix();		  -- курсы
   x       matrix := matrix();            -- логарифмы отношений курсов за последовательные дни
   c       matrix := matrix();            -- ковариационная матрица
   i       INTEGER;
   j       INTEGER;
   l       INTEGER;
   nkv     INTEGER;
   ndat    INTEGER;
   sigm_all NUMBER;


BEGIN
   DELETE FROM TMP_VAR;
   DELETE FROM TMP_KOVAR;
   DELETE FROM tmp_korel;

   INSERT INTO TMP_VAR ( KV,  BSUM,  RATE_O,  LCV,  NAME,  NLS,  Ostc, OSTQ )
   SELECT              a.KV,c.BSUM,C.RATE_O,t.LCV,t.NAME,a.NLS, Fost(a.ACC,DAT_),
                                    Gl.P_Icurval(a.kv, Fost(a.ACC,DAT_),DAT_)
   FROM ACCOUNTS a, TABVAL t, CUR_RATES c,  VP_LIST v
   WHERE v.acc3800=a.acc AND a.kv=t.kv AND c.kv=t.kv
     AND a.dazs IS NULL
     AND (c.kv,c.vdate)=
         (SELECT kv,MAX(vdate) FROM CUR_RATES
          WHERE kv=c.KV AND vdate<=DAT_ GROUP BY kv);

   INSERT INTO TMP_VAR (KV,LCV,NAME,OSTQ)
   SELECT 0,'ALL','Загальна',SUM(OSTQ) FROM TMP_VAR;

   -- 0. список валют и валютные позиции по каждой
   i:=1;
   FOR k IN (SELECT DISTINCT kv FROM tmp_var where kv!=0)
   LOOP
      kvlist.extend;
      kvlist(i):=k.kv;
      i:=i+1;
   END LOOP;
   nkv:=i-1;
   x_avg.extend(nkv);
   sigm.extend(nkv);
   v.extend(nkv);
   FOR i IN 1..nkv
   LOOP
      SELECT SUM(ostq)
        INTO v(i)
        FROM TMP_VAR
       WHERE kv=kvlist(i);
      x_avg(i):=0;
      sigm(i):=0;
   END LOOP;

   -- 1. определение интервала дат и выписывание переменных e (курсов валют)
   j:=1;
   FOR k IN (SELECT dat_ - (c.num -1)  vdate
               FROM CONDUCTOR c
              WHERE c.num < 90
                AND (dat_ - (c.num -1) ) not in (select holiday from holiday)
	      ORDER BY c.num DESC )
   LOOP
      -- даты отсортированы, для каждой даты выписываем все валюты
      e.extend;
      e(j):=vector();
      FOR i IN 1..nkv
      LOOP
      begin
         e(j).extend;
         -- пробуем выбрать курс валюты за самый поздний день перед этой датой
         SELECT rate_o/bsum INTO e(j)(i)
           FROM CUR_RATES
          WHERE kv=kvlist(i)
            AND vdate=(SELECT MAX(vdate)
                         FROM CUR_RATES
                        WHERE kv=kvlist(i) AND vdate<=k.vdate);
      exception when no_data_found then
         -- если перед датой курса нет, пробуем выбрать курс валюты за самый ранний день после этой даты
         -- либо то, либо то будет, т.к. валюта может взяться в списке только если она есть в cur_rates
         select rate_o/bsum into e(j)(i)
           from cur_rates
          where kv=kvlist(i)
            and vdate=(select min(vdate)
                         FROM CUR_RATES
                        WHERE kv=kvlist(i) AND vdate>k.vdate);
      end;
      END LOOP;
      j:=j+1;
   END LOOP;
   ndat:=j-1;

   -- 2. перевод курсов валют в переменные x (логарифмы отношений курсов за последовательные дни)
   --    для рабочего интервала дат
   x.extend(ndat);
   FOR j IN 2..ndat
   LOOP
      x(j):=vector();
      x(j).extend(nkv);
      FOR i IN 1..nkv
      LOOP
         x(j)(i):=ABS(LN(e(j)(i)/e(j-1)(i)));
         -- и прибавить его к среднему по валюте
         x_avg(i):=x_avg(i)+x(j)(i);
      END LOOP;
   END LOOP;

   -- 3. вычисление среднего x для каждой валюты
   --    вычисление сигм для каждой валюты
   FOR i IN 1..nkv
   LOOP
      x_avg(i):=x_avg(i)/(ndat-1);	-- логарифмов на 1 меньше, чем дат
      FOR j IN 2..ndat
      LOOP
         sigm(i):=sigm(i)+(x_avg(i)-x(j)(i))*(x_avg(i)-x(j)(i));
      END LOOP;
      sigm(i):=SQRT(sigm(i)/(ndat-1));
   END LOOP;

   -- 4. вычисление матрицы ковариации (корреляции - выражается через нее)
   c.extend(nkv);
   FOR i IN 1..nkv
   LOOP
      c(i):=vector();
      c(i).extend(nkv);
   END LOOP;
   FOR i IN 1..nkv
   LOOP
      FOR j IN 1..nkv
      LOOP
         c(i)(j):=0;
         FOR l IN 2..ndat
         LOOP
            c(i)(j):=c(i)(j)+(x(l)(i)-x_avg(i))*(x(l)(j)-x_avg(j));
         END LOOP;
         c(i)(j):=c(i)(j)/(ndat-1);
      END LOOP;
   END LOOP;

   -- 5. вычисление сигмы общей позиции
   sigm_all:=0;
   FOR i IN 1..nkv
   LOOP
      FOR j IN 1..nkv
      LOOP
         sigm_all:=sigm_all+c(i)(j)*v(i)*v(j);
      END LOOP;
   END LOOP;
   sigm_all:=SQRT(sigm_all);	-- это НЕ разделенная на общую позицию всех валют, т.к. потом все равно на нее умножать

   -- 6. запись основного результата
   UPDATE TMP_VAR
      SET var_95=sigm_all*a_95, var_99=sigm_all*a_99
    WHERE kv=0;
   FOR i IN 1..nkv
   LOOP
      UPDATE TMP_VAR
         SET var_95=sigm(i)*a_95*ostq, var_99=sigm(i)*a_99*ostq, vol=sigm(i)
       WHERE kv=kvlist(i);
   END LOOP;

   -- 7. запись матриц ковариации и корелляции
   FOR i IN 1..nkv
   LOOP
      FOR j IN 1..nkv
	  LOOP
	     INSERT INTO TMP_KOVAR(dat, kv1, kv2, koef)
		                VALUES(dat_, kvlist(i), kvlist(j), c(i)(j));
		 if sigm(i)!=0 and sigm(j)!=0
		 then
            INSERT INTO tmp_korel(dat, kv1, kv2, koef)
		                   VALUES(dat_, kvlist(i), kvlist(j), c(i)(j)/sigm(i)/sigm(j));
		 else
            INSERT INTO tmp_korel(dat, kv1, kv2, koef)
		                   VALUES(dat_, kvlist(i), kvlist(j), NULL);
		 end if;
	  END LOOP;
   END LOOP;

END P_Var;
/
show err;

PROMPT *** Create  grants  P_VAR ***
grant EXECUTE                                                                on P_VAR           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_VAR           to RPBN001;
grant EXECUTE                                                                on P_VAR           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_VAR.sql =========*** End *** ===
PROMPT ===================================================================================== 
