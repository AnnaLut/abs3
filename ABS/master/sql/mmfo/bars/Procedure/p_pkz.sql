

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PKZ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PKZ ***

  CREATE OR REPLACE PROCEDURE BARS.P_PKZ ( date_ DATE ) IS
-- процедура выбирает контрагентов-физлиц, у который есть счета обеспечения
-- по БПК, кредитные/внебалансовые счета и их остатоки по состоянию
-- на указанную дату
-- (сделано по заказу Черкас М.М., используется в кат.запросе 629) --
--
-- Макаренко И.В. 09/2009 --
--
  kv_       NUMBER;
  ostatok_  NUMBER;
  cntr_     NUMBER;

BEGIN

  DELETE FROM tmp_pkz;

  FOR i IN (select rnk, nmk
              from customer
             where custtype = 3
               and date_off is null)
  LOOP

    cntr_ := 0;

    FOR j IN (select acc, nls, tip, kv
                from accounts
               where tip = 'PKZ'
                 and dazs is null
                 and rnk = i.rnk )
    LOOP

      SELECT ost INTO ostatok_ FROM sal WHERE acc = j.acc AND fdat = date_;

      IF cntr_ = 0 THEN
        INSERT INTO tmp_pkz (RNK,     FIO,   NLS,   TIP,   KV, OSTATOK)
                     VALUES (i.rnk, i.nmk, j.nls, j.tip, j.kv, ostatok_);
      ELSE
        INSERT INTO tmp_pkz ( RNK, FIO,   NLS,   TIP,   KV, OSTATOK)
                     VALUES (NULL,  '', j.nls, j.tip, j.kv, ostatok_);
      END IF;

      FOR k IN (SELECT acc, nls, kv, tip FROM accounts WHERE rnk = i.rnk AND dazs is null)
      LOOP

        IF substr(k.nls,1,4) = '9129' THEN
          SELECT ost INTO ostatok_ FROM sal WHERE acc = k.acc
                                              AND fdat = date_;
          INSERT INTO tmp_pkz (RNK, FIO,   NLS,   TIP,   KV, OSTATOK)
                       VALUES (NULL, '', k.nls, k.tip, k.kv, ostatok_);
        END IF;

        IF substr(k.nls,1,4) in ('2202','2203') and k.tip = 'SS' THEN
          SELECT ost INTO ostatok_ FROM sal WHERE acc = k.acc
                                              AND fdat = date_;
          INSERT INTO tmp_pkz (RNK, FIO,   NLS,   TIP,   KV, OSTATOK)
                       VALUES (NULL, '', k.nls, k.tip, k.kv, ostatok_);
        END IF;

      END LOOP;

      cntr_ := 99;

    END LOOP;

  END LOOP;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PKZ.sql =========*** End *** ===
PROMPT ===================================================================================== 
