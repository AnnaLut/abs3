
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostq_avg.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTQ_AVG (p_acc NUMBER, p_dat1 DATE, p_dat2 DATE) RETURN NUMBER IS
-- Повертає середньо - арифметичний залишов в еквіваленті по рахунку за період (календарних днів)
-- Дата останніх змін - 29.11.2012
-- 20130905 убран вызов процедуры FOSTQ_DKB
 l_sum   NUMBER;
 l_count NUMBER;
 l_ost   NUMBER;
 l_i     NUMBER;
 l_dat   DATE;
 KV_     NUMBER;
BEGIN
  IF p_dat1 > p_dat2 THEN RETURN 0; END IF;

  SELECT KV INTO KV_ FROM ACCOUNTS WHERE ACC=p_acc;
  IF KV_=980 THEN
    RETURN FOSTV_AVG(p_acc, p_dat1, p_dat2);
  END IF;

  l_sum :=0;
  l_count := p_dat2 - p_dat1;
  --DBMS_OUTPUT.PUT_LINE('l_count = '||l_count);
  FOR l_i IN 0..l_count
    LOOP
       l_dat := p_dat1 + l_i;
     BEGIN
       SELECT nvl(gl.p_icurval(kv_,fost(p_acc,fdat), fdat),0) INTO l_ost FROM fdat WHERE fdat=l_dat;
    --DBMS_OUTPUT.PUT_LINE(l_dat||': '||'1 l_ost = '||l_ost);
     EXCEPTION WHEN NO_DATA_FOUND THEN
       BEGIN
         SELECT nvl(gl.p_icurval(kv_,fost(p_acc,l_dat), l_dat),0)  INTO l_ost FROM dual;
         --DBMS_OUTPUT.PUT_LINE(l_dat||': '||'2 l_ost = '||l_ost);
       EXCEPTION WHEN NO_DATA_FOUND THEN
           l_ost := 0;
         --DBMS_OUTPUT.PUT_LINE(l_dat||': '||'3 l_ost = '||l_ost);
       END;
     END;
     l_sum := l_sum + l_ost;
    END LOOP;

  --DBMS_OUTPUT.PUT_LINE('l_sum = '||l_sum);
  --DBMS_OUTPUT.PUT_LINE('(l_count+1) = '||(l_count+1));
  l_sum:=ROUND(l_sum/(l_count+1));

 RETURN l_sum;
END FOSTQ_AVG;
/
 show err;
 
PROMPT *** Create  grants  FOSTQ_AVG ***
grant EXECUTE                                                                on FOSTQ_AVG       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOSTQ_AVG       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostq_avg.sql =========*** End *** 
 PROMPT ===================================================================================== 
 