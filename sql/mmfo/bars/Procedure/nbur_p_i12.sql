

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_I12.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_I12 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_I12 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '@12')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования @12 для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.004  06.03.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.004  06.03.2017';
/*
   Структура показника   DD

   DD         символ касплану
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
BEGIN
    logger.info ('NBUR_P_I12 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

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
               substr(d.colname,2,2) field_code,
               abs(d.value) field_value,
               NULL description,
               d.acc_id,
               d.acc_num,
               d.kv,
               d.maturity_date,
               d.cust_id,
               null ref,
               NULL nd,
               d.branch
        FROM (SELECT  s.report_date, s.kf, a.cust_id, a.acc_id, a.acc_num, a.kv,
                      s.vost s35, s.ost s70, a.nbuc, a.branch, a.maturity_date
              FROM NBUR_DM_BALANCES_DAILY s, NBUR_DM_ACCOUNTS a
              WHERE s.report_date = p_report_date and
                    s.kf = p_kod_filii and
                    s.acc_id = a.acc_id and
                    a.report_date = p_report_date and
                    a.kf = p_kod_filii and
                    a.nbs in ('1001','1002','1003','1004') and
                    a.kv=980  and
                    a.acc_type='KAS') UNPIVOT (VALUE FOR colname
                                               IN  (s35,s70)) d
        WHERE abs(d.value)<>0;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_I12 error: '
             || SQLERRM
             || ' for date = '
             || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

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
               (case when l_type = 0 then l_nbuc else a.nbuc end) nbuc,
               d.sk field_code,
               d.sump field_value,
               ' Дт рах. = ' || decode(d.dk, 0, d.acc_num, d.acc_num_2) || 
               ' Кт рах. = ' || decode(d.dk, 1, d.acc_num, d.acc_num_2) ||
               '  ' ||substr(o.nazn, 1, 100) description,
               d.acc_id,
               d.acc_num,
               d.kv,
               a.maturity_date,
               d.cust_id,
               d.ref,
               NULL nd,
               a.branch
        FROM (select t.report_date, t.kf, t.cust_id_db cust_id, 0 dk,
                     t.acc_id_db acc_id, t.acc_num_db acc_num, t.kv,
                     t.bal sump,
                     (case when nvl(s.symb_val, '00') = '66' and
                        regexp_like(t.ACC_NUM_CR, '^(100[1-4])') then '39'
                        else nvl(s.symb_val, '00')
                     end) sk,
                     t.ref, T.ACC_NUM_CR acc_num_2
                from NBUR_DM_TRANSACTIONS t
                left outer join NBUR_DM_TXN_SYMBOLS s
                on (t.report_date = s.report_date and
                    t.kf = s.kf and
                    t.ref = s.ref and
                    t.stmt = s.stmt and
                    s.symb_tp = 1)
                where t.report_date = p_report_date and
                      t.kf = p_kod_filii and
                      t.r020_db in ('1001','1002','1003','1004') and
                      t.kv=980  and
                      t.acc_type_db='KAS'
                union all
                select t.report_date, t.kf, t.cust_id_cr cust_id, 1 dk,
                       t.acc_id_cr acc_id, t.acc_num_cr acc_num, t.kv,
                       t.bal sump,
                       (case when nvl(s.symb_val, '00') = '39' and
                           regexp_like(t.ACC_NUM_DB, '^(100[1-4])') then '66'
                           else nvl(s.symb_val, '00')
                       end) sk,
                       t.ref, T.ACC_NUM_DB acc_num_2
                from NBUR_DM_TRANSACTIONS t
                left outer join NBUR_DM_TXN_SYMBOLS s
                on (t.report_date = s.report_date and
                    t.kf = s.kf and
                    t.ref = s.ref and
                    t.stmt = s.stmt and
                    s.symb_tp = 1)
                where t.report_date = p_report_date and
                      t.kf = p_kod_filii and
                      t.r020_cr in ('1001','1002','1003','1004') and
                      t.kv=980  and
                      t.acc_type_cr='KAS') d, nbur_dm_accounts a, oper o
         where d.report_date = a.report_date and
               d.kf = a.kf and
               d.acc_id = a.acc_id and
               d.kf = o.kf and
               d.ref = o.ref
;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_I12 error: '
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
               GROUP BY report_date,
                        kf,
                        report_code,
                        nbuc,
                        field_code);

    logger.info ('NBUR_P_I12 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END NBUR_P_I12;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_I12.sql =========*** End **
PROMPT ===================================================================================== 
