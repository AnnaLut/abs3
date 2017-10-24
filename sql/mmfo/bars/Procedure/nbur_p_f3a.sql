

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F3A.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F3A ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F3A (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#3A')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #E2 для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.005  20/03/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.005  20/03/2017';
/*
    Формат коду показника >  L D BBBB P K R JJ VVV N
    
    L    -    сума/процентна ставка     [1,2]
    D    -    може приймати значення:
        5 - дебетові обороти (гривневий еквівалент);
        6 - кредитові обороти (гривневий еквівалент)    [5,6]
    N    -    може приймати значення:
        0 - кредити надані/отримані, депозити розміщені/залучені по операціях з первинними фінансовими інструментами;
        1 - інші кредити надані / інші кредити отримані  по операціях з похідними фінансовими інструментами;
        2 - інші депозити розміщені / інші депозити залучені по операціях з похідними фінансовими інструментами    [0,1,2]

    BBBB    -    балансовий рахунок;
    P    -    розподіл рахунку за визначеним критерієм; 
    K    -    код початкового строку погашення;
    R    -    код резидентності;
    JJ    -    код параметру розподілу суми оборотів; 
    VVV     -    код валюти;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_file_id       number;
    l_fmt           varchar2(20):='999990D0000';
    l_gr_sum_840    number         := 100000; -- гранична сума
    l_kurs_840      number := F_NBUR_RET_KURS (840, p_report_date);
    l_ourOKPO       varchar2(20);
    l_ourGLB        varchar2(20);
    l_last_nnn      number := 0;
BEGIN
    logger.info ('NBUR_P_F3A begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
    
    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);
    
    -- депозитні лінії
    delete from nbur_tmp_kod_r020 where r020 in ('8610','8615','8651','8652');
    insert into nbur_tmp_kod_r020
    select '8610' from  dual 
    union
    select '8615' from  dual 
    union
    select '8651' from  dual 
    union
    select '8652' from  dual;  
    
    l_file_id := 15165;
    
    begin
        select max(decode(glb, 0, '0', lpad(to_char(glb), 3, '0')))
        into l_ourGLB
        from rcukru
        where mfo = p_kod_filii;
    exception
        when no_data_found then
            l_ourGLB := null;
    end;
    
    l_ourOKPO := lpad(F_Get_Params('OKPO',null), 8, '0');
    
   -- формування детального протоколу 
   -- дебетові обороти
   INSERT INTO nbur_detail_protocols (report_date,
                                      kf,
                                      report_code,
                                      nbuc,
                                      field_code,
                                      field_value,
                                      description,
                                      acc_id,
                                      acc_num,
                                      kv,
                                      maturity_date,
                                      cust_id,
                                      REF,
                                      nd,
                                      branch)        
   SELECT report_date,
           kf,
           p_file_code,
           (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
           substr(colname,2,1) || '5' ||
           nbs||r013||s180||k030||d020||ckv||'0' field_code,
           value field_value,
           substr('Part 1 '||nazn, 1, 250) description,
           acc,
           nls,
           kv,
           maturity_date,
           rnk,
           ref,
           NULL nd,
           branch
    from ( select 
                t.report_date, t.kf, t.ref, a.acc_id acc, a.acc_num nls, t.kv, 
                A.NBS, c.cust_id rnk,
                lpad(t.kv, 3, '0') ckv, 
                t.cust_id_db, t.acc_id_db, t.acc_num_db, 
                t.cust_id_cr, t.acc_id_cr, t.acc_num_cr,
                a.r013, a.s180, a.maturity_date, A.BRANCH,
                C.K030, nvl(trim(d.d020), '01') d020, 
                to_char(t.bal_uah) p1, 
                to_char(nvl(G.RATE_VAL, 0), '999990D0000') p2,
                to_char(round(t.bal_uah * nvl(G.RATE_VAL, 0), 4)) p3 ,
                a.nbuc, O.NAZN
            from nbur_dm_transactions t
            join oper o
            on (t.ref = o.ref)
            join nbur_dm_accounts a
            on (a.report_date = p_report_date and
                a.kf = p_kod_filii and
                a.acc_id = t.acc_id_db)
            join nbur_dm_customers c
            on (c.report_date = p_report_date and
                c.kf = p_kod_filii and
                c.cust_id = a.cust_id)        
            join  nbur_tmp_kod_r020 r
            on (t.acc_num_db like r.r020||'%')
            left outer join nbur_dm_adl_doc_rpt_dtl d
            on (d.report_date = p_report_date and
                d.kf = p_kod_filii and
                t.ref = d.ref)
            left outer join NBUR_DM_ACNT_RATES g
            on (g.report_date = p_report_date and
                g.kf = p_kod_filii and
                g.acc_id = a.acc_id and
                g.rate_tp = 0)
            where t.report_date = p_report_date and
                t.kf = p_kod_filii and
                t.acc_num_db NOT LIKE '8%' and
                substr(t.acc_num_db,1,4) not IN ('1500', '1600', '2600', '2605',
                            '2620', '2625', '2650', '2655') and 
                a.pap = '1' and
                substr(t.acc_num_db,1,3) <> substr(t.acc_num_cr,1,3) and
                not (substr(t.acc_num_db,1,3) = '206' and substr(t.acc_num_cr,1,3) = '207') and  
                not (substr(t.acc_num_db,1,3) = '207' and substr(t.acc_num_cr,1,3) = '206') and  
                not (substr(t.acc_num_db,1,3) = '220' and substr(t.acc_num_cr,1,3) = '221') and  
                not (substr(t.acc_num_db,1,3) = '221' and substr(t.acc_num_cr,1,3) = '220') and  
                not (substr(t.acc_num_db,1,3) = '223' and substr(t.acc_num_cr,1,3) = '220') and
                t.tt <> 'NE3' and
                not (t.tt = '024' and 
                     (o.mfoa <> o.mfob or lower(o.nazn) like '%переведення залишку%')) and
                not (substr(t.acc_num_db,1,3) = '220' and substr(t.acc_num_cr,1,4) in ('2909', '3739')) and  
                not (substr(t.acc_num_db,1,3) = '223' and substr(t.acc_num_cr,1,4) in ('2909', '3739')) and
                nvl(trim(d.d020), '00') <> 'ZZ')
                UNPIVOT (VALUE FOR colname IN  (p1, p2, p3));  
   commit;
    
    -- кредиові обороти            
   INSERT /*+ append */ 
   INTO nbur_detail_protocols (report_date,
                                      kf,
                                      report_code,
                                      nbuc,
                                      field_code,
                                      field_value,
                                      description,
                                      acc_id,
                                      acc_num,
                                      kv,
                                      maturity_date,
                                      cust_id,
                                      REF,
                                      nd,
                                      branch)        
    SELECT /*+ parallel(4) */
           report_date,
           kf,
           p_file_code,
           (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
           substr(colname,2,1) || '6' ||
           (case nbs 
            when '8610' then '2610' 
            when '8615' then '2615'
            when '8651' then '2651' 
            when '8652' then '2652'
            else nbs
           end)||r013||s180||k030||d020||ckv||'0' field_code,
           value field_value,
           substr('Part 2 '||nazn, 1, 250) description,
           acc,
           nls,
           kv,
           maturity_date,
           rnk,
           ref,
           NULL nd,
           branch
    from ( select t.report_date, t.kf, t.ref, a.acc_id acc, a.acc_num nls, t.kv, 
                A.NBS, c.cust_id rnk,
                lpad(t.kv, 3, '0') ckv, 
                t.cust_id_db, t.acc_id_db, t.acc_num_db, 
                t.cust_id_cr, t.acc_id_cr, t.acc_num_cr,
                a.r013, a.s180, a.maturity_date, A.BRANCH,
                C.K030, nvl(trim(d.d020), '01') d020, 
                to_char(t.bal_uah) p1, 
                to_char(nvl(G.RATE_VAL, 0), '999990D0000') p2,
                to_char(round(t.bal_uah * nvl(G.RATE_VAL, 0), 4)) p3,
                a.nbuc, o.nazn 
            from nbur_dm_transactions t
            join oper o
              on ( o.kf = t.kf and t.ref = o.ref)
            join  nbur_tmp_kod_r020 r
              on (t.R020_CR = r.r020)
            join nbur_dm_accounts a
              on ( a.kf  = t.kf and a.acc_id  = t.acc_id_cr )
            left outer join nbur_dm_accounts a1
              on ( a1.kf = t.kf and a1.acc_id = t.acc_id_db)
            join nbur_dm_balances_daily b
              on ( b.kf = t.kf and b.acc_id = t.acc_id_cr )
            join nbur_dm_customers c
              on ( c.kf = t.kf and c.cust_id = t.cust_id_cr)        
            left outer 
            join nbur_dm_adl_doc_rpt_dtl d
              on ( d.kf = t.KF and d.ref = t.ref )
            left outer
            join NBUR_DM_ACNT_RATES g
              on ( g.kf = t.kf and g.acc_id = t.acc_id_cr and g.rate_tp = 1)
            where t.report_date = p_report_date 
              and t.kf = p_kod_filii 
              and a.acc_type <> 'NL8'
              and ( b.kos > 0 AND 
                    a.nbs in ('1602','1610','1611','1612','1613',
                    '1620','1621','1622','1623','1624','2514','2525','2546','2610',
                    '2611','2615','2651','2652','8610', '8615', '8651', '8652') and b.ost >= 0 OR
                 b.kos > 0 and a.nbs = '2600' and a.r013 in ('1','7','8','A') OR
                 b.kos > 0 and a.nbs = '2605' and a.r013 in ('1','3') and nvl(G.RATE_VAL, 0) <> 0 OR
                 b.kos > 0 and a.nbs = '2650' and a.r013 in ('1','3','8') or
                 b.kos > 0 and a.nbs = '2655' and a.r013 = '3' OR
                 a.nbs = '2620' and b.ost >= 0 and 
                 a.ob22 in ('14','15','18','23','24','25','26','27') or
                 a.nbs = '2630' and a.ob22 <> '46' and b.ost >= 0 or 
                 a.nbs = '2635' and a.ob22 <> '38' and b.ost >= 0
                 ) and
                lower(o.nazn) not like '%сторно%' and  
                substr(t.acc_num_cr,1,4) <> substr(t.acc_num_db,1,4) and --a.nbs not in ('2600', '2620', '2650') and
                not (a.nbs = '2600' and a1.nbs = '2600' and nvl(a1.r013,'0') not in ('4','6')) and
                not (a.nbs = '2620' and a1.nbs = '2620' and nvl(a1.r013,'0') in ('1','2','3')) and
                not (a.nbs = '2650' and a1.nbs = '2650' and nvl(a1.r013,'0') in ('1','3','8')) and
                not (a.nbs = '2620' and a1.nbs = '2620' and nvl(a1.r013,'0') not in ('1','2','3') and
                     a1.ob22 in ('14','15','18','23','24','25','26','27')) and
                not (t.tt='R01' and o.nlsa like '3739%' and o.mfoa <> o.mfob
                     and o.mfoa in (select mfo from banks where mfou='300465')
                     and o.mfob in (select mfo from banks where mfou='300465')) and
                not (a.nbs like '26%' and a1.nbs = '3739' and 
                     (lower(o.nazn) like '%виправлено помилку%' or
                      lower(o.nazn) like '%м_грац_я%' or
                      lower(o.nazn) like '%перен_с%' or
                      lower(o.nazn) like '%зм_н_%адрес%ф_л__%' or
                      lower(o.nazn) like '%перенесено залишки%' or
                      lower(o.nazn) like '%зачислено%в связи с закрытием%' or
                      lower(o.nazn) like '%в_дкрит%внутр_шн%банк_вс%')) and
                not (a.nbs like '26%' and a1.nbs like '6%') and
                nvl(trim(d.d020), '00') <> 'ZZ' and
                not (a.nbs IN ('2620','2625','2630','2635') and t.tt = 'АСВ') and
                not (t.tt='024' and (o.mfoa <> o.mfob or lower(o.nazn) like '%переведення залишку%')) and
                not (a.nbs in ('1610', '1612', '1615') and a1.nbs = '1618' or
                     a.nbs in ('2546') and a1.nbs = '2548' or
                     a.nbs in ('2600') and a1.nbs = '2608' or
                     a.nbs in ('2610', '2615') and a1.nbs = '2618' or
                     a.nbs in ('2620') and a1.nbs in ('2628','2630','2635','2638','7040') or
                     a.nbs in ('2625') and a1.nbs in ('2202','2203','2924') and a.kf <> '300465' or
                     a.nbs in ('2630', '2635') and 
                     (a1.nbs = '2620' and a1.ob22 in ('14','15','18','23','24','25','26','27') or 
                      a1.nbs like '26_8' or 
                      a1.nbs like '704%' or 
                      a1.nbs like '355%' or
                      a.kf <> '300465' and a1.nbs in ('2630','2635','2909')) or
                     a.nbs in ('2650', '2651', '2652') and a1.nbs = '2658')
                )
                UNPIVOT (VALUE FOR colname IN (p1, p2, p3));    
   commit;
   
    -- овердрафти                
   INSERT INTO nbur_detail_protocols (report_date,
                                      kf,
                                      report_code,
                                      nbuc,
                                      field_code,
                                      field_value,
                                      description,
                                      acc_id,
                                      acc_num,
                                      kv,
                                      maturity_date,
                                      cust_id,
                                      REF,
                                      nd,
                                      branch)        
    SELECT report_date,
           kf,
           p_file_code,
           (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
           substr(colname,2,1) ||
           (case when nbs = '1500' then '6' else '5' end)||
           nbs||r013||s180||k030||d020||ckv||'0' field_code,
           value field_value,
           substr('Part 3 '||nmk, 1, 250) description,
           acc,
           nls,
           kv,
           maturity_date,
           rnk,
           null ref,
           null nd,
           branch
   from (select * 
         from (select b.report_date, b.kf, a.acc_id acc, a.acc_num nls, a.kv, 
                    a.nbs, c.cust_id rnk, lpad(a.kv, 3, '0') ckv, 
                    a.r013, '1' s180, a.maturity_date, A.BRANCH,
                    c.k030, '01' d020, 
                    to_char((case when a.nbs = '1500' 
                                  then 
                                    (case when b.vost < 0 
                                          then abs(b.ostq) 
                                          else abs(b.ostq) - abs(b.vostq)
                                     end)
                                  when a.nbs = '2625' 
                                  then 
                                    (case when b.vost > 0 
                                          then abs(b.ostq + nvl(t.dos, 0))
                                          else abs(b.ostq + nvl(t.dos, 0)) - abs(b.vostq)
                                     end)
                                  else
                                    (case when b.vost > 0 
                                          then abs(b.ostq) 
                                          else abs(b.ostq) - abs(b.vostq)
                                     end)
                              end)) p1, 
                    to_char(nvl(G.RATE_VAL, 0), '999990D0000') p2,
                    to_char(round((case when a.nbs = '1500' 
                                  then 
                                    (case when b.vost < 0 
                                          then abs(b.ostq) 
                                          else abs(b.ostq) - abs(b.vostq)
                                     end)
                                  when a.nbs = '2625' 
                                  then 
                                    (case when b.vost > 0 
                                          then abs(b.ostq + nvl(t.dos, 0))
                                          else abs(b.ostq + nvl(t.dos, 0)) - abs(b.vostq)
                                     end)
                                  else
                                    (case when b.vost > 0 
                                          then abs(b.ostq) 
                                          else abs(b.ostq) - abs(b.vostq)
                                     end)
                              end) * nvl(G.RATE_VAL, 0), 4)) p3, a.nbuc, c.cust_name nmk
                from nbur_dm_balances_daily b
                join nbur_dm_accounts a
                on (a.report_date = p_report_date and
                    a.kf = p_kod_filii and
                    a.acc_id = b.acc_id)
                join nbur_dm_customers c
                on (c.report_date = p_report_date and
                    c.kf = p_kod_filii and
                    c.cust_id = a.cust_id)  
                left outer join NBUR_DM_ACNT_RATES g
                on (g.report_date = p_report_date and
                    g.kf = p_kod_filii and
                    g.acc_id = a.acc_id and
                    g.rate_tp = 0)     
                left outer join (select acc_id_db acc_id, sum(bal_uah) dos
                                 from nbur_dm_transactions 
                                 where report_date = p_report_date and
                                       kf = p_kod_filii and
                                       acc_num_db like '2625%' and
                                       acc_num_cr like '2924%' 
                                 group by acc_id_db) t 
                on (a.nbs = '2625' and b.acc_id = t.acc_id)                    
                where b.report_date = p_report_date and
                      b.kf = p_kod_filii and
                      (a.nbs = '1500' and 
                       (b.vost < 0 AND b.ost > 0 OR 
                        b.ost - b.vost > 0 and  b.ost > 0)
                            OR
                        a.nbs in ('1600','2600','2605','2620','2625','2650','2655') and 
                        (b.vostq > 0 AND b.ostq + nvl(t.dos, 0) < 0 OR 
                         abs(b.ostq + nvl(t.dos, 0)) - abs(b.vostq) > 0 and b.ostq < 0)
                     ) and
                      b.dos + b.kos <> 0 
        ) 
    where p1<>0) 
    UNPIVOT (VALUE FOR colname IN  (p1, p2, p3));    
    commit;
    
--    p_ins_log('---------------------------------------', NULL);
--    p_ins_log('ПЕРЕСЧЕТ % ставок с учетом коммисионных', NULL);
--    p_ins_log('---------------------------------------', NULL);

    -- ПЕРЕСЧЕТ % ставок с учетом коммисионных
--    FOR i IN (SELECT  a.kodp, a.acc acc_, a.nls, a.kv, TO_NUMBER (a.znap) ost, b.znap prc,
--                     (TO_NUMBER (a.znap) * TO_NUMBER (b.znap))/36500 ost_prc, b.recid,
--                     sum(Gl.P_Icurval(a.KV, to_number(TRANSLATE(t.txt,',','.')), Dat_)) kom, 
--                     s.mdate-dat_ term, c.nd nd, c.cc_id,
--                     ABS(Gl.P_Icurval(a.KV, c.LIMIT * 100, Dat_)) s_zd2,
--                     s.mdate
--             FROM RNBU_TRACE a, RNBU_TRACE b, ND_ACC n, CC_DEAL c, ND_TXT t, ACCOUNTS s
--             WHERE SUBSTR (a.kodp, 2) = SUBSTR (b.kodp, 2)
--               AND SUBSTR (a.kodp, 1, 1) = '1'
--               AND SUBSTR (b.kodp, 1, 1) = '2'
--               and nvl(a.nd, 0) <> 1
--               AND a.acc = b.acc
--               AND a.recid = b.recid - 1
--               AND a.odate = b.odate
--               AND a.acc=n.acc
--               AND n.nd=c.nd
--               AND (c.sdate,c.nd)= (SELECT MAX(p.sdate), MAX(p.nd)
--                                    FROM ND_ACC a, CC_DEAL p
--                                    WHERE a.acc=n.acc AND
--                                          a.nd=p.nd AND
--                                          p.sdate<=dat_)
--               AND n.nd=t.nd
--               AND t.tag in ('KDO','S_SDI')
--               and is_number(TRANSLATE(t.txt,',','.')) = 1
--               and c.vidd not in ('26')
--               AND a.acc=s.acc
--             group by a.kodp, a.acc, a.nls, a.kv, TO_NUMBER (a.znap), b.znap,
--                     (TO_NUMBER (a.znap) * TO_NUMBER (b.znap))/36500, b.recid,
--                     s.mdate-dat_, c.nd, c.cc_id,
--                     ABS(Gl.P_Icurval(a.KV, c.LIMIT * 100, Dat_)), s.mdate
--             ORDER BY a.kodp)
--    LOOP
--    ---------------------------------------------------------
--       BEGIN
--          komm_ := TO_NUMBER(i.kom) * 100;
--       EXCEPTION
--                 WHEN OTHERS THEN
--          IF SQLCODE=-6502 THEN
--             komm_ := 0;
--          ELSE
--             RAISE_APPLICATION_ERROR(-20001, 'Помилка: '||SQLERRM);
--          END IF;
--       END;
--
--       -- проверка для траншей: если в первый транш коммисия включена, то дальше - не включать
--       BEGIN
--          SELECT TO_DATE(txt, 'ddmmyyyy')
--             INTO datp_
--          FROM ND_TXT
--          WHERE nd=i.nd AND
--                tag='D_KDO';
--       EXCEPTION
--                 WHEN NO_DATA_FOUND THEN
--          datp_ := NULL;
--       END;
--
--       IF komm_>0 AND NVL(i.term,0)>0 AND NVL(datp_, dat_) = dat_ THEN
--          -- проверка количества ссудных счетов в договоре и общей суммы по договору
--          SELECT COUNT(*), SUM(TO_NUMBER(znap))
--             INTO kolvo_, se_
--          FROM ND_ACC n, RNBU_TRACE r
--          WHERE n.ND=i.nd AND
--                n.acc=r.acc AND
--                SUBSTR(r.KODP,1,1)='1';
--
--          -- если в договоре не один ссудный счет
--          IF kolvo_ > 1 THEN
--             -- распределение пропорционально остаткам
--             komm_ := komm_ * (i.ost / se_);
--          END IF;
--
--          kommr_ := komm_ / i.term;
--
--          if 353575 IN (mfo_,mfou_) THEN
--             b_yea := 365;
--          else
--             -- Визначення базового року (360 чи 365)
--             BEGIN
--                SELECT basey
--                   into basey_
--                FROM int_accN
--                WHERE acc=i.acc_ and
--                      id=0;
--             EXCEPTION
--                       WHEN NO_DATA_FOUND THEN
--                basey_:=0;
--             END;
--
--             IF basey_ in (2, 3, 12) THEN
--                b_yea := 360;
--             ELSE
--                b_yea := 365;
--             END IF;
--          end if;
--
--          if b_yea = 365 and mod(to_number(to_char(Dat_,'YYYY')), 4) = 0 THEN
--             b_yea := 366;
--          end if;
--
--          s_zd2_ := i.s_zd2;
--
--          if i.s_zd2 = 0 or i.s_zd2 < abs(i.ost) then
--             select max(ABS(Gl.P_Icurval(i.KV, LIM2, Dat_)))
--                into s_zd2_
--             from cc_lim
--             where fdat<=Dat_
--               and nd=i.nd
--             group by nd;
--          end if;
--
--          BEGIN
--             cntr_ := ((s_zd2_ * i.prc / (b_yea * 100) + kommr_) / s_zd2_) * b_yea * 100;
--          EXCEPTION
--                    WHEN OTHERS THEN
--             RAISE_APPLICATION_ERROR(-20001, 'рах. '||i.nls||' Реф.дог. '||i.nd||' Помилка: не заповнена сума лiмiту');
--          END;
--
--          -- обновление процентной ставки
--          -- в протоколе
--          UPDATE RNBU_TRACE
--             SET znap = Trim(TO_CHAR (ROUND (cntr_, 4), fmt_))
--          WHERE recid=i.recid;
--
--          -- обновление (остатка*процентную ставку)
--          -- в протоколе
--          UPDATE RNBU_TRACE
--             SET znap = Trim(TO_CHAR (se_*ROUND(cntr_,4)))
--          WHERE nls=i.nls and kv=i.kv and kodp like '3%';
--
--          -- в архиве
--          UPDATE RNBU_HISTORY
--             SET ints=cntr_
--          WHERE nls=i.nls AND
--                kv=i.kv;
--
--          IF datp_ IS NULL THEN
--             -- доп. реквизиты для КД
--             INSERT INTO ND_TXT (nd, tag, txt)
--                          VALUES(i.nd, 'D_KDO', TO_CHAR(dat_, 'ddmmyyyy'));
--          END IF;
--
--          p_ins_log('Cчет '''||i.nls||
--                    '''. Реф КД = '||Trim(TO_CHAR(i.nd))||
--                    '. SK='||Trim(TO_CHAR(i.s_zd2))||
--                    '. Kom='||Trim(TO_CHAR(komm_))||
--                    '. Prc='||Trim(TO_CHAR(i.prc))||
--                    ', PrcN='||LTRIM(TO_CHAR (ROUND (cntr_, 4), fmt_))||
--                    '. Term='||i.term||'.'||
--                    '. BaseY='||to_char(b_yea)||'.', NULL);
--       END IF;
--    END LOOP;
    
    -- формирование показателей файла  в  nbur_agg_protocols
    INSERT INTO nbur_agg_protocols (report_date,
                                    kf,
                                    report_code,
                                    nbuc,
                                    field_code,
                                    field_value)
       SELECT report_date,
              kf,
              report_code,
              nbuc,
              field_code,
              to_char(field_value)
         FROM (  SELECT report_date,
                        kf,
                        report_code,
                        nbuc,
                        field_code,
                        SUM (field_value) field_value
                   FROM nbur_detail_protocols
                  WHERE     report_date = p_report_date
                        AND report_code = p_file_code
                        AND kf = p_kod_filii
                        and field_code like '1%'
                        and substr(field_code, 10, 2) not in ('02', '03') -- без пролонгацій
               GROUP BY report_date,
                        kf,
                        report_code,
                        nbuc,
                        field_code)
            UNION
         SELECT a.report_date,
              a.kf,
              a.report_code,
              a.nbuc,
              '2'||a.field_code,
              trim(to_char(a.field_value/b.field_value, '999990D0000')) field_value
         FROM (  SELECT report_date,
                        kf,
                        report_code,
                        nbuc,
                        substr(field_code, 2) field_code,
                        SUM (field_value) field_value
                   FROM nbur_detail_protocols
                  WHERE     report_date = p_report_date
                        AND report_code = p_file_code
                        AND kf = p_kod_filii
                        and field_code like '3%'
                        and substr(field_code, 10, 2) not in ('02', '03') -- без пролонгацій
               GROUP BY report_date,
                        kf,
                        report_code,
                        nbuc,
                        substr(field_code, 2)) a
         join
         (  SELECT substr(field_code, 2) field_code,
                   SUM (field_value) field_value
            FROM nbur_detail_protocols
                  WHERE     report_date = p_report_date
                        AND report_code = p_file_code
                        AND kf = p_kod_filii
                        and field_code like '1%'
                        and substr(field_code, 10, 2) not in ('02', '03') -- без пролонгацій
               GROUP BY substr(field_code, 2)) b
          on (a.field_code = b.field_code);     
          
    -- нужна вставка в RNBU_HISTORY для совместимости версий после миграции          

    logger.info ('NBUR_P_F3A end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F3A.sql =========*** End **
PROMPT ===================================================================================== 
