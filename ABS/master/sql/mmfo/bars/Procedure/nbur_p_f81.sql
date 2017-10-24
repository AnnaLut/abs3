

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F81.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F81 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F81 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'G',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#81')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #81 ��� ��
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.002  11.08.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.002  11.08.2016';
/*
   ��������� ���������    DD BBBB VVV Y

   DD         {10,11,20,21,50,51,60,61,70,71,80,81...}
   BBBB       R810 ���������� �������
   VVV        R030 ��� ������
   Y          K041 ������i� �� ������� ���i�

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������� ������� ��������� � ��������������� ������� v_nbur_dm_....
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   l_nbuc          varchar2(20);
   l_type          number;
   l_datez         date := p_report_date + 1;
   l_file_code     varchar2(2) := '02';
BEGIN
    logger.info ('NBUR_P_F81 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

   -- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
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
                 (case when l_type = 0 then l_nbuc else nbuc end) nbuc,
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
                                                                        P21))) d
       where (d.kv!='980' or d.colname like 'P_0') and d.field_value!=0;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info ('NBUR_P_F81 error: ' || SQLERRM);
    END;

    -- ������������ ����������� �����  �  nbur_agg_protocols
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

    logger.info ('NBUR_P_F81 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END NBUR_P_F81;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F81.sql =========*** End **
PROMPT ===================================================================================== 
