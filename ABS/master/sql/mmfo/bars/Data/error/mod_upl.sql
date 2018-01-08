PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_UPL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ UPL ***
declare
  l_mod  varchar2(3) := 'UPL';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�������� ������ ��� �������������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '������������ ��� ������ ��� ������� %s: %s ', '', 1, 'NOT_CORRECT_DATATYPE');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '����������� ��� ����� ��� ������� %s: %s ', '', 1, 'NOT_CORRECT_DATATYPE');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '��� ���� ������� %s �� ������������� ���������', '', 1, 'NO_SUCH_DATATYPE');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '��� ���� ������� %s �� ������������� ���������', '', 1, 'NO_SUCH_DATATYPE');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '�� ���������� ���������� ������ %s ', '', 1, 'NO_SUCH_ORADIR');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '�� ���������� ���������� ������ %s ', '', 1, 'NO_SUCH_ORADIR');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '������� �� ������� %s ��� ����� %s', '', 1, 'NO_SUCH_TABLE');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '������� �� ������� %s ��� ����� %s', '', 1, 'NO_SUCH_TABLE');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '�� ������ ��� ������������ ����� %s', '', 1, 'NO_SUCH_FILE_ID');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�� ������ ��� ������������ ����� %s', '', 1, 'NO_SUCH_FILE_ID');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '�� ������ ������ ��� ����� � ����� %s', '', 1, 'NO_SQL_FOR_FILEID');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '�� ������ ������ ��� ����� � ����� %s', '', 1, 'NO_SQL_FOR_FILEID');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '���������� ��������� ������ %s', '', 1, 'CANN_NOT_PARSE_SQL');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '���������� ��������� ������ %s', '', 1, 'CANN_NOT_PARSE_SQL');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '��c���������� ���������, ��������� ��� ������� � ��� �������: %s', '', 1, 'UNCOMPATIBLE_STRUCTS');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '��c���������� ���������, ��������� ��� ������� � ��� �������: %s', '', 1, 'UNCOMPATIBLE_STRUCTS');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, '� ������� �� ������ �������� ORACLE_DIR ��� ��������', '', 1, 'NO_ORADIR_PARAMETER');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '� ������� �� ������ �������� ORACLE_DIR ��� ��������', '', 1, 'NO_ORADIR_PARAMETER');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '� ������� �� ������ �������� REGION_PRFX(������� �������) ��� ��������', '', 1, 'NO_REGION_PRFX_PARAMETER');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '� ������� �� ������ �������� REGION_PRFX(������� �������) ��� ��������', '', 1, 'NO_REGION_PRFX_PARAMETER');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '�� ������ ��� ����� ��� �������� %s', '', 1, 'NO_SUCH_FILE_CODE');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '�� ������ ��� ����� ��� �������� %s', '', 1, 'NO_SUCH_FILE_CODE');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '%s', '', 1, 'ERROR_MESS');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '%s', '', 1, 'ERROR_MESS');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '������������ ����������� pl/sql <��> ��� ������� %s, %s', '', 1, 'NOT_CORRECT_SQL_BEFORE');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '������������ ����������� pl/sql <��> ��� ������� %s, %s', '', 1, 'NOT_CORRECT_SQL_BEFORE');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '�� ���������� �������� ��� �������� - ��������� ������� ��������(SYS_DIR)', '', 1, 'NO_SYSDIR_PARAMETER');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '�� ���������� �������� ��� �������� - ��������� ������� ��������(SYS_DIR)', '', 1, 'NO_SYSDIR_PARAMETER');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, '���������� ������� ���� ��� ������ %s � ���������� %s', '', 1, 'CANNOT_OPEN_FILE_FOR_W');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, '���������� ������� ���� ��� ������ %s � ���������� %s', '', 1, 'CANNOT_OPEN_FILE_FOR_W');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, '� ������� �� ������ �������� FTP_PATH ��� ��������', '', 1, 'NO_FTPPATH_PARAM');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '� ������� �� ������ �������� FTP_PATH ��� ��������', '', 1, 'NO_FTPPATH_PARAM');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, '� ������� �� ������ �������� ZIP_PATH ��� ��������', '', 1, 'NO_ZIPPATH_PARAM');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, '� ������� �� ������ �������� ZIP_PATH ��� ��������', '', 1, 'NO_ZIPPATH_PARAM');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, '� ������� �� ������ �������� FTP_DOMAIN ��� ��������', '', 1, 'NO_FTPDOMAIN_PARAM');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, '� ������� �� ������ �������� FTP_DOMAIN ��� ��������', '', 1, 'NO_FTPDOMAIN_PARAM');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, '� ������� �� ������ �������� FTP_PASSWORD ��� ��������', '', 1, 'NO_FTPPASSWORD_PARAM');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, '� ������� �� ������ �������� FTP_PASSWORD ��� ��������', '', 1, 'NO_FTPPASSWORD_PARAM');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '� ������� �� ������ �������� FTPCLI_PATH ��� ��������', '', 1, 'NO_FTPCLIPATH_PARAM');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, '� ������� �� ������ �������� FTPCLI_PATH ��� ��������', '', 1, 'NO_FTPCLIPATH_PARAM');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '� ������� �� ������ �������� ORACLE_ARC_DIR ��� ��������', '', 1, 'NO_ORAARCDIR_PARAMETER');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, '� ������� �� ������ �������� ORACLE_ARC_DIR ��� ��������', '', 1, 'NO_ORAARCDIR_PARAMETER');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '�������� �� %s, ������ %s ��� ����������� � ���� ������� ���������, ������ %s', '', 1, 'WAS_YET_UPLOADED');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, '�������� �� %s, ������ %s ��� ����������� � ���� ������� ���������, ������ %s', '', 1, 'WAS_YET_UPLOADED');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, '������ ������ ��� ��������� ��������� 4�b', '', 1, 'FILE_LIST_ISTOOLONG');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, '������ ������ ��� ��������� ��������� 4�b', '', 1, 'FILE_LIST_ISTOOLONG');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, '��� ��������� ����������', '', 1, 'NO_GROUP_INFORMATION');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, '��� ��������� ����������', '', 1, 'NO_GROUP_INFORMATION');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, '��������� ������������ ������ ���� (����� ��������) %s', '', 1, 'NOT_CORRECT_DATE');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, '��������� ������������ ������ ���� (����� ��������) %s', '', 1, 'NOT_CORRECT_DATE');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, '� ������� �� ������ �������� UPL_INIT_ID(��� ������ ��� ��������� ��������) ��� ��������', '', 1, 'NO_INITID_PARAM');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, '� ������� �� ������ �������� UPL_INIT_ID(��� ������ ��� ��������� ��������) ��� ��������', '', 1, 'NO_INITID_PARAM');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, '� ������� �� ������ �������� UPL_INCR_ID(��� ������ ��� ��������������� ��������) ��� ��������', '', 1, 'NO_INCRID_PARAM');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, '� ������� �� ������ �������� UPL_INCR_ID(��� ������ ��� ��������������� ��������) ��� ��������', '', 1, 'NO_INCRID_PARAM');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, '�������� �� %s, ������ %s ��� ��� � ������ ������, ������ %s', '', 1, 'STILL_UPLOADING');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, '�������� �� %s, ������ %s ��� ��� � ������ ������, ������ %s', '', 1, 'STILL_UPLOADING');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, '�������� �� %s, ������ %s ����������� � ��������, ������ %s', '', 1, 'UPLOADED_WITH_ERRORS');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, '�������� �� %s, ������ %s ����������� � ��������, ������ %s', '', 1, 'UPLOADED_WITH_ERRORS');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, '����������� ������ ���������� �������� �� %s, ������ %s ����������� � ��������, ������ %s', '', 1, 'UNKNOWN_STATUS');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, '����������� ������ ���������� �������� �� %s, ������ %s ����������� � ��������, ������ %s', '', 1, 'UNKNOWN_STATUS');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '%s', '', 1, 'GENERAL_ERROR');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, '%s', '', 1, 'GENERAL_ERROR');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, '�� �������� ����i����� ���� ��� ������������', '', 1, 'NO_BANKDATE_TO_UPLOAD');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, '�� �������� ����i����� ���� ��� ������������', '', 1, 'NO_BANKDATE_TO_UPLOAD');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, '����i����� ���� %s ��� ���� �����������', '', 1, 'BANKDATE_WAS_UPLOADED');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, '����i����� ���� %s ��� ���� �����������', '', 1, 'BANKDATE_WAS_UPLOADED');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, '����i����� ���� %s � ����i� ������������', '', 1, 'BANKDATE_IN_UPLOADING');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, '����i����� ���� %s � ����i� ������������', '', 1, 'BANKDATE_IN_UPLOADING');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, '�������� %s ��� ������� %s ������ ���� �������� ���������', '', 1, 'NOT_NUMERIC');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, '�������� %s ��� ������� %s ������� ���� �������� ���������', '', 1, 'NOT_NUMERIC');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, '��� ������� %s �� ������ �������� ������ ��������', '', 1, 'NO_GROUPID_FOR_JOB');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, '��� ��������� %s �� ������� �������� ������ ������������', '', 1, 'NO_GROUPID_FOR_JOB');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, '������������ ��� ������� %s', '', 1, 'NO_CORRECT_KF');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, '����������� ��� ������ %s', '', 1, 'NO_CORRECT_KF');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, '���������� ��������� �������� �� ��������������� ������', '', 1, 'USER_NOT_LOGING');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, '��������� �������� �� ��� ������������� ������', '', 1, 'USER_NOT_LOGING');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_UPL.sql =========*** Run *** ==
PROMPT ===================================================================================== 
