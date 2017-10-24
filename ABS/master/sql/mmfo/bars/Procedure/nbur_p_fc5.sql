

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FC5.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_FC5 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FC5 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#C5')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #C5 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.002        11.08.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.002    11.08.2016';
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
    logger.info ('NBUR_P_F'||l_file_code||' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

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
                 d.t020
                 || d.nbs
                 || d.r013_clc
                 || SUBSTR ('000' || d.kv, -3)
                 || d.r012
                 || (case nvl(r.s580, d.s580)
                        when '0' then '9'
                        else nvl(r.s580, d.s580)
                     end) field_code,
                 abs(bal_uah) field_value,
                 'r013_old='||d.r013||' r013_new='||d.r013_clc description,
                 d.acc_id,
                 d.acc_num,
                 d.kv,
                 d.maturity_date,
                 d.cust_id,
                 NULL,
                 NULL,
                 d.branch
            FROM (SELECT A.cust_id,
                         b.acc_id,
                         a.kf,
                         a.acc_num,
                         a.kv,
                         a.nbs,
                         a.maturity_date,
                         b.r013, b.r020, b.ob22,
                         b.r030, b.bal_uah, b.r013_clc,
                         a.r012,
                         a.s580,
                         a.branch,
                         a.nbuc,
                         decode(sign(bal_uah), -1, '1', '2') t020
                    FROM nbur_tmp_kod_r020 k,
                         nbur_dm_accounts a,
                         nbur_dm_customers c,
                         nbur_dm_balances_dly_r013 b
                   WHERE     a.nbs = k.r020
                         AND a.report_date = p_report_date
                         AND (p_kod_filii IS NULL OR a.kf = p_kod_filii)
                         AND b.acc_id = a.acc_id
                         AND b.report_date = p_report_date
                         AND a.cust_id = c.cust_id
                         AND c.report_date = p_report_date) d
            left outer join (select R020, T020, R013, max(S580) s580
                             from otc_risk_s580
                             where s580 <> 'R'
                             group by R020, T020, R013) r
            on (d.r020 = r.r020 and
               (d.t020 = r.t020 or r.t020 = '3') and
               (d.r013 = r.r013 or r.r013 = '0'))
            where BAL_UAH <> 0;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
             'NBUR_P_F'||l_file_code||' error: '
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
              GROUP BY report_date,
                       kf,
                       report_code,
                       nbuc,
                       field_code);

    logger.info ('NBUR_P_F'||l_file_code||' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END NBUR_P_FC5;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FC5.sql =========*** End **
PROMPT ===================================================================================== 
