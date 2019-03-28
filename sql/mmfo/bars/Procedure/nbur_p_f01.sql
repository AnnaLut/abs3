

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F01.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F01 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F01 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#01')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #01 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.004  18/01/2018 (22.11.2016)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.004  18/01/2018';
/*
   Структура показника    DD BBBB VVV Y

   DD         {10,11,20,21,50,51,60,61,70,71,80,81...}
   BBBB       R020 балансовий рахунок
   VVV        R030 код валюти
   Y          K041 розподiл за групами краiн
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   l_nbuc          varchar2(20);
   l_type          number;
   l_datez         date := p_report_date + 1;
   l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
BEGIN
    logger.info ('NBUR_P_F01 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);

    BEGIN
       INSERT /*+ APPEND */
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
          SELECT /*+ parallel(8) */
                 p_report_date,
                 p_kod_filii,
                 p_file_code,
                 (case when l_type = 0 then l_nbuc else d.nbuc end),
                 SUBSTR (d.colname, 2, 2)
                 || d.nbs
                 || SUBSTR ('000' || d.kv, -3)
                 || d.rez field_code,
                 field_value,
                 NULL description,
                 d.acc_id,
                 d.acc_num,
                 d.kv,
                 d.maturity_date,
                 d.cust_id,
                 NULL,
                 NULL,
                 d.branch
            FROM (SELECT acc_id,
                         acc_num,
                         nbs,
                         kv,
                         maturity_date,
                         close_date,
                         cust_id,
                         rez,
                         ABS (VALUE) field_value,
                         colname,
                         branch,
                         nbuc,
                         kf
                    FROM (SELECT /*+ index(a, IDX_DMACCOUNTS_NBS_OB22) */
                                 b.cust_id,
                                 b.acc_id,
                                 a.kf,
                                 a.acc_num,
                                 a.kv,
                                 a.nbs,
                                 a.maturity_date,
                                 a.close_date,
                                 DECODE (NVL (c.k040, '804'), '804', '1', '2') rez,
                                 DECODE (SIGN (b.ostq), 1, 0, -ostq) P10,
                                 DECODE (SIGN (b.ostq), 1, ostq, 0) P20,
                                 DECODE (SIGN (b.ost), 1, 0, -ost) P11,
                                 DECODE (SIGN (b.ost), 1, ost, 0) P21,
                                 a.branch,
                                 a.nbuc
                            FROM nbur_tmp_kod_r020 k,
                                 nbur_dm_accounts a,
                                 nbur_dm_customers c,
                                 nbur_dm_balances_daily b
                           WHERE     a.nbs = k.r020
                                 AND a.report_date = p_report_date
                                 AND a.kf = p_kod_filii
                                 AND b.acc_id = a.acc_id
                                 AND b.report_date = p_report_date
                                 AND b.kf = p_kod_filii
                                 AND a.cust_id = c.cust_id
                                 AND c.report_date = p_report_date
                                 AND c.kf = p_kod_filii)   UNPIVOT (VALUE
                                                                    FOR colname
                                                                    IN  (P10,
                                                                        P20,
                                                                        P11,
                                                                        P21))) d
           where (d.kv!='980' or d.colname like 'P_0') and d.field_value!=0;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F01 error: '
             || SQLERRM
             || ' for date = '
             || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    commit;

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

    logger.info ('NBUR_P_F01 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
    
    -- підготовка даних для формування 42 консолідованого файлу
    nbur_p_prepare_f42k(p_kod_filii, p_report_date);
    
END NBUR_P_F01;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F01.sql =========*** End **
PROMPT ===================================================================================== 
