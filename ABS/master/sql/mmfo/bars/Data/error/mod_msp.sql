PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/data/error/mod_msp.sql =========*** Run *** ==
PROMPT ===================================================================================== 

PROMPT *** Create grant ***
grant execute on bars_error to MSP;
grant execute on bars_audit to MSP;
grant execute on bars_login to MSP;

PROMPT *** Create/replace ERR ������ MSP ***
declare
  l_mod  varchar2(3) := 'MSP';
  l_ukr  varchar2(3) := 'UKR';
  l_rus  varchar2(3) := 'RUS';
  l_eng  varchar2(3) := 'ENG';
  l_exc  number := -20000;
begin
  bars.bars_error.add_module(l_mod,'̳��������� ��������� �������',1);
  bars.bars_error.add_lang(l_rus,'�������');
  bars.bars_error.add_lang(l_ukr,'���������');
  bars.bars_error.add_lang(l_eng,'English');

  -- msp_utl
  bars.bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������� ��������� ������� �����. ³������ ���� � ����� ����� p_file_id=%s', '', 1, 'UNKNOWN_FILE_STATUS');
  bars.bars_error.add_message(l_mod, 1, l_exc, l_rus, '������ ���������� ������� �����. ����������� ���� � ����� ����� p_file_id=%s', '', 1, 'UNKNOWN_FILE_STATUS');
  bars.bars_error.add_message(l_mod, 1, l_exc, l_eng, 'Error updating file status. Missing file with code p_file_id=%s', '', 1, 'UNKNOWN_FILE_STATUS');

  bars.bars_error.add_message(l_mod, 2, l_exc, l_ukr, '������� ��������� ������� �����. %s', '', 1, 'ERRUPD_FILE_STATUS');
  bars.bars_error.add_message(l_mod, 2, l_exc, l_rus, '������ ���������� ������� �����. %s', '', 1, 'ERRUPD_FILE_STATUS');
  bars.bars_error.add_message(l_mod, 2, l_exc, l_eng, 'Error updating file status. %s', '', 1, 'ERRUPD_FILE_STATUS');

  bars.bars_error.add_message(l_mod, 3, l_exc, l_ukr, '������� ��������� ������� �������������� ����� �����. ³������ ����� � ����� ����� p_file_record_id=%s', '', 1, 'UNKNOWN_FILEREC_STATUS');
  bars.bars_error.add_message(l_mod, 3, l_exc, l_rus, '������ ���������� ������� �������������� ������ �����. ����������� ������ � ����� ����� p_file_record_id=%s', '', 1, 'UNKNOWN_FILEREC_STATUS');
  bars.bars_error.add_message(l_mod, 3, l_exc, l_eng, 'Error updating file record status. Missing record with code p_file_record_id=%s', '', 1, 'UNKNOWN_FILEREC_STATUS');

  bars.bars_error.add_message(l_mod, 4, l_exc, l_ukr, '������� ��������� ������� �������������� ����� �����. %s', '', 1, 'ERRUPD_FILEREC_STATUS');
  bars.bars_error.add_message(l_mod, 4, l_exc, l_rus, '������ ���������� ������� �������������� ������ �����. %s', '', 1, 'ERRUPD_FILEREC_STATUS');
  bars.bars_error.add_message(l_mod, 4, l_exc, l_eng, 'Error updating file record status. %s', '', 1, 'ERRUPD_FILEREC_STATUS');

  bars.bars_error.add_message(l_mod, 5, l_exc, l_ukr, '������� � �������� �������� ����� ������ �� ����������� ���������� ������. %s', '', 1, 'ERROR_CHECKING_FILEREC');
  bars.bars_error.add_message(l_mod, 5, l_exc, l_rus, '������ � ��������� �������� ����� ������ �� ���������� ���������� ������. %s', '', 1, 'ERROR_CHECKING_FILEREC');
  bars.bars_error.add_message(l_mod, 5, l_exc, l_eng, 'Error checking file record. %s', '', 1, 'ERROR_CHECKING_FILEREC');

  bars.bars_error.add_message(l_mod, 6, l_exc, l_ukr, '������� ���������� ����� ��������� �����. %s', '', 1, 'ERROR_CREATE_FILE');
  bars.bars_error.add_message(l_mod, 6, l_exc, l_rus, '������ ���������� ������ ��������� �����. %s', '', 1, 'ERROR_CREATE_FILE');
  bars.bars_error.add_message(l_mod, 6, l_exc, l_eng, 'Error create file. %s', '', 1, 'ERROR_CREATE_FILE');

  bars.bars_error.add_message(l_mod, 7, l_exc, l_ukr, '������� ���������� ����� �������������� ����� �����. %s', '', 1, 'ERROR_CREATE_FILEREC');
  bars.bars_error.add_message(l_mod, 7, l_exc, l_rus, '������ ���������� ������ �������������� ������ �����. %s', '', 1, 'ERROR_CREATE_FILEREC');
  bars.bars_error.add_message(l_mod, 7, l_exc, l_eng, 'Error create file record. %s', '', 1, 'ERROR_CREATE_FILEREC');

  bars.bars_error.add_message(l_mod, 8, l_exc, l_ukr, '������� ���������� ����� �������������� ����� �����. ³������ ����� � ����� ����� p_file_id=%s', '', 1, 'UNKNOWN_FILE_RECORD');
  bars.bars_error.add_message(l_mod, 8, l_exc, l_rus, '������ ���������� ������ �������������� ������ �����. ����������� ������ � ����� ����� p_file_id=%s', '', 1, 'UNKNOWN_FILE_RECORD');
  bars.bars_error.add_message(l_mod, 8, l_exc, l_eng, 'Error create file record. Missing record with code p_file_id=%s', '', 1, 'UNKNOWN_FILE_RECORD');

  bars.bars_error.add_message(l_mod, 9, l_exc, l_ukr, '������� �������� ��������� �����. ³������ ���� � ����� ����� p_file_id=%s', '', 1, 'UNKNOWN_MATCHING_HEADER');
  bars.bars_error.add_message(l_mod, 9, l_exc, l_rus, '������ ���������� ��������� �����. ����������� ���� � ����� ����� p_file_id=%s', '', 1, 'UNKNOWN_MATCHING_HEADER');
  bars.bars_error.add_message(l_mod, 9, l_exc, l_eng, 'Error create file report header. Missing file with code p_file_id=%s', '', 1, 'UNKNOWN_MATCHING_HEADER');

  bars.bars_error.add_message(l_mod, 10, l_exc, l_ukr, '������� �������� ��������� �����. %s', '', 1, 'ERROR_MATCHING_HEADER');
  bars.bars_error.add_message(l_mod, 10, l_exc, l_rus, '������ ���������� ��������� �����. %s', '', 1, 'ERROR_MATCHING_HEADER');
  bars.bars_error.add_message(l_mod, 10, l_exc, l_eng, 'Error create file report header. %s', '', 1, 'ERROR_MATCHING_HEADER');

  bars.bars_error.add_message(l_mod, 11, l_exc, l_ukr, '������� �������� �����. ³������ ���� � ����� ����� p_file_id=%s', '', 1, 'UNKNOWN_MATCHING_BODY');
  bars.bars_error.add_message(l_mod, 11, l_exc, l_rus, '������ ���������� �����. ����������� ���� � ����� ����� p_file_id=%s', '', 1, 'UNKNOWN_MATCHING_BODY');
  bars.bars_error.add_message(l_mod, 11, l_exc, l_eng, 'Error create file report. Missing file with code p_file_id=%s', '', 1, 'UNKNOWN_MATCHING_BODY');

  bars.bars_error.add_message(l_mod, 12, l_exc, l_ukr, '������� �������� �����. %s', '', 1, 'ERROR_MATCHING_BODY');
  bars.bars_error.add_message(l_mod, 12, l_exc, l_rus, '������ ���������� �����. %s', '', 1, 'ERROR_MATCHING_BODY');
  bars.bars_error.add_message(l_mod, 12, l_exc, l_eng, 'Error create file report. %s', '', 1, 'ERROR_MATCHING_BODY');

  bars.bars_error.add_message(l_mod, 13, l_exc, l_ukr, '������� ���������� ���������. ��������������� ��� ������ ���� ��������� �� ����������. p_matching_tp=%s', '', 1, 'UNKNOWN_MATCHING');
  bars.bars_error.add_message(l_mod, 13, l_exc, l_rus, '������ ������������ ���������. ���������������� ��� ������� ���� ��������� �� �����������. p_matching_tp=%s', '', 1, 'UNKNOWN_MATCHING');
  bars.bars_error.add_message(l_mod, 13, l_exc, l_eng, 'Error create matching report. Missing implementation for p_matching_tp=%s', '', 1, 'UNKNOWN_MATCHING');

  bars.bars_error.add_message(l_mod, 14, l_exc, l_ukr, '������� ���������� ���������-%s. %s', '', 1, 'ERROR_MATCHING');
  bars.bars_error.add_message(l_mod, 14, l_exc, l_rus, '������ ���������� ���������-%s. %s', '', 1, 'ERROR_MATCHING');
  bars.bars_error.add_message(l_mod, 14, l_exc, l_eng, 'Error create matching report-%s. %s', '', 1, 'ERROR_MATCHING');

  bars.bars_error.add_message(l_mod, 15, l_exc, l_ukr, '������� ������ ����������� ����� �� �����. ³������ ����� � ����� ����� p_content_id=%s', '', 1, 'UNKNOWN_FILE_CONTENT');
  bars.bars_error.add_message(l_mod, 15, l_exc, l_rus, '������ ������ ������������� ������ �� �����. ����������� ������ � ����� ����� p_content_id=%s', '', 1, 'UNKNOWN_FILE_CONTENT');
  bars.bars_error.add_message(l_mod, 15, l_exc, l_eng, 'Error write file content. Missing record with code p_content_id=%s', '', 1, 'UNKNOWN_FILE_CONTENT');

  bars.bars_error.add_message(l_mod, 16, l_exc, l_ukr, '������� ������ ����������� ����� �� �����. �� �����, ��� �� ���� ����� ��������� p_content_type_id=%s, p_file_id=%s', '', 1, 'UNKNOWN_FILECONTENT_PARAMETER');
  bars.bars_error.add_message(l_mod, 16, l_exc, l_rus, '������ ������ ������������� ������ �� �����. �� ������, ��� �� ����� ������ ��������� p_content_type_id=%s, p_file_id=%s', '', 1, 'UNKNOWN_FILECONTENT_PARAMETER');
  bars.bars_error.add_message(l_mod, 16, l_exc, l_eng, 'Error write file content. No parameters specified p_content_type_id=%s, p_file_id=%s', '', 1, 'UNKNOWN_FILECONTENT_PARAMETER');

  bars.bars_error.add_message(l_mod, 17, l_exc, l_ukr, '������� ������ ����������� ����� �� �����. %s', '', 1, 'ERRWRITE_FILE_CONTENT');
  bars.bars_error.add_message(l_mod, 17, l_exc, l_rus, '������ ������ ������������� ������ �� �����. %s', '', 1, 'ERRWRITE_FILE_CONTENT');
  bars.bars_error.add_message(l_mod, 17, l_exc, l_eng, 'Error write file content. %s', '', 1, 'ERRWRITE_FILE_CONTENT');

  bars.bars_error.add_message(l_mod, 18, l_exc, l_ukr, '������� ���������� ����������� �������. �������� �� ������.', '', 1, 'UNKNOWN_CONTEXT_USER');
  bars.bars_error.add_message(l_mod, 18, l_exc, l_rus, '������ ����������� ������������ �������. �������� �� ����������.', '', 1, 'UNKNOWN_CONTEXT_USER');
  bars.bars_error.add_message(l_mod, 18, l_exc, l_eng, 'Unknown context user', '', 1, 'UNKNOWN_CONTEXT_USER');

  bars.bars_error.add_message(l_mod, 19, l_exc, l_ukr, '������� ���������� ����������� �������. %s', '', 1, 'ERR_CONTEXT_USER');
  bars.bars_error.add_message(l_mod, 19, l_exc, l_rus, '������ ����������� ������������ ������� %s', '', 1, 'ERR_CONTEXT_USER');
  bars.bars_error.add_message(l_mod, 19, l_exc, l_eng, 'Error get context user %s', '', 1, 'ERR_CONTEXT_USER');

  bars.bars_error.add_message(l_mod, 20, l_exc, l_ukr, '������� ��������� ������� �������������� ����� ����� �� "��������". %s', '', 1, 'ERR_SET_RECORD_PAYED');
  bars.bars_error.add_message(l_mod, 20, l_exc, l_rus, '������ ���������� ������� �������������� ������ �� "��������" %s', '', 1, 'ERR_SET_RECORD_PAYED');
  bars.bars_error.add_message(l_mod, 20, l_exc, l_eng, 'Error set record "Payed" %s', '', 1, 'ERR_SET_RECORD_PAYED');

  bars.bars_error.add_message(l_mod, 21, l_exc, l_ukr, '������� ��������� ������� �������������� ����� ����� �� "��������� � ���". %s', '', 1, 'ERR_SET_RECORD_ERROR');
  bars.bars_error.add_message(l_mod, 21, l_exc, l_rus, '������ ���������� ������� �������������� ������ �� "���������� � ���" %s', '', 1, 'ERR_SET_RECORD_ERROR');
  bars.bars_error.add_message(l_mod, 21, l_exc, l_eng, 'Error set record "Returned to MSP" %s', '', 1, 'ERR_SET_RECORD_ERROR');

  commit;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/data/err/mod_msp.sql =========*** Run *** ==
PROMPT ===================================================================================== 
