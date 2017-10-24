

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FA7.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_FA7 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FA7 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#A7')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #A7 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.003    11.08.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.003  11.08.2016';
/*
   Структура показника   D BBBB P X L R Щ VVV

   D    -    може приймати значення:
    1 - дебетовий залишок (грн. еквівалент);
    2 - кредитовий залишок (грн. еквівалент)

   BBBB      -    балансовий рахунок;
    P        -    розподіл рахунку за визначеним критерієм;
    X        -    строковість;
    L        -    код строку до погашення;
    R        -    резидентність;
    Щ        -    вид рахунку;
   VVV       -    код валюти;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   l_nbuc          varchar2(20);
   l_type          number;
   l_datez         date := p_report_date + 1;
   l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
BEGIN
    logger.info ('NBUR_P_FA7 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);

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
          SELECT p_report_date,
                 p_kod_filii,
                 p_file_code,
                 (case when l_type = 0 then l_nbuc else d.nbuc end) nbuc,
                 SUBSTR (d.colname, 2, 1)
                 || d.nbs
                 || d.kodp
                 || SUBSTR ('000' || d.kv, -3)
                 field_code,
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
                         kodp,
                         cust_id,
                         rez,
                         ABS (VALUE) field_value,
                         colname,
                         branch,
                         nbuc
                    FROM (SELECT b.cust_id,
                                 b.acc_id,
                                 a.kf,
                                 a.acc_num,
                                 a.kv,
                                 a.nbs,
                                 a.maturity_date,
                                 a.close_date,
                                 A.R013 ||
                                 A.S181 ||
                                 A.S240 ||
                                 c.k030 ||
                                 A.R012 kodp,
                                 DECODE (NVL (c.k040, '804'), '804', '1', '2') rez,
                                 DECODE (SIGN (b.ostq), 1, 0, -ostq) P10,
                                 DECODE (SIGN (b.ostq), 1, ostq, 0) P20,
                                 a.branch,
                                 a.nbuc
                            FROM nbur_tmp_kod_r020 k,
                                 nbur_dm_accounts a,
                                 nbur_dm_customers c,
                                 nbur_dm_balances_daily b
                           WHERE     a.nbs = k.r020
                                 AND a.report_date = p_report_date
                                 AND (p_kod_filii IS NULL OR a.kf = p_kod_filii)
                                 AND b.acc_id = a.acc_id
                                 AND b.report_date = p_report_date
                                 AND a.cust_id = c.cust_id
                                 AND c.report_date = p_report_date) UNPIVOT (VALUE
                                                                    FOR colname
                                                                    IN  (P10,
                                                                        P20))) d
           where d.field_value!=0;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_FA7 error: '
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

    logger.info ('NBUR_P_FA7 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END NBUR_P_FA7;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FA7.sql =========*** End **
PROMPT ===================================================================================== 
