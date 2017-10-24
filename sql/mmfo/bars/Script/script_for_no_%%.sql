DECLARE
/*
»справление работы JOB по установке бонуса
—крипт отбирает записи из int_ratn по тем депозитам у которых небыло в преиод  01.06.2017 - 16.06.2017 ни начислени€ %%, ни пролонгации, депозиты в состо€нии "открыт"
ѕо ним очищаетс€ таблица int_ratn до даты последнего начислени€(май)
*/
  l_kf mv_kf.kf%TYPE;

  CURSOR c1 IS
    SELECT j.acc,
           j.id,
           j.bdat,
           j.ir,
           j.br,
           j.op,
           j.idu,
           j.kf,
           row_number() OVER(PARTITION BY j.acc ORDER BY j.bdat ASC) AS dd
      FROM (SELECT a.acc, a.acr_dat
              FROM (SELECT DISTINCT (i.acc)
                      FROM bars.int_ratn i
                     WHERE 1 = 1
                       AND i.IDU = 1
                       AND NOT EXISTS
                     (SELECT c.acc
                              FROM bars.dpt_deposit_clos c
                             WHERE c.acc = i.acc
                               AND (c.action_id = 1 OR c.action_id = 2)
                             GROUP BY c.acc)
                       AND i.BDAT BETWEEN to_date('01.06.2017', 'dd.mm.yyyy') AND
                           to_date('16.06.2017', 'dd.mm.yyyy')
                       AND i.id = 1
                       --AND i.acc in (54424901, 627306511)
                       ) d,
                   bars.Int_accn a,
                   bars.dpt_deposit dd
             WHERE d.acc = a.acc
               AND a.acr_dat <= to_date('31.05.2017', 'dd.mm.yyyy')
               AND a.acc = dd.acc
               ) b,
           bars.int_ratn j
     WHERE b.acc = j.acc
       AND j.bdat > b.acr_dat
       AND j.idu = 1
       AND j.BDAT BETWEEN to_date('01.06.2017', 'dd.mm.yyyy') AND
           to_date('16.06.2017', 'dd.mm.yyyy')
       AND j.id = 1
     ORDER BY j.acc, j.bdat;

  TYPE RecList IS TABLE OF c1%ROWTYPE;
  recs RecList;

BEGIN
  DBMS_OUTPUT.PUT_LINE('START proc check bonus job');
  
  FOR cur IN (SELECT kf FROM mv_kf)
  
   LOOP
    bc.go(cur.kf);
    bars_audit.info('proc check bonus job: ѕредставилась ' ||
                         f_ourmfo);
  
    OPEN c1;
    FETCH c1 BULK COLLECT
      INTO recs;
  
    bars_audit.info('proc check bonus job: Ќаполнила курсор ');
  
    FOR i IN 1 .. recs.count LOOP
    
      BEGIN    
      
        SAVEPOINT sp1;
      
        bars_audit.info('proc check bonus job: иду по курсору ' || recs(i).acc || ' ' || recs(i).id || ' ' || recs(i).bdat || ' ' || recs(i).ir || ' ' || recs(i).br || ' ' || recs(i).op || ' ' || recs(i).idu || ' ' || recs(i).kf || ' ' || recs(i).dd);
      
        INSERT INTO bars.tmp_int_ratn_log
          (acc, id, bdat, ir, br, op, idu, kf, row_id, col, dat)
        VALUES
          (recs(i).acc,
           recs(i).id,
           recs(i).bdat,
           recs(i).ir,
           recs(i).br,
           recs(i).op,
           recs(i).idu,
           recs(i).kf,
           recs(i).dd,
           'delete',
           sysdate);
      
      bars_audit.info('proc check bonus job: вставили запись в таблицу tmp_int_ratn_log');
      
        DELETE FROM bars.int_ratn r
         WHERE r.acc = recs(i).acc
           AND r.bdat = recs(i).bdat
           AND r.id = recs(i).id
           AND r.idu = recs(i).idu;
           
       bars_audit.info('proc check bonus job: удалили запись из таблицы int_ratn');
     
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK TO sp1;
          bars_audit.info('proc check bonus job: LOOP Error: ' ||recs(i).acc||' '||SQLERRM);
          DBMS_OUTPUT.PUT_LINE ('proc check bonus job: LOOP Error: ' ||recs(i).acc||' '|| SQLERRM);
        
      END;
      --COMMIT;
    
    END LOOP;
  
    CLOSE c1;
    bars_audit.info('proc check bonus job: «акрыла курсор ');
    bc.home;
    bars_audit.info('proc check bonus job: ѕредставилась ' ||
                         nvl(f_ourmfo, '/'));
  
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('END proc check bonus job ' || nvl(f_ourmfo, '/'));

EXCEPTION
  WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('Proc check bonus job: Error => ' || SQLERRM);
    bars_audit.info('proc check bonus job: Error ' || SQLERRM);
END;
