

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SOC_UPD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SOC_UPD ***

CREATE OR REPLACE PROCEDURE BARS.P_SOC_UPD 
IS                   --PROMPT Наполнение сетки асс - дата по пенсионным счетам
   lastdate    DATE;
   startdate   DATE := TO_DATE ('01/06/2015', 'dd/mm/yyyy');
   l_startdate DATE := startdate;
   months      INT;
   l_cnt       INT;
   dos_cnt     INT;
   dos_k       INT;
BEGIN
   SELECT MAX (date1) INTO lastdate FROM dpt_soc_turns;
   bars_audit.info ('dpt_soc_turns.lastdate = ' || TO_CHAR (lastdate, 'dd/mm/yyyy'));
   
   bc.go('/');
   for rec in (select * from mv_kf) loop --rec
     bc.go(rec.kf);

   IF     lastdate IS NOT NULL
      AND lastdate < SYSDATE
      AND MONTHS_BETWEEN (SYSDATE, lastdate) < 1
   THEN
      BEGIN
         INSERT  /*+ append parallel 5 */ INTO dpt_soc_turns
              SELECT DISTINCT acc,
                              fdat,
                              NULL,
                              ostf,
                              dos,
                              kos,
                              NULL,
                              NULL,
                              NULL,
                              NULL,
                              null
                FROM saldoa o
               WHERE EXISTS
                        (SELECT 1
                           FROM accounts
                          WHERE     nbs = '2620'
                                AND ob22 IN ('20', '21')
                                AND dazs IS NULL
                                AND acc = o.acc)
                     AND fdat BETWEEN lastdate + 1 AND SYSDATE;
         COMMIT;
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            NULL;
      END;
   ELSE
      IF lastdate IS NULL
      THEN
        BEGIN -- добавлю все, что без оборотов давно, но по правилам подходит
            INSERT  /*+ append parallel 5 */ INTO dpt_soc_turns
                SELECT DISTINCT acc,
                              l_startdate,
                              NULL,
                              fost(acc,l_startdate),
                              0,
                              0,
                              NULL,
                              NULL,
                              fost(acc,l_startdate),
                              NULL,
                              0
                FROM saldoa o
               WHERE EXISTS
                        (SELECT 1
                           FROM accounts a
                          WHERE     a.nbs = '2620'
                                AND a.ob22 IN ('20', '21')
                                AND a.dazs IS NULL
                                AND a.acc = o.acc
                                and not exists (select 1 from dpt_soc_turns where acc = a.acc));
        EXCEPTION WHEN OTHERS THEN NULL;
        END;
        COMMIT;
        END IF;
            IF MONTHS_BETWEEN (SYSDATE, lastdate) >= 1 OR lastdate IS NULL
              THEN
                 startdate := nvl(lastdate, to_date('01/06/2015','dd/mm/yyyy')) + 1;
                 months := MONTHS_BETWEEN (SYSDATE, startdate);
                 BARS_AUDIT.INFO (
                    'dpt_soc_turns.lastdate = not found/ start from '
                    || TO_CHAR (startdate, 'dd/mm/yyyy'));

                 FOR i IN 1 .. months + 1
                 LOOP
                    BEGIN
                       INSERT  /*+ append parallel 5 */ INTO dpt_soc_turns
                            SELECT DISTINCT acc,
                                            fdat,
                                            NULL,
                                            ostf,
                                            dos,
                                            kos,
                                            NULL,
                                            NULL,
                                            NULL,
                                            NULL,
                                            null
                              FROM saldoa o
                             WHERE EXISTS
                                      (SELECT 1
                                         FROM accounts
                                        WHERE     nbs = '2620'
                                              AND ob22 IN ('20', '21')
                                              AND dazs IS NULL
                                              AND acc = o.acc)
                                   AND fdat BETWEEN startdate
                                                AND ADD_MONTHS (startdate, 1) - 1;

                       COMMIT;
                    EXCEPTION
                       WHEN DUP_VAL_ON_INDEX
                       THEN
                          NULL;
                    END;

                    startdate := ADD_MONTHS (startdate, 1);
                 END LOOP;
             END IF;

   END IF;

   BEGIN
      MERGE INTO dpt_soc_turns t1
           USING (SELECT a.acc,
                         a.date1,
                         LEAD (date1) OVER (PARTITION BY acc ORDER BY date1)
                            date2
                    FROM dpt_soc_turns a) t2
              ON (t1.acc = t2.acc AND t1.date1 = t2.date1)
      WHEN MATCHED
      THEN
         UPDATE SET t1.date2 = t2.date2
                 WHERE t1.date2 IS NULL;

      COMMIT;
   END;


  p_dpt_soc_dos(lastdate);

  if lastdate is null
  then
      -- соц-остаток
    MERGE INTO dpt_soc_turns t1
         USING (SELECT t.acc,
                       date1,
                       date2,ost_real,
                       ost_real + kos_real - dos_real fost,
                       --fost(t.acc, l_startdate)
                       kos_social - dos_real
                       + NVL ( LAG (ost_social) OVER (PARTITION BY acc ORDER BY date1),0) soc
                  FROM BARS.DPT_SOC_TURNS t
                 WHERE date1 = (SELECT MIN (date1)
                                  FROM BARS.DPT_SOC_TURNS
                                 WHERE acc = t.acc and ost_social is null)) t2
            ON (t1.acc = t2.acc AND t1.date1 = t2.date1)
    WHEN MATCHED
    THEN
       UPDATE SET t1.ost_social = t2.soc + t1.ost_real, -- если входящий остаток считать социальным
                  t1.ost_for_tax = (t2.fost) - (t2.soc + t1.ost_real);
    COMMIT;
   end if;

   BEGIN
   WHILE 1 = 1
   LOOP
      MERGE INTO dpt_soc_turns t1
           USING (SELECT t.acc,
                         date1,
                         date2,
                         ost_real + kos_real - dos_real fost,
                         ost_social,
                         kos_social,
                         dos_real,
                         NVL (LAG (ost_social) OVER (PARTITION BY acc ORDER BY date1),0) soc_prev,
                         kos_social - dos_real
                        + NVL ( LAG (ost_social) OVER (PARTITION BY acc ORDER BY date1),0) soc
                    FROM BARS.DPT_SOC_TURNS t
                   WHERE date1 >=
                                (SELECT MIN (date1)
                                   FROM BARS.DPT_SOC_TURNS
                                  WHERE acc = t.acc AND ost_social IS NOT NULL)
                                  ) t2
              ON (t1.acc = t2.acc AND t1.date1 = t2.date1)
      WHEN MATCHED
      THEN
         UPDATE SET
            t1.ost_social = CASE WHEN t2.soc > 0 THEN t2.soc else 0 end,
            t1.ost_for_tax =
               CASE WHEN t2.soc > 0 THEN t2.fost - t2.soc ELSE t2.fost END
         where  t1.ost_social is null and t1.date1=
                                (SELECT MIN (date1)
                                   FROM BARS.DPT_SOC_TURNS
                                  WHERE acc = t1.acc AND ost_social IS NULL);
     bars_audit.trace(to_char(SQL%ROWCOUNT));
      IF SQL%ROWCOUNT = 0
      THEN
         return;
      else COMMIT;
      END IF;

   END LOOP;
END;
  end loop; --rec
  
  bc.home;

END p_soc_upd;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SOC_UPD.sql =========*** End ***
PROMPT ===================================================================================== 
