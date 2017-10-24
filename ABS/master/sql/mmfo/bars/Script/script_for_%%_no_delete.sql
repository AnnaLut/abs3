DECLARE
/* 
Исправление работы JOB по установке бонуса
Скрипт отбирает записи из int_ratn по тем депозитам у которых было в преиод  01.06.2017 - до даты начисления %%, небыло пролонгации, депозиты в состоянии "открыт"
По ним добавляется запись в таблицу int_ratn с датой = дата начисления%+1 и со ставкой которая была до первой устнановки бонуса
*/

  l_kf          mv_kf.kf%TYPE;
  l_date_insert int_ratn.bdat%TYPE;
  l_int_ratn    int_ratn%ROWTYPE;
  l_date_acr    int_ratn.bdat%TYPE;

  CURSOR c1 IS
    SELECT distinct (j.acc)
      FROM (SELECT a.acc, a.acr_dat
              FROM (SELECT DISTINCT (i.acc)
                      FROM bars.int_ratn i
                     WHERE 1 = 1
                       AND i.IDU = 1
                       AND NOT EXISTS
                     (SELECT c.acc
                              FROM dpt_deposit_clos c
                             WHERE c.acc = i.acc
                               AND (c.action_id = 1 OR c.action_id = 2)
                             GROUP BY c.acc)
                       AND NOT EXISTS
              (SELECT m.acc
                       FROM dpt_deposit_clos m
                      WHERE m.acc = i.acc
                        AND m.action_id = 3
                        AND TRUNC(WHEN) BETWEEN
                            to_date('01.06.2017', 'dd.mm.yyyy') AND
                            to_date('16.06.2017', 'dd.mm.yyyy'))
                       AND i.BDAT BETWEEN to_date('01.06.2017', 'dd.mm.yyyy') AND
                           to_date('16.06.2017', 'dd.mm.yyyy')
                       AND i.id = 1
                       --AND i.acc in (975996011)
                       ) d,
                   bars.Int_accn a,
                   dpt_deposit dd
             WHERE d.acc = a.acc
               and a.acr_dat > to_date('31.05.2017', 'dd.mm.yyyy')
               and a.acc = dd.acc
               ) b,
           bars.int_ratn j
     WHERE b.acc = j.acc
       and j.bdat <= b.acr_dat
       AND j.BDAT BETWEEN to_date('01.06.2017', 'dd.mm.yyyy') AND b.acr_dat
       AND j.idu = 1
       AND j.id = 1
       AND not exists (select w.acc
            from int_ratn w
            where w.acc = j.acc
            and w.bdat between b.acr_dat+1 and  to_date('16.06.2017', 'dd.mm.yyyy')
            AND w.idu = 1
            AND w.id = 1);

  TYPE RecList IS TABLE OF c1%ROWTYPE;
  recs RecList;

BEGIN
  bars_audit.info('START proc check bonus job');

  FOR cur IN (SELECT kf FROM mv_kf)
  
   LOOP
    bc.go(cur.kf);
  
    bars_audit.info('proc check bonus job: Представилась ' ||
                         f_ourmfo);
  
    OPEN c1;
    FETCH c1 BULK COLLECT
      INTO recs;
  
    bars_audit.info('proc check bonus job: Наполнила курсор ');
  
    FOR i IN 1 .. recs.count LOOP
    
      BEGIN
      
        SAVEPOINT sp1;
      
        select b.acr_dat
          into l_date_acr
          from bars.Int_accn b
         where b.acc = recs(i).acc;
      
        bars_audit.info('proc check bonus job: нашла дату нач.%%' ||
                             l_date_acr);
      
        bars_audit.info('proc check bonus job: иду по курсору ' || recs(i).acc || ' ' ||
                             l_date_acr);
      
        l_date_insert := l_date_acr + 1;
        bars_audit.info('proc check bonus job: новая дата установки ставки' ||
                             l_date_insert);
      
        select n.*
          into l_int_ratn
          from bars.int_ratn n
         where n.acc = recs(i).acc
           and n.bdat in (select max(l.bdat)
                            from bars.int_ratn l
                           where l.acc = n.acc
                             and l.idu <> 1);
      
        bars_audit.info('proc check bonus job: запись с которой беру данные для установки ставки' ||
                             l_int_ratn.acc || ' ' || l_int_ratn.id || ' ' ||
                             l_int_ratn.bdat || ' ' || l_int_ratn.ir || ' ' ||
                             l_int_ratn.br || ' ' || l_int_ratn.op || ' ' ||
                             l_int_ratn.idu || ' ' || l_int_ratn.kf);
      
        INSERT INTO bars.int_ratn
          (acc, id, bdat, ir, br, op, idu, kf)
        VALUES
          (recs(i).acc,
           l_int_ratn.id,
           l_date_insert,
           l_int_ratn.ir,
           l_int_ratn.br,
           l_int_ratn.op,
           1,
           l_int_ratn.kf);
      
        bars_audit.info('proc check bonus job: вставили запись в таблицу int_ratn');
      
        INSERT INTO bars.tmp_int_ratn_log
          (acc, id, bdat, ir, br, op, idu, kf, row_id, col, dat)
        VALUES
          (recs(i).acc,
           l_int_ratn.id,
           l_date_insert,
           l_int_ratn.ir,
           l_int_ratn.br,
           l_int_ratn.op,
           1,
           l_int_ratn.kf,
           1,
           'insert',
           sysdate);
      
        bars_audit.info('proc check bonus job: вставили запись в таблицу tmp_int_ratn_log');
      
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK TO sp1;
          bars_audit.info('proc check bonus job: LOOP Error: ' ||recs(i).acc||' '||SQLERRM);
          DBMS_OUTPUT.PUT_LINE ('proc check bonus job: LOOP Error: ' ||recs(i).acc||' '|| SQLERRM);
      
      END;
      --COMMIT;
    
    END LOOP;
  
    CLOSE c1;
    bars_audit.info('proc check bonus job: Закрыла курсор ');
    bc.home;
    bars_audit.info('proc check bonus job: Представилась ' ||
                         nvl(f_ourmfo, '/'));
  
  END LOOP;

  bars_audit.info('END proc check bonus job ' || nvl(f_ourmfo, '/'));
  --bars_audit.info('Proc check bonus job exit');

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Proc check bonus job: Error => ' || SQLERRM);
    bars_audit.info('proc check bonus job: Error ' || SQLERRM);
END;
