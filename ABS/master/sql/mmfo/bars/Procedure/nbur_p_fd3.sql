

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FD3.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_FD3 ***

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FD3 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#D3')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #D3 для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.018  10.11.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := ' v.16.018  10.11.2017';
/*
   Структура показника DD NNN

  DD    -   може приймати значення:
    10 - код валюти
    20 - сума валюти
    31 - код ЄДРПОУ юридичної особи/iдентифiкацiйний номер ДРФО фізичної особи/код банку
    35 - код резидентностi
    40 - код мети продажу валюти
    99 - відомості про операцію

   NNN    -    умовний порядковий номер операції (купівлі безготівкової іноземної валюти) у межах звітного дня.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_file_id       number;
    l_fmt           varchar2(20):='999990D0000';
    l_gr_sum_840    number         := 0; -- гранична сума
    l_gr_sum_980    number; -- гранична сума    
    l_kurs_840      number := F_NBUR_RET_KURS (840, p_report_date);
    l_max_nnn       number;
BEGIN
    logger.info ('NBUR_P_FD3 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

    l_file_id := 16851;

    if p_report_date <= to_date('31052017','ddmmyyyy') then
       l_gr_sum_840 := 100000;
    else 
       l_gr_sum_840 := 100; 
    end if;

    l_gr_sum_980 := gl.p_icurval(840, 100000, p_report_date);
      
    BEGIN
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
        SELECT d.report_date,
               d.kf,
               p_file_code,
               (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
               substr(d.colname,2,2)||lpad(d.nnn, 3, '0') field_code,
               d.value field_value,
               NULL description,
               d.acc_id,
               d.acc_num,
               d.kv,
               null maturity_date,
               d.cust_id,
               ref,
               NULL nd,
               branch
        FROM (select * from (
        select report_date, kf, ref, kv, cust_id, acc_id, acc_num,  
                     lpad((dense_rank() 
                           over 
                             (order by nbuc, (case when flag_kons = 0 then to_char(ref) else p10||(case when p31 = '006' then p31 else '0' end) end) )
                           ), 3, '0') nnn,
                     p10, 
                     p20, 
                     (case when flag_kons = 0 then p31 else (case when p31 = '006' then p31 else '0' end) end) p31, 
                     (case when flag_kons = 0 then p35 else '0' end) p35, 
                     (case when flag_kons = 0 then p42 else '01' end) p42, 
                     (case when flag_kons = 0 then p40 else '00' end) p40, 
                     (case when flag_kons = 0 then p99 else 'консолідація' end) p99, 
                     nbuc, branch
        from (select a.report_date, a.kf, a.ref, a.cust_id, a.acc_id, a.acc_num, a.kv, 
                     a.p10, a.p20, a.p31, a.p35, a.p40, a.p42, nvl(trim(nvl(b.p99, a.p99)), ' ') p99, 
                     nbuc, branch, flag_kons
              from
                (select /*+ ordered */
                    t.report_date, t.kf, t.ref,
                    c.cust_id, t.acc_id_db acc_id, t.acc_num_db acc_num, t.kv,
                    lpad(t.kv, 3, '0') P10,
                    TO_CHAR (ROUND (t.bal /  (F_NBUR_Ret_Dig(t.kv, t.report_date) * 100), 0)) P20,
                    (case when c.k030 = '1' and length(trim(c.cust_code))<=8
                            then lpad(trim(c.cust_code), 8,'0')
                          when c.k030 = '1' and
                               lpad(trim(c.cust_code), 10,'0') in
                                ('99999','999999999','00000','000000000','0000000000')
                            then ''
                          when c.k030 = '1' and length(trim(c.cust_code)) > 8
                            then lpad(trim(c.cust_code), 10,'0')
                          when c.k030 = '2'
                            then '0'
                          else
                            '0'
                    end) P31,
                    c.K030  P35,
                    '01' as P42,
                    nvl (lpad (nvl(trim (substr (p.d1#D3 , 1, 2)), 
                                   f_nbur_get_meta(t.ref, p_report_date, t.cust_id_db, t.bal, t.kv)), 2, '0'), 
                         (case when o.tt like 'OW%' then '16'
                               when substr(t.acc_num_db,1,4) in ('2610', '2615', '2630', '2635', '2525', '2546') and
                                    t.acc_num_cr like '3800%' 
                               then '38' 
                               when t.acc_num_db like '2900205%' and t.acc_num_cr like '29003%' or
                                    T.acc_num_db like '2625%' and t.acc_num_cr like '2900%' 
                               then '16'  
                               when lower(o.nazn) like '%обов_язков%продаж%' or
                                    lower(o.nazn) like '%продаж%вируч%' or
                                    lower(o.nazn) like '%в_льн%продаж%' or
                                    lower(o.nazn) like '%валют%продаж%заяв%' or
                                    lower(o.nazn) like '%перерах%продаж%мвру%' or
                                    lower(o.nazn) like '%зарах%валют%продаж%' 
                               then '11'   
                               else '16' end)) P40,
                    (case when trim(DD#70) is not null
                            then trim(DD#70)
                          else 
                            null
                    end) P99, 
                    b.nbuc, b.branch,  (case when t.bal_uah > l_gr_sum_980 then 0 else 1 end) flag_kons
                from NBUR_REF_SEL_TRANS r
                join NBUR_DM_TRANSACTIONS t
                on (t.acc_num_db like r.acc_num_db||'%' and t.ob22_db = nvl(r.ob22_db, t.ob22_db) and
                    t.acc_num_cr like r.acc_num_cr||'%' and t.ob22_cr = nvl(r.ob22_cr, t.ob22_cr) and
                    t.kf = nvl(r.mfo, t.kf) and
                    nvl(r.pr_del, 0) = 0 )
                left outer join NBUR_DM_ADL_DOC_RPT_DTL p
                on (p.report_date = p_report_date and
                    p.kf = p_kod_filii and
                    t.ref = p.ref)
                join oper o
                on (t.ref = o.ref)
                left outer join operw k
                on (t.ref = k.ref and
                    k.tag = 'OW_AM')
                join NBUR_DM_CUSTOMERS c
                on (c.report_date = p_report_date and
                    c.kf = p_kod_filii and
                    t.cust_id_db = c.cust_id)
                left outer join NBUR_DM_ACCOUNTS b
                on (b.report_date = p_report_date and
                    b.kf = p_kod_filii and
                    b.acc_id = t.acc_id_db)
                where t.report_date = p_report_date and
                    t.kf = p_kod_filii and
                    t.kv not in (959, 961, 962, 964, 980) and
                    r.file_id = l_file_id and
                    nvl(r.pr_del, 0) <> 1 and
                    (t.acc_num_cr not like '3739%'
                         or
                     t.acc_num_cr like '3739%' and
                     lower(o.nazn) like '%перерах%кошт_в%продаж%') and
                     lower(trim(o.nazn)) not like '%перерах%кошт_в%обов%продаж%не%зд_йснюв%цтл%' and
                     lower(trim(o.nazn)) not like '%конверс%' and
                     lower(trim(o.nazn)) not like '%конверт%' and
                     lower(trim(o.nazn)) not like '%куп_вля%' and
                     not (t.acc_num_db like '2625%' and t.acc_num_cr like '2924%' and lower(o.nazn) not like '%продаж%валют%') and
                     t.ref not in (select ref from NBUR_TMP_DEL_70 where kodf = l_file_code and datf = p_report_date) and
                     not (o.tt like 'OW%' and trim(k.value) is not null and instr(k.value, '/980')=0) 
                order by c.cust_id, t.ref) a
                left outer join (select p40, DECODE(substr(lower(txt),1,13), 'продано вир.в', 'продаж валютної виручки',txt) p99
                                 from kod_d3_1) b 
                on (a.p40 = b.p40)  
                ---------------------------------------------------------------
                    union all
                ---------------------------------------------------------------
                select a.report_date, a.kf, a.ref, a.cust_id, a.acc_id, a.acc_num, a.kv, 
                     a.p10, a.p20, a.p31, a.p35, a.p40, a.p42, nvl(trim(nvl(b.p99, a.p99)), ' ') p99, 
                     nbuc, branch, flag_kons
              from (select /*+ ordered */
                    t.report_date, t.kf, t.ref,
                    c.cust_id, t.acc_id_db acc_id, t.acc_num_db acc_num, t.kv,
                    lpad(t.kv, 3, '0') P10,
                    TO_CHAR (ROUND (t.bal /  (F_NBUR_Ret_Dig(t.kv, t.report_date) * 100), 0)) P20,
                    (case when c.k030 = '1' and length(trim(c.cust_code))<=8
                            then lpad(trim(c.cust_code), 8,'0')
                          when c.k030 = '1' and
                               lpad(trim(c.cust_code), 10,'0') in
                                ('99999','999999999','00000','000000000','0000000000')
                            then ''
                          when c.k030 = '1' and length(trim(c.cust_code)) > 8
                            then lpad(trim(c.cust_code), 10,'0')
                          when c.k030 = '2'
                            then '0'
                          else
                            '0'
                    end) P31,
                    c.K030  P35,
                    '01' as P42,
                    nvl (lpad (nvl(trim (substr (p.d1#D3 , 1, 2)), f_nbur_get_meta(t.ref, p_report_date, t.cust_id_db, t.bal, t.kv)), 2, '0'), 
                         (case when o.tt like 'OW%' then '16'
                               when substr(t.acc_num_db,1,4) in ('2610', '2615', '2630', '2635', '2525', '2546') and
                                    t.acc_num_cr like '3800%' 
                               then '38' 
                               when t.acc_num_db like '2900205%' and t.acc_num_cr like '29003%' or
                                    T.acc_num_db like '2625%' and t.acc_num_cr like '2900%' 
                               then '16'  
                               when lower(o.nazn) like '%обов_язков%продаж%' or
                                    lower(o.nazn) like '%продаж%вируч%' or
                                    lower(o.nazn) like '%в_льн%продаж%' or
                                    lower(o.nazn) like '%валют%продаж%заяв%' or
                                    lower(o.nazn) like '%перерах%продаж%мвру%' or
                                    lower(o.nazn) like '%зарах%валют%продаж%' 
                               then '11'   
                               else '16' end)) P40,
                    (case when trim(DD#70) is not null
                            then trim(DD#70)
                          else 
                            null
                    end) P99, 
                    b.nbuc, b.branch,  (case when t.bal_uah > l_gr_sum_980 then 0 else 1 end) flag_kons
                from NBUR_TMP_INS_70 r
                join NBUR_DM_TRANSACTIONS t
                on (t.report_date = r.datf and
                    t.kf = r.kf and
                    t.ref = r.ref and
                    r.kodf = l_file_code)
                left outer join NBUR_DM_ADL_DOC_RPT_DTL p
                on (p.report_date = p_report_date and
                    p.kf = p_kod_filii and
                    t.ref = p.ref)
                join oper o
                on (t.ref = o.ref)
                left outer join operw k
                on (t.ref = k.ref and
                    k.tag = 'OW_AM')
                join NBUR_DM_CUSTOMERS c
                on (c.report_date = p_report_date and
                    c.kf = p_kod_filii and
                    t.cust_id_db = c.cust_id)
                left outer join NBUR_DM_ACCOUNTS b
                on (b.report_date = p_report_date and
                    b.kf = p_kod_filii and
                    b.acc_id = t.acc_id_db)
                where t.report_date = p_report_date and
                    t.kf = p_kod_filii and
                    t.kv not in (959, 961, 962, 964, 980) and
                    (t.acc_num_cr not like '3739%'
                         or
                     t.acc_num_cr like '3739%' and
                     lower(o.nazn) like '%перерах%кошт_в%продаж%') and
                     lower(trim(o.nazn)) not like '%перерах%кошт_в%обов%продаж%не%зд_йснюв%цтл%' and
                     lower(trim(o.nazn)) not like '%конверс%' and
                     lower(trim(o.nazn)) not like '%конверт%' and
                     lower(trim(o.nazn)) not like '%куп_вля%' and
                     not (t.acc_num_db like '2625%' and t.acc_num_cr like '2924%' and lower(o.nazn) not like '%продаж%валют%') and
                     t.ref not in (select ref from NBUR_TMP_DEL_70 where kodf = l_file_code and datf = p_report_date) and
                     not (o.tt like 'OW%' and trim(k.value) is not null and instr(k.value, '/980')=0) 
                order by c.cust_id, t.ref) a
                left outer join (select p40, DECODE(substr(lower(txt),1,13), 'продано вир.в', 'продаж валютної виручки',txt) p99
                                 from kod_d3_1) b 
                on (a.p40 = b.p40)                  
                ) )              
                UNPIVOT (VALUE FOR colname IN  (p10, p20, p31, p35, p40, p42, p99))
            ) d;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_FD3 error: '
             || SQLERRM
             || ' for date = '
             || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;
    
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
              to_char(sum(to_number(field_value))) 
         FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii
            and field_code like '20%'
      group by report_date,
               kf,
               report_code,
               nbuc,
               field_code;
    commit;

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
              max(field_value)
         FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii
            and field_code not like '20%'
      group by report_date,
               kf,
               report_code,
               nbuc,
               field_code;
    commit;
    
    -- додаємо в кінець вже заповненого файлу
    select nvl(max(to_number(substr(field_code, 3, 3))), 0)
    into l_max_nnn
    from nbur_agg_protocols
    WHERE     report_date = p_report_date
          AND report_code = p_file_code
          AND kf = p_kod_filii;

    -- блок по казначейству, що заповнюється на основі довідників
    INSERT INTO nbur_agg_protocols (report_date,
                                    kf,
                                    report_code,
                                    nbuc,
                                    field_code,
                                    field_value)
    select report_date,
           kf,
           p_file_code,
           l_nbuc,
           field_code,
           field_value
    from (select c.report_date, c.kf,
                   substr(c.colname, 2, 3)||c.nnn field_code,
                   c.value field_value
            from (select REPORT_DATE, KF,
                         lpad(VAR_10, 3, '0') P10,
                         to_char(round(VAR_20, 0)) P20,
                         nvl(VAR_40, '00') P40,
                         nvl(VAR_42, '00') P42,
                         lpad(rownum + l_max_nnn, 3, '0') nnn
            from NBUR_KOR_DATA_FD3
            where report_date = p_report_date and
                  kf = p_kod_filii)
            UNPIVOT (VALUE FOR colname IN (P10, P20, P40, P42)) c
            union all
          select p_report_date, a.kf, a.code_var||b.nnn, a.value
            from NBUR_KOR_DEFAULT a,
                 (select lpad(rownum + l_max_nnn, 3, '0') nnn
                  from NBUR_KOR_DATA_FD3
                  where report_date = p_report_date and
                        kf = p_kod_filii) b
            where a.report_code = p_file_code and
                a.kf = p_kod_filii);

      -- вставка даних для функції довведення допреквізитів            
      DELETE FROM OTCN_TRACE_70 WHERE kodf = l_file_code and datf = p_report_date and kf = p_kod_filii;

      insert into OTCN_TRACE_70(KODF, DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
      select l_file_code, p_report_date, USER_ID, ACC_NUM, KV, p_report_date, FIELD_CODE, FIELD_VALUE, NBUC, null ISP, 
             CUST_ID, ACC_ID, REF, DESCRIPTION, ND, MATURITY_DATE, BRANCH
      FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii;
            
    logger.info ('NBUR_P_FD3 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FD3.sql =========*** End **
PROMPT ===================================================================================== 
