

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_I37.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_I37 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_I37 (p_kod_filii         varchar2,
                                             p_report_date       date,
                                             p_form_id           number,
                                             p_scheme            varchar2 default 'C',
                                             p_balance_type      varchar2 default 'S',
                                             p_file_code         varchar2 default '@37')
  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования @37 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     : v.16.005   18.12.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.005   18.12.2017';
/*
   Структура показника    DD BBBB OO VVV

   DD         {10,11,20,21,50,51,60,61}
   BBBB       R020 балансовий рахунок
   OO         розподiл згiдно довiдника OB22
   VVV        R030 код валюти

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   l_nbuc          varchar2(20);
   l_type          number;
   l_datez         date := p_report_date + 1;
   l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
BEGIN
    logger.info ('NBUR_P_I37 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- определение начальных параметров (код области или МФО или подразделение)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 2, l_file_code, l_nbuc, l_type);
    
--    if p_report_date = to_date('18122017', 'ddmmyyyy') then
--       NBUR_PREPARE_TURNS(p_kod_filii, p_report_date);
--       commit;
--    end if;

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
          SELECT /* parallel(8) */
                 p_report_date,
                 p_kod_filii,
                 p_file_code,
                 (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
                    SUBSTR (d.colname, 2, 2)
                 || d.nbs
                 || d.ob22
                 || SUBSTR ('000' || d.kv, -3)
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
                         ob22,
                         date_off,
                         cust_id,
                         maturity_date,
                         branch,
                         nbuc,
                         colname,
                         VALUE
                    FROM (SELECT /*+ index(a, IDX_DMACCOUNTS_NBS_OB22) */
                                 b.cust_id,
                                 b.acc_id,
                                 a.maturity_date,
                                 a.kf,
                                 a.acc_num,
                                 a.kv,
                                 a.ob22,
                                 a.nbs,
                                 a.close_date date_off,
                                 DECODE (SIGN (b.ostq), 1, 0, -ostq) P10,
                                 DECODE (SIGN (b.ostq), 1, ostq, 0) P20,
                                 DECODE (SIGN (b.ost), 1, 0, -ost) P11,
                                 DECODE (SIGN (b.ost), 1, ost, 0) P21,
                                 b.dosq P50,
                                 b.kosq P60,
                                 (CASE
                                     WHEN b.kos < 0 THEN b.dos + ABS (b.kos)
                                     WHEN b.dos < 0 THEN 0
                                     ELSE b.dos
                                  END)
                                    P51,
                                 (CASE
                                     WHEN b.dos < 0 THEN b.kos + ABS (b.dos)
                                     WHEN b.kos < 0 THEN 0
                                     ELSE b.kos
                                  END)
                                    P61,
                                 a.branch,
                                 a.nbuc
                            FROM nbur_tmp_kod_r020 k,
                                 nbur_dm_accounts a,
                                 nbur_dm_balances_daily b
                           WHERE     a.nbs = k.r020
                                 AND a.report_date = p_report_date
                                 AND a.kf = p_kod_filii
                                 AND nvl(a.acc_alt_dt, p_report_date - 1) <> p_report_date
                                 AND b.acc_id = a.acc_id
                                 AND b.report_date = p_report_date
                                 AND b.kf = p_kod_filii)   UNPIVOT (VALUE
                                                                    FOR colname
                                                                    IN  (P10,
                                                                        P20,
                                                                        P11,
                                                                        P21,
                                                                        P50,
                                                                        P60,
                                                                        P51,
                                                                        P61))) d
           WHERE (d.kv != '980' OR d.colname LIKE 'P_0') AND d.VALUE != 0;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info ('NBUR_P_I37 error: ' || SQLERRM);
    END;

    commit;
    
    if p_report_date = to_date('18122017', 'ddmmyyyy') then
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
              SELECT /* parallel(8) */
                     p_report_date,
                     p_kod_filii,
                     p_file_code,
                     (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
                        SUBSTR (d.colname, 2, 2)
                     || d.nbs
                     || d.ob22
                     || SUBSTR ('000' || d.kv, -3)
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
                             ob22,
                             date_off,
                             cust_id,
                             maturity_date,
                             branch,
                             nbuc,
                             colname,
                             VALUE
                        FROM (SELECT /*+ ordered parallel(8)  */
                                     b.cust_id,
                                     b.acc_id,
                                     a.maturity_date,
                                     a.kf,
                                     b.acc_num,
                                     b.kv,
                                     b.acc_ob22 ob22,
                                     substr(b.acc_num, 1, 4) nbs,
                                     a.close_date date_off,
                                     DECODE (SIGN (b.ostq_rep), 1, 0, -ostq_rep) P10,
                                     DECODE (SIGN (b.ostq_rep), 1, ostq_rep, 0) P20,
                                     DECODE (SIGN (b.ost_rep), 1, 0, -ost_rep) P11,
                                     DECODE (SIGN (b.ost_rep), 1, ost_rep, 0) P21,
                                     b.dosq_repd P50,
                                     b.kosq_repd P60,
                                     b.dos_repd P51,
                                     b.kos_repd P61,
                                     a.branch,
                                     a.nbuc
                                FROM nbur_kor_balances b, nbur_dm_accounts a
                               WHERE     substr(b.acc_num,1,4) in (select r020 from nbur_tmp_kod_r020) 
                                     AND a.report_date = p_report_date
                                     AND a.kf = p_kod_filii
                                     AND nvl(a.acc_alt_dt, p_report_date - 1) = p_report_date
                                     AND b.acc_id = a.acc_id
                                     AND b.report_date = p_report_date
                                     AND b.kf = p_kod_filii)   UNPIVOT (VALUE
                                                                        FOR colname
                                                                        IN  (P10,
                                                                            P20,
                                                                            P11,
                                                                            P21,
                                                                            P50,
                                                                            P60,
                                                                            P51,
                                                                            P61))) d
               WHERE (d.kv != '980' OR d.colname LIKE 'P_0') AND d.VALUE != 0;
        EXCEPTION
           WHEN OTHERS
           THEN
              logger.info ('NBUR_P_I37 error: ' || SQLERRM);
        END;

        commit;
    end if;

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

   logger.INFO ('NBUR_P_I37 end for date = '||TO_CHAR(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_I37.sql =========*** End **
PROMPT ===================================================================================== 
