
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fost_avg.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOST_AVG (p_acc NUMBER, p_dat1 DATE, p_dat2 DATE)
RETURN NUMBER IS
 l_sum   NUMBER;
 l_count NUMBER;
 l_ost   NUMBER;
 l_i     NUMBER;
 l_dat   DATE;
BEGIN

  IF p_dat1 > p_dat2 THEN RETURN 0; END IF;

  l_sum :=0;
  l_count := p_dat2 - p_dat1;
  --DBMS_OUTPUT.PUT_LINE('l_count = '||l_count);
  FOR l_i IN 0..l_count
    LOOP
       l_dat := p_dat1 + l_i;
     BEGIN
       SELECT FOST(p_acc, fdat) INTO l_ost FROM fdat WHERE fdat=l_dat;
    --DBMS_OUTPUT.PUT_LINE(l_dat||': '||'1 l_ost = '||l_ost);
     EXCEPTION WHEN NO_DATA_FOUND THEN
       BEGIN
         SELECT FOST_H(p_acc, l_dat) INTO l_ost FROM dual;
         --DBMS_OUTPUT.PUT_LINE(l_dat||': '||'2 l_ost = '||l_ost);
       EXCEPTION WHEN NO_DATA_FOUND THEN
           l_ost := 0;
         --DBMS_OUTPUT.PUT_LINE(l_dat||': '||'3 l_ost = '||l_ost);
       END;
     END;
     l_sum := l_sum + abs(l_ost);
    END LOOP;

  --DBMS_OUTPUT.PUT_LINE('l_sum = '||l_sum);
  --DBMS_OUTPUT.PUT_LINE('(l_count+1) = '||(l_count+1));
  l_sum:=l_sum/(l_count+1);

 RETURN l_sum;
END FOST_AVG;
/
 show err;
 
PROMPT *** Create  grants  FOST_AVG ***
grant EXECUTE                                                                on FOST_AVG        to ABS_ADMIN;
grant EXECUTE                                                                on FOST_AVG        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOST_AVG        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fost_avg.sql =========*** End *** =
 PROMPT ===================================================================================== 
 