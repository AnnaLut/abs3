

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F39.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F39 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F39 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#39')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #39 для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.007  28.05.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.007  28.05.2017';
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
    logger.info ('NBUR_P_F39 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

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
               comm description,
               d.acc_id,
               d.acc_num,
               d.kv,
               null maturity_date,
               d.cust_id,
               ref,
               NULL nd,
               branch
        FROM (select  report_date, kf, ref, tt, cust_id, acc_id, acc_num,
                      cust_id2, acc_id2, acc_num2, branch, nbuc,
                      kv, type_op ,
                      bal s1,
                      bal * round(kurs * div, 4) / dig s3,
                      kurs * div s4,
                      comm || trim(to_char(kurs, l_fmt)) comm
                from (
                    select s.report_date, s.kf, s.ref, s.tt, s.cust_id, s.acc_id, s.acc_num,
                        s.cust_id2, s.acc_id2, s.acc_num2, s.kv, s.bal, s.bal_uah,
                        (case when s.kurs is not null
                              then (case when is_number(s.kurs) = 1 then to_number(s.kurs) else null end)
                              else (case when s.kf = '300465' and nvl(s.bal, 0) <> 0 and nvl(s.bal_uah_cent, 0) <> 0
                                         then s.bal_uah_cent / s.bal
                                         else f_ret_rate(s.kv, s.report_date, decode(s.dk, 0, 'B', 'S'))
                                    end)
                        end) kurs,
                        decode(s.dk, 0, '210', '220') type_op,
                        F_NBUR_Ret_Dig(s.kv, s.report_date) dig,
                        F_NBUR_Ret_DiV(s.kv, s.report_date) div,
                        a.branch, a.nbuc,
                        (case when s.kurs is not null
                              then (case when is_number(s.kurs) = 1 then ' курс введений в док-тi ' else null end)
                              else (case when s.kf = '300465' and nvl(s.bal, 0) <> 0 and nvl(s.bal_uah_cent, 0) <> 0
                                         then ' курс розрахований '
                                         else ' курс вибраний iз таблицi курсiв '
                                    end)
                        end) comm
                    from
                       (select t.report_date, t.kf, t.ref, t.tt,
                               (case when t.acc_num_db like '100%' then t.cust_id_db else t.cust_id_cr end) cust_id,
                               (case when t.acc_num_db like '100%' then t.acc_id_db else t.acc_id_cr end) acc_id,
                               (case when t.acc_num_db like '100%' then t.acc_num_db else t.acc_num_cr end) acc_num,
                               (case when t.acc_num_db like '100%' then t.cust_id_cr else t.cust_id_db end) cust_id2,
                               (case when t.acc_num_db like '100%' then t.acc_id_cr else t.acc_id_db end) acc_id2,
                               (case when t.acc_num_db like '100%' then t.acc_num_cr else t.acc_num_db end) acc_num2,
                               t.kv, t.bal, t.bal_uah,
                               (case when p.kv != p.kv2 and p.kv != 980 and p.kv2 != 980
                                     then null
                                     else trim(w.value)
                               end) kurs,
                               (case when (p.kv != p.kv2 and p.kv != 980 and p.kv2 != 980) or
                                           p.tt <> t.tt
                                     then F_NBUR_D3801(p.ref,t.tt,v.ACC3801,
                                        (case when t.acc_num_db like '100%' then 0 else 1 end),
                                        v.ACC_RRD,v.ACC_RRR, p_report_date, p_kod_filii)
                                     else decode(p.kv2,t.kv,p.s,p.s2)
                               end) bal_uah_cent,
                               (case when t.acc_num_db like '100%' then 0 else 1 end) dk,
                               p.nlsa, p.nlsb, p.kv kvo, p.kv2, p.s, p.s2
                        from NBUR_DM_TRANSACTIONS t, vp_list v, oper p, operw w
                        where t.report_date = p_report_date and
                            t.kf = p_kod_filii and
                            t.tt not in ('BAK') and
                            t.kv not in (959,961,962,964) and
                            (t.acc_id_db = v.acc3800 and t.ob22_db in ('10','11','12') and t.acc_num_cr like '100%' or
                             t.acc_id_cr = v.acc3800 and t.ob22_cr in ('10','11','12') and t.acc_num_db like '100%') and
                            t.ref = p.ref and
                            p.sos = 5 and
                            p.nlsa not like '390%' and p.nlsb not like '390%' and
                            ((p.kv != 980 and p.kv2 = 980) or
                             (p.kv=980 and p.kv2 != 980) or
                             (p.kv = p.kv2) or
                             (p.kv != p.kv2 and p.kv != 980 and p.kv2 != 980)) and
                            ((t.tt = p.tt and
                              NOT exists (select 1
                                          from operw z
                                          where p.ref=z.ref and
                                                z.tag in ('D#73','73'||t.tt) and
                                                substr(z.value,1,3) in ('220','221','222','223','270',
                                                                        '321','322','325','323','370')))
                                   OR
                              (t.tt != p.tt and
                               NOT exists (select 1
                                          from operw z
                                          where p.ref=z.ref and
                                                z.tag = '73'||t.tt and
                                                substr(z.value,1,3) in ('220','221','222','223','270',
                                                                        '321','322','325','323','370')))) and
                              p.ref=w.ref(+) and
                              w.tag(+) LIKE 'KURS%') s, nbur_dm_accounts a
                    where s.report_date = a.report_date and
                          s.kf = a.kf and
                          s.acc_id = a.acc_id and
                          (s.kurs is not null or
                          nvl(s.bal, 0) <> 0 and nvl(s.bal_uah_cent, 0) <> 0)))
                     UNPIVOT (VALUE FOR colname IN  (s1, s3, s4)
            ) d;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F39 error: '
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
         FROM (SELECT report_date,
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

    -- для використання при формуванні #2F
    DELETE FROM OTCN_TRACE_39
    WHERE datf = p_report_date;

    insert into OTCN_TRACE_39(DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
    select report_date, user_id, acc_num, kv, report_date, field_code, field_value, nbuc, null,
        cust_id, acc_id, REF, description, nd, maturity_date, branch
    from nbur_detail_protocols
    where report_date = p_report_date and
          kf = p_kod_filii and
          report_code = p_file_code;
    
    -- вставка для забезпечення контролю файлу #73
    DELETE FROM tmp_nbu
    WHERE datf = p_report_date and
          kf = p_kod_filii and
          kodf = '39';
              
    insert into tmp_nbu(DATF, KODF, KODP, ZNAP, NBUC, KF)
    select report_date, '39', field_code, field_value, nbuc, kf
    from nbur_agg_protocols 
    where report_date = p_report_date and
          kf = p_kod_filii and
          report_code = p_file_code;    

    logger.info ('NBUR_P_F39 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F39.sql =========*** End **
PROMPT ===================================================================================== 
