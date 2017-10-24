
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostv_avg.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTV_AVG (p_acc NUMBER, p_dat1 DATE, p_dat2 DATE) RETURN NUMBER IS
-- Повертає середньо - арифметичний залишов в номіналі по рахунку за період (календарних днів)
-- За кожний день періоду береться залишок в номіналі на кінець дня. Всі ці залишки додаються і
-- діляться на кількість днів періоду. Результат заокруглюється до цілих копійок.
-- Дата останніх змін - 04.12.2012
  l_sum   NUMBER;
  l_count NUMBER;

  l_ostc   number;
  l_dapp   date;

  DAT      DATE;
  CURSOR CUR1 IS
    SELECT * FROM SALDOA WHERE ACC=p_acc AND FDAT>=p_dat1 ORDER BY FDAT DESC;

  REC CUR1%ROWTYPE;
BEGIN
  IF p_dat1 > p_dat2 THEN RETURN 0; END IF;

  -- получим текущий остаток и дату последнего движения
  select ostc,   dapp
  into   l_ostc, l_dapp
  from accounts where acc = p_acc;
  -- если дата последнего движения меньше заданного периода, возвращаем остаток
  if l_dapp < p_dat1 then
    return l_ostc;
  end if;

  l_sum := 0;
  l_count := 0;

  DAT := p_dat2;
  OPEN CUR1;
  FETCH CUR1 INTO REC;
  WHILE (CUR1%FOUND) LOOP
    IF REC.FDAT > p_dat2 THEN
      l_ostc := l_ostc - (REC.KOS - REC.DOS);
    ELSE
      WHILE DAT >= REC.FDAT LOOP
        l_sum := l_sum + l_ostc;
        l_count := l_count + 1;
        DAT := DAT - 1;
      END LOOP;
      l_ostc := l_ostc - (REC.KOS - REC.DOS);
    END IF;
    FETCH CUR1 INTO REC;
  END LOOP;
  WHILE DAT >= p_dat1 LOOP
    l_sum := l_sum + l_ostc;
    l_count := l_count + 1;
    DAT := DAT - 1;
  END LOOP;

  RETURN ROUND(l_sum/l_count);
END FOSTV_AVG;
/
 show err;
 
PROMPT *** Create  grants  FOSTV_AVG ***
grant EXECUTE                                                                on FOSTV_AVG       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOSTV_AVG       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostv_avg.sql =========*** End *** 
 PROMPT ===================================================================================== 
 