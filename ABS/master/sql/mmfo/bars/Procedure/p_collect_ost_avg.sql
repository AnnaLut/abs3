

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_COLLECT_OST_AVG.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_COLLECT_OST_AVG ***

  CREATE OR REPLACE PROCEDURE BARS.P_COLLECT_OST_AVG (p_dat DATE) IS
   l_dat1 DATE;
   l_dat2 DATE;
   l_ost  NUMBER;
BEGIN
  -- расчет первого и последнего дней прошлого месяца
  SELECT to_date('01.'||
              decode(to_char(to_char(p_dat,'MM')),'01','12',to_char(to_char(p_dat,'MM')-1))||
			  '.'  ||
              decode(to_char(p_dat,'MM'),'01',to_char(to_char(p_dat,'YYYY')-1),to_char(p_dat,'YYYY')),
		 'DD.MM.YYYY'),
		 last_day(to_date('01.'||
		      decode(to_char(to_char(p_dat,'MM')),'01','12',to_char(to_char(p_dat,'MM')-1))||
			  '.'||
              decode(to_char(p_dat,'MM'),'01',to_char(to_char(p_dat,'YYYY')-1),to_char(p_dat,'YYYY')),
         'DD.MM.YYYY'))
  INTO l_dat1, l_dat2
  FROM dual;

  -- Критерий отбора счетов для расчета среднекалендарного остатка за прошлый месяц
  FOR c_acc IN
     (SELECT a.acc, at.kod
      FROM accounts a, acc_tarif at, tarif t
      WHERE a.dazs IS NULL AND a.acc=at.acc AND at.kod=t.kod AND nvl(t.tip,0)=1 AND
	   (nvl(at.tar,0)<>0 OR nvl(at.pr,0)<>0)
      ORDER BY a.acc)
  LOOP
     SELECT ROUND(bars.fost_avg (c_acc.acc, l_dat1, l_dat2)) INTO l_ost FROM dual;

     UPDATE acc_tarif SET ost_avg = l_ost WHERE acc=c_acc.acc AND kod=c_acc.kod;
     IF SQL%rowcount = 0 THEN
        INSERT INTO acc_tarif (acc, kod, ost_avg)
        VALUES (c_acc.acc, c_acc.kod, l_ost);
     END IF;

  END LOOP; -- c_acc
END p_collect_ost_avg;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_COLLECT_OST_AVG.sql =========***
PROMPT ===================================================================================== 
