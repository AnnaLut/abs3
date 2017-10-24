

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F48.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_F48 ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F48 (p_kod_filii        varchar2,
                                             p_report_date      date,
                                             p_form_id          number,
                                             p_scheme           varchar2 default 'C',
                                             p_balance_type     varchar2 default 'S',
                                             p_file_code        varchar2 default '#48')
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #48 ��� �������� �����
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.002  20.12.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.002  20.12.2016';
/*
   ��������� ��������� DD NN
   
  DD    -    ���� �������� ��������:
  
    10 - ����� ������������ �������� ����� ��� �������, ���, ��-������� ������� �����
    15 - ���������������� ��� (�����) �������� � ������ �� � ����
    16 - ��� ����� ��������
    17 - ��� ���� ��������� �������� �������� �����
    20 - ������ �������� ����� ��� ������ ��������� ���� ���������� ������� �����
    30 - ������ �������� �������� �����, �������� ���i ������� �����
    40 - ������� ����� (������) � ���������� ������
    51 - �������� ������� ����� (������)
    60 - ������� � ���������� ������ (����� ������)
    70 - ������� � ���������� ������ (�������������� ������)
    80 - ��������� ������� � ���������� ������ ��������

   NN    -   ������� ����� �������� ����� 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
    l_nbuc          varchar2(20);
    l_type          number;
    l_datez         date := p_report_date + 1;
    l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
    l_max_nnn       number := 0;
BEGIN
    logger.info ('NBUR_P_F48 begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
 
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
                         lpad(id, 2, '0') NNN,
                         trim(VAR_10) P10, trim(VAR_15) P15,
                         trim(VAR_16) P16, trim(VAR_17) P17,      
                         trim(VAR_20) P20, 
                         trim(VAR_30) P30, 
                         to_char(nvl(VAR_40, 0)) P40,
                         to_char(nvl(VAR_51, 0)) P51,
                         trim(to_char(nvl(VAR_60, 0), '99990.9999')) P60, 
                         trim(to_char(nvl(VAR_70, 0), '99990.9999')) P70,
                         trim(to_char(nvl(VAR_60, 0) + nvl(VAR_70, 0), '99990.9999')) P80
            from NBUR_KOR_DATA_F48
            where kf = p_kod_filii) 
            UNPIVOT (VALUE FOR colname IN (P10, P15, P16, P17, P20, P30, P40, P51, P60, P70, P80)) c 
            )
        where substr(field_code, 1, 2) not in ('60', '70', '80') or
              substr(field_code, 1, 2) in ('60', '70', '80') and to_number(field_value) <> 0;             

    logger.info ('NBUR_P_F48 end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F48.sql =========*** End **
PROMPT ===================================================================================== 
