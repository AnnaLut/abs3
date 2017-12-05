

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F79.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F79 ***

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F79 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#79')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #79 ��� ��
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.005  10.11.2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.005  10.11.2017';
/*
   ��������� ���������   DD ZZZZZZZZZZ VVV NNNN

    DD    -    ���� �������� ��������:
    
    01 � ����� ��������� / �.�.�. ������� �����
    02 � ���� ��������� ����� 
    03 � ���� ��������� 䳿 ����� 
    04 � ���� ������ ���������� ������� 
    05 � ����� ������ ���������� �������
    07 � ���� ��������������� ����� ��� ��������� �� ������� ����� (� ���.���.), ��� ����������� �� �/� 3660,3661
    08 � ���� ���������� ������� �� ��������� ��������������� ����� �� ������� �����
    09 � ����� �����������, �� ���� ���������� ���� ��������������� �����, ��� ���������� �� ������� �����
    10 � ���� ��������������� �����, � ����������� ����������� �� ������ �������� �������
    11 � ��������� ������ �� �������������� ������ � ����������� �����
    12 � ��������� ������ �� �������������� ������ � �������� �����
    13 � ������������ ���������
    14 � ����� ��������� ��������
    15 � ���� ��������� ��������
    16 � ���� ����������� ��������    
    
    ZZZZZZZZZZ    -    ���������������� ��� �볺��� (10 �����)
    VVV    -    ��� ������;
    NNNN    -    ���������� ����� ����� ��� ����������� �볺���    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   l_nbuc          varchar2(20);
   l_type          number;
   l_datez         date := p_report_date + 1;
   l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
BEGIN
    logger.info ('NBUR_P_F79 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
 
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
          SELECT /*+ parallel(8) */
                 p_report_date,
                 p_kod_filii,
                 p_file_code,
                 (case when l_type = 0 then l_nbuc else d.nbuc end) nbuc,
                 d.field_code,
                 d.field_value,
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
                         cust_id,
                         trim(value) field_value,
                         (case when substr(colname, 2, 2) = '11' and kv <> 980
                            then '12' 
                            else substr(colname, 2, 2)
                         end) || kod1 || kod2 || kod3 field_code,
                         branch,
                         nbuc
                    FROM (SELECT 
                                 b.acc_id,
                                 a.kf,
                                 a.acc_num,
                                 a.kv,
                                 a.nbs,
                                 a.maturity_date,
                                 b.cust_id,
                                 a.branch,
                                 a.nbuc,
                                 lpad (trim (c.cust_code), 10, '0') kod1,
                                 lpad (trim (a.kv), 3, '0') kod2,
                                 lpad (dense_rank () over (order by b.ostq), 4, '0') kod3,
                                 nvl(trim(w.D#79_01), '') p01, --������� �� c.nmk
                                 NVL(trim(w.D#79_02),'���� ��������� �����') p02,
                                 NVL(trim(w.D#79_03),'���� ��������� 䳿 �����') p03,
                                 NVL(trim(w.D#79_04),'���� ������ ���������� �������') p04,
                                 NVL(trim(w.D#79_05),'����� ������ ���������� �������') p05,
                                 to_char(abs(b.ostq)) p07,
                                 NVL(to_char(gl.p_icurval(a.kv, to_number(trim(w.D#79_08)), p_report_date)),
                                        '���� ���������� ������� �� ��������� �� �� �������') p08,
                                 NVL(trim(w.D#79_09),'����� �����������') p09,
                                 to_char(abs(b.ostq) * nvl(trim(w.D#79_09), 0)/100) p10,
                                 trim(to_char(nvl(r.rate_val, 0),'9990D0000')) p11,
                                 to_char(c.k030) p13,
                                 NVL(trim(w.D#79_14),'����� ��������� ��������') p14,
                                 NVL(trim(w.D#79_15),'���� ��������� ��������') p15,
                                 '0' p16
                            FROM NBUR_DM_ACCOUNTS a,
                                 NBUR_DM_CUSTOMERS c,
                                 NBUR_DM_BALANCES_DAILY b,
                                 (select *
                                  from (
                                    select *
                                    from ACCOUNTSW
                                    where tag like 'D#79%' and
                                        substr(trim(tag), 6, 2) in ('01', '02', '03', '04', '05', 
                                            '08', '09', '14', '15'))
                                    PIVOT (max(value) for tag in 
                                    ('D#79_01' as D#79_01,  'D#79_02' as D#79_02, 'D#79_03' as D#79_03,
                                    'D#79_04' as D#79_04,  'D#79_05' as D#79_05, 'D#79_08' as D#79_08,
                                    'D#79_09' as D#79_09,  'D#79_14' as D#79_14, 'D#79_15' as D#79_15))) w,
                                 NBUR_DM_ACNT_RATES r
                           WHERE     a.report_date = p_report_date
                                 AND a.kf = p_kod_filii
                                 AND a.nbs in ('3660','3661')
                                 AND b.acc_id = a.acc_id
                                 AND b.report_date = p_report_date
                                 AND b.kf = p_kod_filii
                                 AND a.cust_id = c.cust_id
                                 AND c.report_date = p_report_date
                                 and c.kf = p_kod_filii
                                 AND b.ost <> 0
                                 and a.acc_id = w.acc(+)
                                 and r.report_date(+) = p_report_date
                                 AND r.kf(+) = p_kod_filii
                                 and a.acc_id = r.acc_id(+)) 
                                 UNPIVOT (VALUE FOR colname IN  
                                 (P01, P02, P03, P04, P05, P07, P08, P09, P10, 
                                  P11, P13, P14, P15, P16 
                                 ))) d;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F79 error: '
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
         FROM nbur_detail_protocols
      WHERE     report_date = p_report_date
            AND report_code = p_file_code
            AND kf = p_kod_filii;

    logger.info ('NBUR_P_F79 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F79.sql =========*** End **
PROMPT ===================================================================================== 
