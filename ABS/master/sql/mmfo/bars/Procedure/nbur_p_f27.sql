

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F27.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F27 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F27 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#27')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ @12 ��� �������� �����
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.003  15.12.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.003  15.12.2016';
/*
   ��������� ���������  D BBBB 00 VVV
   
   D    -    ���� �������� ��������: 
        5 - ������� �����
        6 - ���������� �����
        7 � � ���� ���� ������� ��� ������������ ������� �������� ������
             (� 22.11.2012) 
   BBBB    -    ���������� �������;
   00    -    ������� ��������, ��������� ������ (�� 01.03.2006 ���������
              ��������� ���� D020 �������� KL_D020)    
   VVV    -    ��� ������;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
BEGIN
    logger.info ('NBUR_P_F27 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
 
    -- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
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
               (case when l_type = 0 then l_nbuc else d.nbuc end) nbuc,
               substr(d.colname,2,1) ||
               d.nbs ||
               '00' ||
               lpad(d.kv, 3, '0')
               field_code,
               abs(d.value) field_value,
               NULL description,
               d.acc_id,
               d.acc_num,
               d.kv,
               null maturity_date,
               d.cust_id,
               null ref,
               NULL nd,
               d.branch
        FROM (SELECT  s.report_date, s.kf, a.cust_id, a.acc_id,
                      a.acc_num, a.kv, a.nbs,
                      s.dos s5, s.kos s6, a.nbuc, a.branch
              FROM NBUR_DM_BALANCES_DAILY s, NBUR_DM_ACCOUNTS a
              WHERE s.report_date = p_report_date and
                    s.kf = p_kod_filii and
                    s.acc_id = a.acc_id and
                    a.report_date = p_report_date and
                    a.kf = p_kod_filii and
                    a.nbs = '2603' and
                    a.kv  NOT IN (980,959,961,962,964) and
                    s.dos+s.kos <> 0)
                    UNPIVOT (VALUE FOR colname IN  (s5, s6)) d
        WHERE abs(d.value)<>0;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F27 error: '
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
               l_nbuc nbuc,
               '7' ||
               d.nbs ||
               d.d020 ||
               lpad(d.kv, 3, '0') field_code,
               d.sump field_value,
               NULL description,
               d.acc_id,
               d.acc_num,
               d.kv,
               null maturity_date,
               d.cust_id,
               d.ref,
               NULL nd,
               null branch
        FROM (select t.report_date, t.kf, t.cust_id_db cust_id,
                     t.acc_id_db acc_id, t.acc_num_db acc_num,
                     t.r020_db nbs, t.kv,
                     t.bal sump, '00' d020, t.ref
              from NBUR_DM_TRANSACTIONS t, NBUR_DM_ADL_DOC_RPT_DTL r, oper o
              where t.report_date = p_report_date and
                    t.kf = p_kod_filii and
                    r.report_date(+) = p_report_date and
                    r.kf(+) = p_kod_filii and
                    t.ref = r.ref(+) and
                    t.ref = o.ref and 
                    t.kv not in (980, 959, 961, 962, 964) and
                    t.acc_num_db like '2603%' and
                    t.acc_num_cr not like '25%' and
                    t.acc_num_cr not like '26%' and
                    (t.acc_num_cr like '2900%' and t.ob22_cr = '04' or 
                     r.d020 = '01' or
                     LOWER(o.nazn) like '%����%����%' or
                     LOWER(o.nazn) like '%��%�����%������%'  or  
                     LOWER(o.nazn) like '%�����_��_� �������%'   
                     )
                union all
              select t.report_date, t.kf, t.cust_id_db cust_id,
                     t.acc_id_db acc_id, t.acc_num_db acc_num,
                     t.r020_db nbs, t.kv,
                     t.bal sump, '00' d020, t.ref
              from NBUR_DM_TRANSACTIONS t
              where t.report_date = p_report_date and
                    t.kf = p_kod_filii and
                    t.kv not in (980, 959, 961, 962, 964) and
                     (t.acc_num_db like '2909%' and t.ob22_cr in ('55','56','75') and
                      t.acc_num_cr like '2900%' and t.ob22_cr = '01'
                      or
                      t.acc_num_db like '1919%' and t.ob22_cr = '02' and
                      t.acc_num_cr like '3800%' and t.ob22_cr = '10'
                      )
            
            ) d;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F27 error: '
             || SQLERRM
             || ' for date = '
             || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
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

    logger.info ('NBUR_P_F27 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F27.sql =========*** End **
PROMPT ===================================================================================== 
