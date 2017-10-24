

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F95.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F95 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F95 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#95')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #39 ��� �������� �����
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.001  18.11.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.001 18.11.2016';
/*
   ��������� ��������� DD NNN

  DD    -    ���� �������� ��������:
    01 - ����� ���������� �����
    02 - ̳�������������� ���������� �����
    03 - ���������������� ���
    04 - ��� ������������ ���������� �����
    05 - ���� ������� ������� ���������� �����
    06 - ³�������� ���������� ����� �� �����
    07 - ����� ���������� ����� ���������� ����� �� ����� ����
    08 - ³������ ����� ����� �� ���� ������� ������� ���������� �����
    09 - ³������ �������������� ����� �� ���� ������� ������� ���������� �����
    10 - ³������ ����� ����� ���������� ����� �� ����� ����
    11 - ³������ �������������� ����� ���������� ����� �� ����� ����


   NNN    -    ������� ���������� ����� �������� (����� ����������� �������� ������) � ����� ������� ���.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_max_nnn       number := 0;
BEGIN
    logger.info ('NBUR_P_F95 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

    -- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
    nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

    -- ���� �� ������������, �� ������������ �� ����� ��������
    INSERT INTO nbur_agg_protocols (report_date,
                                    kf,
                                    report_code,
                                    nbuc,
                                    field_code,
                                    field_value)
    select report_date,
           kf,
           p_file_code,
           l_nbuc,
           field_code,
           field_value
    from (select c.report_date, c.kf,
                   substr(c.colname, 2, 3)||c.nnn field_code,
                   c.value field_value
            from (select p_report_date report_date, KF,
                         lpad(id, 3, '0') NNN,
                         trim(VAR_01) P01, trim(VAR_02) P02,
                         trim(VAR_03) P03, trim(VAR_04) P04,
                         to_char(VAR_05, 'ddmmyyyy') P05,
                         trim(VAR_06) P06, to_char(VAR_07) P07,
                         trim(to_char(VAR_08, '99990.9999')) P08,
                         trim(to_char(VAR_09, '99990.9999')) P09,
                         trim(to_char(VAR_10, '99990.9999')) P10,
                         trim(to_char(VAR_11, '99990.9999')) P11
            from NBUR_KOR_DATA_F95
            where kf = p_kod_filii)
            UNPIVOT (VALUE FOR colname IN (P01, P02, P03, P04, P05, P06, P07, P08, P09, P10, P11)) c
            );

    logger.info ('NBUR_P_F95 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F95.sql =========*** End **
PROMPT ===================================================================================== 
