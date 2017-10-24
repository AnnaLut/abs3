

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F02.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F02 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F02 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'G',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#02')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #02 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.002  11.08.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.002  11.08.2016';
/*
   Структура показника    DD BBBB VVV Y

   DD         {10,11,20,21,50,51,60,61,70,71,80,81...}
   BBBB       R020 балансовий рахунок
   VVV        R030 код валюти
   Y          K041 розподiл за групами краiн

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
актуальные витрины находятся в соответствующих вьюшках v_nbur_dm_....
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   l_nbuc          varchar2(20);
   l_type          number;
   l_datez         date := p_report_date + 1;
   l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
BEGIN
   logger.info ('NBUR_P_F02 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

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
          SELECT /*+ parallel(8) */p_report_date,
                 p_kod_filii,
                 p_file_code,
                 (case when l_type = 0 then l_nbuc else d.nbuc end) nbuc,
                 SUBSTR (d.colname, 2, 2)
                 || d.nbs
                 || SUBSTR ('000' || d.kv, -3)
                 || k041 field_code,
                 field_value,
                 NULL description,
                 acc_id,
                 acc_num,
                 kv,
                 maturity_date,
                 cust_id,
                 NULL,
                 NULL,
                 branch
            FROM (SELECT acc_id,
                         acc_num,
                         nbs,
                         kv,
                         date_off,
                         maturity_date,
                         cust_id,
                         k041,
                         branch,
                         nbuc,
                         colname,
                         ABS (VALUE) field_value
                    FROM (SELECT b.cust_id,
                                 b.acc_id,
                                 a.maturity_date,
                                 a.kf,
                                 a.acc_num,
                                 a.kv,
                                 a.nbs,
                                 a.close_date date_off,
                                 DECODE (SIGN (b.adj_bal_uah), 1, 0, -adj_bal_uah) P10,
                                 DECODE (SIGN (b.adj_bal_uah), 1, adj_bal_uah, 0) P20,
                                 DECODE (SIGN (b.adj_bal), 1, 0, -adj_bal) P11,
                                 DECODE (SIGN (b.adj_bal), 1, adj_bal, 0) P21,
                                 b.dosq - b.cudosq P50,
                                 b.kosq - b.cukosq P60,
                                 (CASE
                                     WHEN b.kos - b.cukos < 0 THEN b.dos - b.cudos + ABS (b.kos - b.cukos)
                                     WHEN b.dos - b.cudos < 0 THEN 0
                                     ELSE b.dos - b.cudos
                                  END)
                                    P51,
                                 (CASE
                                     WHEN b.dos - b.cudos < 0 THEN b.kos - b.cukos + ABS (b.dos - b.cudos)
                                     WHEN b.kos - b.cukos < 0 THEN 0
                                     ELSE b.kos - b.cukos
                                  END)
                                    P61,
                                 b.crdosq P70,
                                 b.crkosq P80,
                                 b.crdos  P71,
                                 b.crkos  P81,
                                 a.branch,
                                 a.nbuc,
                                 c.K041
                            FROM nbur_tmp_kod_r020 k,
                                 nbur_dm_accounts a,
                                 nbur_dm_customers c,
                                 nbur_dm_balances_monthly b
                           WHERE     a.nbs = k.r020
                                 AND a.report_date = p_report_date
                                 AND a.kf = p_kod_filii
                                 AND b.acc_id = a.acc_id
                                 AND b.report_date = p_report_date
                                 AND b.kf = p_kod_filii
                                 AND a.cust_id = c.cust_id
                                 AND c.report_date = p_report_date
                                 AND c.kf = p_kod_filii) UNPIVOT (VALUE
                                                                    FOR colname
                                                                    IN  (P10,
                                                                        P20,
                                                                        P11,
                                                                        P21,
                                                                        P50,
                                                                        P60,
                                                                        P51,
                                                                        P61,
                                                                        P70,
                                                                        P80,
                                                                        P71,
                                                                        P81))) d
       where (d.kv!='980' or d.colname like 'P_0') and d.field_value!=0;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info ('NBUR_P_F02 error: ' || SQLERRM);
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

    logger.info ('NBUR_P_F02 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END NBUR_P_F02;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F02.sql =========*** End **
PROMPT ===================================================================================== 
