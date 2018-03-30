

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_I39.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_I39 ***

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_I39 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '@39')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #39 для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.0087  29.03.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.0087  29.03.2018';
/*
   Структура показника  L DDD VVV

   L    -    може приймати значення:
    1 - сума
    4 - курс

   DDD    -    може приймати значення:
    210 - купівля готівкової валюти
    220 - продаж готівкової валюти

   VVV    -    код валюти;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_fmt           varchar2(20):='999990D0000';
BEGIN
    logger.info ('NBUR_P_I39 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

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
               substr(d.colname,2,1) ||
               d.type_op ||
               lpad(d.kv, 3, '0') field_code,
               (case when substr(d.colname,2,1) = '4'
                        then trim(to_char(d.value, l_fmt))
                     else to_char(d.value)
                end) field_value,
               NULL description,
               d.acc_id,
               d.acc_num,
               d.kv,
               null maturity_date,
               d.cust_id,
               ref,
               NULL nd,
               branch
        FROM (select  report_date, kf, ref, tt, cust_id, acc_id, acc_num,
                        cust_id2, acc_id2, acc_num2,
                        kv, type_op ,
                        bal s1,
                        bal * round(kurs * div, 4) / dig s3,
                        kurs * div s4, nbuc, branch
                from (select a.report_date, a.kf, a.ref, a.tt, a.cust_id, a.acc_id, a.acc_num,
                        a.cust_id2, a.acc_id2, a.acc_num2,
                        a.kv, a.bal, a.bal_uah,
                        (case when a.kurs is not null
                              then (case when is_number(a.kurs) = 1 then to_number(a.kurs) else null end)
                              else (case when nvl(a.bal, 0) <> 0 and nvl(a.bal_uah_cent, 0) <> 0
                                         then a.bal_uah_cent / a.bal
                                         else null
                                    end)
                        end) kurs,
                        (case when a.dk = 0
                                then
                                   (case substr(nvl(nvl(substr(trim(d.value),1,2),
                                                    to_char(c.type_)), '14'),
                                                1,1)
                                        when '2' then '410'
                                        when '3' then '510'
                                        when '4' then (case when NVL(c.cena_nomi,0) <> 0
                                                        then '610'
                                                        else '410'
                                                       end)
                                        else '310'
                                   end)
                              else
                                  (case substr(nvl(nvl(substr(trim(d.value),1,2),
                                                    to_char(c.type_)), '14'),
                                                1,1)
                                        when '2' then '420'
                                        when '3' then '520'
                                        when '4' then (case when NVL(c.cena_nomi,0) <> 0
                                                        then '620'
                                                        else '420'
                                                       end)
                                        else '320'
                                  end)
                        end) type_op,
                        F_NBUR_Ret_Dig(a.kv, a.report_date) dig,
                        F_NBUR_Ret_DiV(a.kv, a.report_date) div,
                        s.branch, s.nbuc
                    from
                       (select t.report_date, t.kf, t.ref, t.tt,
                               (case when t.acc_num_db like '110%' then t.cust_id_db else t.cust_id_cr end) cust_id,
                               (case when t.acc_num_db like '110%' then t.acc_id_db else t.acc_id_cr end) acc_id,
                               (case when t.acc_num_db like '110%' then t.acc_num_db else t.acc_num_cr end) acc_num,
                               (case when t.acc_num_db like '110%' then t.cust_id_cr else t.cust_id_db end) cust_id2,
                               (case when t.acc_num_db like '110%' then t.acc_id_cr else t.acc_id_db end) acc_id2,
                               (case when t.acc_num_db like '110%' then t.acc_num_cr else t.acc_num_db end) acc_num2,
                               t.kv, t.bal, t.bal_uah,
                               (case when p.kv != p.kv2 and p.kv != 980 and p.kv2 != 980
                                     then null
                                     else trim(w.value)
                               end) kurs,
                               (case when (p.kv != p.kv2 and p.kv != 980 and p.kv2 != 980) or
                                           p.tt <> t.tt
                                     then F_NBUR_D3801(p.ref,t.tt,v.ACC3801,
                                        (case when t.acc_num_db like '110%' then 0 else 1 end),
                                        v.ACC_RRD,v.ACC_RRR, p_report_date, p_kod_filii)
                                     else decode(p.kv2,t.kv,p.s,p.s2)
                               end) bal_uah_cent,
                               (case when t.acc_num_db like '110%' then 0 else 1 end) dk,
                               p.nlsa, p.nlsb, p.kv kvo, p.kv2, p.s, p.s2
                        from NBUR_DM_TRANSACTIONS t, vp_list v, oper p, operw w
                        where t.report_date = p_report_date and
                            t.kf = p_kod_filii and
                            t.tt not in ('BAK', 'TOU') and
                            t.kv in (959,961,962,964) and
                            (t.acc_id_db = v.acc3800 and
                             t.acc_num_cr like '110%' and
                             t.acc_num_cr <>'110169160199'
                              or
                             t.acc_id_cr = v.acc3800 and
                             t.acc_num_db like '110%' and
                             t.acc_num_db <>'110169160199') and
                            t.ref = p.ref and
                            p.sos = 5 and
                            not ((p.nlsa like '1101%'  and
                                  (p.nlsb like '3902%' or
                                   p.nlsb like '3903%' or
                                   p.nlsb like '3906%' or
                                   p.nlsb like '3907%')
                                  ) OR
                                  ((p.nlsa like '3902%' or
                                    p.nlsa like '3903%' or
                                    p.nlsa like '3906%' or
                                    p.nlsa like '3907%') and
                                   p.nlsb like '1101%'
                                  )
                                 ) and
                            ((p.kv != 980 and p.kv2 = 980) or
                             (p.kv=980 and p.kv2 != 980) or
                             (p.kv = p.kv2) or
                             (p.kv != p.kv2 and p.kv != 980 and p.kv2 != 980)) and
                              p.ref=w.ref(+) and
                              w.tag(+) LIKE 'KURS%') a
                          join nbur_dm_accounts s
                          on (s.report_date = a.report_date and
                              s.kf = a.kf and
                              s.acc_id = a.acc_id)
                          left outer join operw b
                          on (a.ref = b.ref and
                              b.tag='BM__C')
                          left outer join bank_metals c
                          on (c.kod = trim(b.value) and
                              c.kv = a.kv)
                          left outer join operw d
                          on (a.ref = d.ref and
                              d.tag='D#44')
                    where a.kurs is not null or
                          nvl(a.bal, 0) <> 0 and nvl(a.bal_uah_cent, 0) <> 0))
                     UNPIVOT (VALUE FOR colname IN  (s1, s3, s4)
            ) d
            where d.type_op not in ('610', '620');
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_I39 error: '
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
              '4'||a.field_code,
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
               GROUP BY report_date,
                        kf,
                        report_code,
                        nbuc,
                        substr(field_code, 2)) a
         join
             (  SELECT kf,
                       nbuc,
                       substr(field_code, 2) field_code,
                       SUM (field_value) field_value
                FROM nbur_detail_protocols
                      WHERE     report_date = p_report_date
                            AND report_code = p_file_code
                            AND kf = p_kod_filii
                            and field_code like '1%'
                   GROUP BY kf, nbuc, substr(field_code, 2)) b
              on (a.kf = b.kf and
                  a.nbuc = b.nbuc and
                  a.field_code = b.field_code);

    logger.info ('NBUR_P_I39 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_I39.sql =========*** End **
PROMPT ===================================================================================== 
