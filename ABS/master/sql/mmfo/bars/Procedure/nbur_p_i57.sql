

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_I57.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_I57 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_I57 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'G',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '@57')
  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : I?ioaao?a oi?ie?iaaiey @57 aey EA
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.002  11.08.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.002  11.08.2016';
/*
   Структура показника    DD BBBB VVV Y

   DD         {10,20,50,60}
   BBBB       R020 балансовий рахунок

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
актуальные витрины находятся в соответствующих вьюшках v_nbur_dm_....
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   l_nbuc          varchar2(20);
   l_type          number;
   l_datez         date := p_report_date + 1;
   l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
BEGIN
   logger.info ('NBUR_P_I57 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

   -- определение начальных параметров (код области или МФО или подразделение)
   nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 4, l_file_code, l_nbuc, l_type);

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
                 (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
                    SUBSTR (d.colname, 2, 2)
                 || d.nbs
                    field_code,
                 ABS (VALUE) field_value,
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
                         cust_id,
                         maturity_date,
                         branch,
                         nbuc,
                         colname,
                         VALUE
                    FROM (SELECT b.cust_id,
                                 b.acc_id,
                                 a.maturity_date,
                                 a.kf,
                                 a.acc_num,
                                 a.kv,
                                 a.nbs,
                                 a.close_date date_off,
                                 DECODE (SIGN (b.ost), 1, 0, -ost) P10,
                                 DECODE (SIGN (b.ost), 1, ost, 0) P20,
                                 (CASE
                                     WHEN b.kos < 0 THEN b.dos + ABS (b.kos)
                                     WHEN b.dos < 0 THEN 0
                                     ELSE b.dos
                                  END)
                                    P50,
                                 (CASE
                                     WHEN b.dos < 0 THEN b.kos + ABS (b.dos)
                                     WHEN b.kos < 0 THEN 0
                                     ELSE b.kos
                                  END)
                                    P60,
                                 a.branch,
                                 a.nbuc
                            FROM nbur_tmp_kod_r020 k,
                                 nbur_dm_accounts a,
                                 nbur_dm_balances_daily b
                           WHERE     a.nbs = k.r020
                                 AND a.kv = 980
                                 AND a.report_date = p_report_date
                                 AND a.kf = p_kod_filii
                                 AND b.acc_id = a.acc_id
                                 AND b.report_date = p_report_date
                                 AND b.kf = p_kod_filii)   UNPIVOT (VALUE
                                                                    FOR colname
                                                                    IN  (P10,
                                                                        P20,
                                                                        P50,
                                                                        P60))) d
           WHERE d.VALUE != 0;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info ('NBUR_P_I57 error: ' || SQLERRM);
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

   logger.info ('NBUR_P_I57 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_I57.sql =========*** End **
PROMPT ===================================================================================== 
