CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FD5X (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_file_code        varchar2 default 'D5X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ D5X ��� �������� �����
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.007  11/12/2018 (26/11/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                   char(30)  := 'v.1.007  11/12/2018';
  c_title                constant varchar2(100 char) := $$PLSQL_UNIT || '. ';
  c_date_fmt             constant varchar2(10 char) := 'dd.mm.yyyy';
  c_old_file_code        constant varchar2(3 char) := '#D5';
  c_sleep_time           constant number := 30; --����� �������� ����� ������� ��������

  l_nbuc                 varchar2(20);
  l_type                 number;
  l_datez                date := p_report_date + 1;
  l_file_code            varchar2(2) := substr(p_file_code, 2, 2);
  l_version_id           nbur_lst_files.version_id%type;
  l_next_mnth_frst_dt    date;
  l_ret                  number;

  c_XXXXXX               constant varchar2(6 char) := 'XXXXXX';

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);

  --���������� ������ ����� ��� �������� ����������� ���������
  l_version_id := coalesce(
                            f_nbur_get_run_version(
                                                    p_file_code => p_file_code
                                                    , p_kf => p_kod_filii
                                                    , p_report_date => p_report_date
                                                  )
                            , -1
                          );
  logger.trace(c_title || ' ����� ����� - ' || l_version_id);

  l_next_mnth_frst_dt := last_day(trunc(p_report_date)) + 1;
  logger.trace(c_title || '����� ���� ���������� ����� - ' || to_char(l_next_mnth_frst_dt, c_date_fmt));

  -- ������� ���������� ������� �����
  nbur_waiting_form(p_kod_filii, p_report_date, c_old_file_code, c_title);

  -- ���� ��������� ����� ���������� � ����� ��������� ���������� ����� P_FD5_NN

  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/