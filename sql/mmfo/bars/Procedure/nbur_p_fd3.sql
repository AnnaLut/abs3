

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
% VERSION     :  v.16.007  17.03.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := ' v.16.007  17.03.2017';
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
    l_gr_sum_840    number         := 100000; -- гранична сума
    l_kurs_840      number := F_NBUR_RET_KURS (840, p_report_date);
    l_max_nnn       number;
BEGIN
    logger.info ('NBUR_P_FD3 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

    l_file_id := 16851;

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
               l_nbuc nbuc,
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
               null branch
        FROM (select *
              from
                (select t.report_date, t.kf, t.ref,
                    c.cust_id, t.acc_id_db acc_id, t.acc_num_db acc_num, t.kv,
                    lpad((dense_rank() over (order by c.cust_id, t.ref)), 3, '0') nnn,
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
                    nvl (lpad (nvl(trim (substr (p.d1#D3 , 1, 2)), trim(z.meta)), 2, '0'), 
                         (case when o.tt like 'OW%' then '16'
                               when substr(t.acc_num_db,1,4) in ('2610', '2615', '2630', '2635', '2525', '2546') and
                                    t.acc_num_cr like '3800%' then '38'  
                               else '00' end)) P40,
                    (case when trim(DD#70) is not null
                            then trim(DD#70)
                          when o.tt like 'OW%'
                            then 'Продано з iншою метою'
                          else 
                            nvl(DECODE(substr(lower(d.txt),1,13), 'продано вир.в', 'продаж валютної виручки', d.txt), ' ')
                    end) P99
                from NBUR_DM_TRANSACTIONS t
                join NBUR_REF_SEL_TRANS r
                on (t.acc_num_db like r.acc_num_db||'%' and
                    t.acc_num_cr like r.acc_num_cr||'%')
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
                left outer join ZAYAVKA z
                on (t.ref = z.ref and
                    z.dk = 2)
                left outer join (select *
                                 from kod_d3_1
                                 where data_o <= p_report_date and
                                       (data_c is null or
                                        data_o > p_report_date)) d
                on (nvl (lpad (nvl(trim (substr (p.d1#D3 , 1, 2)), trim(z.meta)), 2, '0'), 
                         (case when o.tt like 'OW%' then '16'
                               when substr(t.acc_num_db,1,4) in ('2610', '2615', '2630', '2635', '2525', '2546') and
                                    t.acc_num_cr like '3800%' then '38'  
                               else '00' end)) = d.p40)
                where t.report_date = p_report_date and
                    t.kf = p_kod_filii and
                    t.kv not in (959, 961, 962, 964, 980) and
                    r.file_id = l_file_id and
                    gl.p_ncurval(840, t.bal_uah, t.report_date) > l_gr_sum_840 and
                    (t.acc_num_cr not like '3739%'
                         or
                     t.acc_num_cr like '3739%' and
                     lower(o.nazn) like '%перерах%кошт_в%продаж%') and
                     lower(trim(o.nazn)) not like '%конверс%' and
                     lower(trim(o.nazn)) not like '%конверт%' and
                     lower(trim(o.nazn)) not like '%куп_вля%' and
                     t.ref not in (select ref from NBUR_TMP_DEL_70 where kodf = l_file_code and datf = p_report_date) and
                     not (o.tt like 'OW%' and trim(k.value) is not null and instr(k.value, '/980')=0)
                order by c.cust_id, t.ref)
                UNPIVOT (VALUE FOR colname IN  (p10, p20, p31, p35, p40, p99))
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
              field_value
         FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii;

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
                         VAR_40 P40,
                         lpad(rownum + l_max_nnn, 3, '0') nnn
            from NBUR_KOR_DATA_FD3
            where report_date = p_report_date and
                  kf = p_kod_filii)
            UNPIVOT (VALUE FOR colname IN (P10, P20, P40)) c
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
