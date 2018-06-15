PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F27X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_F27X ***

CREATE OR REPLACE PROCEDURE NBUR_P_F27X (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '27X')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ 27X ��� �������� �����
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.004  14/16/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.004  14/16/2017';
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
    l_koef          number; --����������� ������������ ������� ������
BEGIN
    logger.info ('NBUR_P_F27X begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

    --���������� ����. ������������ �������
    if p_report_date < date '2017-04-05'
    then
      l_koef := 0.65;
    else
      l_koef := 0.50;
    end if;

    BEGIN
       INSERT INTO nbur_detail_protocols (
                                           report_date
                                           , kf
                                           , report_code
                                           , nbuc
                                           , field_code
                                           , field_value
                                           , description
                                           , acc_id
                                           , acc_num
                                           , kv
                                           , maturity_date
                                           , cust_id
                                           , REF
                                           , nd
                                           , branch
                                         )
        SELECT d.report_date
               , d.kf
               , p_file_code
               , to_char(to_number(d.nbuc)) as nbuc
               , substr(d.colname, 2, 1)
                 || d.nbs
                 || lpad(d.kv, 3, '0')
                 as field_code
               , abs(d.value) field_value
               , NULL description
               , d.acc_id
               , d.acc_num
               , d.kv
               , null maturity_date
               , d.cust_id
               , null ref
               , NULL nd
               , d.branch
        FROM (
               SELECT  s.report_date
                       , s.kf
                       , a.cust_id
                       , a.acc_id
                       , a.acc_num
                       , a.kv
                       , a.nbs
                       , s.dos as s5
                       , s.kos as s6
                       , a.nbuc
                       , a.branch
              FROM     NBUR_DM_BALANCES_DAILY s
                       , NBUR_DM_ACCOUNTS a
              WHERE    s.report_date = p_report_date
                       and s.kf = p_kod_filii
                       and s.acc_id = a.acc_id
                       and a.report_date = p_report_date
                       and a.kf = p_kod_filii
                       and a.nbs = '2603'
                       and a.kv  NOT IN (980,959,961,962,964)
                       and s.dos+s.kos <> 0
            )
            UNPIVOT (VALUE FOR colname IN  (s5, s6)) d
        WHERE abs(d.value) <> 0;
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F27X error: '
             || SQLERRM
             || ' for date = '
             || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    BEGIN
      insert all
         --������� ������� ��������� "������� ��� ������������ ������� �������� ������" (��� 7)
         into nbur_detail_protocols (report_date, kf, report_code, nbuc, field_code, field_value, description, acc_id, acc_num, kv, maturity_date, cust_id, REF, nd, branch)
         values(report_date, kf, p_file_code, nbuc, '7' || field_code, field_value, description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
         --������� ��������� "���������� ����������� � �������� �����, �� � ����� ��� ���������� ���� ����'�������� �������" (��� 8)
         into nbur_detail_protocols (report_date, kf, report_code, nbuc, field_code, field_value, description, acc_id, acc_num, kv, maturity_date, cust_id, REF, nd, branch)
         values(report_date, kf, p_file_code, nbuc, '8' || field_code, trunc(field_value / l_koef), description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)

        SELECT d.report_date
               , d.kf
               , p_file_code
               , to_char(to_number(a.nbuc)) as nbuc
               , d.nbs
                 || lpad(d.kv, 3, '0') field_code
               , d.sump field_value
               , NULL description
               , d.acc_id
               , d.acc_num
               , d.kv
               , null maturity_date
               , d.cust_id
               , d.ref
               , NULL nd
               , null branch
        FROM   (
                   select t.report_date
                          , t.kf
                          , t.cust_id_db as cust_id
                          , t.acc_id_db as acc_id
                          , t.acc_num_db as acc_num
                          , t.r020_db nbs
                          , t.kv
                          , t.bal as sump
                          , t.ref
                   from   NBUR_DM_TRANSACTIONS t
                          , NBUR_DM_ADL_DOC_RPT_DTL r
                          , oper o
                   where  t.report_date = p_report_date
                          and t.kf = p_kod_filii
                          and r.report_date(+) = p_report_date
                          and r.kf(+) = p_kod_filii
                          and t.ref = r.ref(+)
                          and t.ref = o.ref
                          and t.kv not in (980, 959, 961, 962, 964)
                          and t.acc_num_db like '2603%'
                          and t.acc_num_cr not like '25%'
                          and t.acc_num_cr not like '26%'
                          and (
                                t.acc_num_cr like '2900%'
                                and t.ob22_cr = '04'
                                or r.d020 = '01'
                                or LOWER(o.nazn) like '%����%����%'
                                or LOWER(o.nazn) like '%��%�����%������%'
                                or LOWER(o.nazn) like '%�����_��_� �������%'
                         )
                   union all
                   select t.report_date
                          , t.kf
                          , t.cust_id_db as cust_id
                          , t.acc_id_db as acc_id
                          , t.acc_num_db as acc_num
                          , t.r020_db as nbs
                          , t.kv
                          , t.bal as sump
                          , t.ref
                   from   NBUR_DM_TRANSACTIONS t
                   where  t.report_date = p_report_date
                          and t.kf = p_kod_filii
                          and t.kv not in (980, 959, 961, 962, 964)
                          and
                              (
                                t.acc_num_db like '2909%'
                                and t.ob22_cr in ('55','56','75')
                                and t.acc_num_cr like '2900%'
                                and t.ob22_cr = '01'
                                or
                                t.acc_num_db like '1919%'
                                and t.ob22_cr = '02'
                                and t.acc_num_cr like '3800%'
                                and t.ob22_cr = '10'
                             )
               ) d
               join NBUR_DM_ACCOUNTS a on (a.report_date = p_report_date)
                                          and (a.kf = p_kod_filii)
                                          and (a.acc_id = d.acc_id);
    EXCEPTION
       WHEN OTHERS
       THEN
          logger.info (
                'NBUR_P_F27X error: '
             || SQLERRM
             || ' for date = '
             || TO_CHAR (p_report_date, 'dd.mm.yyyy'));
    END;

    -- ������������ ����������� �����  �  nbur_agg_protocols
    INSERT INTO nbur_agg_protocols (
                                     report_date
                                     , kf
                                     , report_code
                                     , nbuc
                                     , field_code
                                     , field_value
                                   )
       SELECT report_date
              , kf
              , report_code
              , nbuc
              , field_code
              , field_value
         FROM (
                SELECT report_date
                       , kf
                       , report_code
                       , nbuc
                       , field_code
                       , SUM (field_value) as field_value
                FROM   nbur_detail_protocols
                WHERE  report_date = p_report_date
                       AND report_code = p_file_code
                       AND kf = p_kod_filii
                GROUP BY
                       report_date
                       , kf
                       , report_code
                       , nbuc
                       , field_code
             );

    logger.info ('NBUR_P_F27X end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F27X.sql =========*** End *** =
PROMPT ===================================================================================== 