PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_ARC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ ARC ***
declare
  l_mod  varchar2(3) := 'ARC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '��������� ������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '�������� %s �� ������', '', 1, 'PARAM_NOT_FOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '�������� %s �� ���������', '', 1, 'PARAM_NOT_FOUND');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '������ � �������� ��������� %s', '', 1, 'INVALID_PARAM_VALUE');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '������� � ������� ��������� %s', '', 1, 'INVALID_PARAM_VALUE');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '������� ������� ��������� ������� ������������ (��������� %s)', '', 1, 'INVALID_MARKAREA_STATE');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '������ �������� ���� ������ ��������� (���� %s)', '', 1, 'INVALID_MARKAREA_STATE');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '������� ������� ����� ��������� ������� ������������ (��������� ������� %s, ����� %s)', '', 1, 'INVALID_MARKAREA_NEWSTATE');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '������ �������� ����� ���� ������ ��������� (�������� ���� %s, ����� ���� %s)', '', 1, 'INVALID_MARKAREA_NEWSTATE');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '���������� �������� ������� ������������ - ���� �������� ��������', '', 1, 'MARKAREA_BUSY');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '��������� �������� ������ ��������� - � ������ �������', '', 1, 'MARKAREA_BUSY');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '���������� ��������� �������� ��� ������� ��������� ������� ������������', '', 1, 'INVALID_MARKAREA_CSTATE');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '��������� �������� �������� ��� ��������� ���� ������ ���������', '', 1, 'INVALID_MARKAREA_CSTATE');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, '������ %s �� ������', '', 1, 'MODULE_NOT_FOUND');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, '������ %s �� ���������', '', 1, 'MODULE_NOT_FOUND');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '������ %s ��� ����������', '', 1, 'MODULE_EXISTS');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, '������ %s ��� ����', '', 1, 'MODULE_EXISTS');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, '��� ���� �� ���������� ������ %s', '', 1, 'MODULE_NOT_EXEC');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, '���� ���� �� ��������� ������ %s', '', 1, 'MODULE_NOT_EXEC');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, '�� ������� ��������� ������������ ��� ������ "%s"', '', 1, 'MARKPROC_NOT_FOUND');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, '�� �������� ��������� ���������� ��� ������ "%s"', '', 1, 'MARKPROC_NOT_FOUND');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, '��� ������ "%s" �� ��������� �� ���� ������', '', 1, 'NO_OBJECT_IN_MODULE');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, '��� ������ "%s" �� �������� ������ ��''���', '', 1, 'NO_OBJECT_IN_MODULE');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, '������ %s �� ������', '', 1, 'OBJECT_NOT_FOUND');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, '��''��� %s �� ���������', '', 1, 'OBJECT_NOT_FOUND');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, '������ %s ��� ����������', '', 1, 'OBJECT_EXISTS');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, '��''��� %s ��� ����', '', 1, 'OBJECT_EXISTS');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, '�� ������� ������� ������������ "%s" ��� ������� "%s"', '', 1, 'OBJECT_MARKTAB_NOT_EXISTS');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, '�� �������� ������� ���������� "%s" ��� ��''���� "%s"', '', 1, 'OBJECT_MARKTAB_NOT_EXISTS');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, '�� ������� ��������� �������� "%s" ���  ������� "%s"', '', 1, 'OBJECT_MOVEPROC_NOT_EXISTS');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, '�� �������� ��������� �������� "%s" ��� ��''���� "%s"', '', 1, 'OBJECT_MOVEPROC_NOT_EXISTS');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, '��� ������� "%s" �� ���������� �� ���� �������� �������', '', 1, 'OBJECT_HISTTAB_NOT_EXISTS');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, '��� ��''���� "%s" �� ��������� ����� ������� �������', '', 1, 'OBJECT_HISTTAB_NOT_EXISTS');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, '��� ������� "%s" �� ���������� �� ���� �������� �������', '', 1, 'OBJECT_SRCTAB_NOT_DEFINED');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, '��� ��''���� "%s" �� ��������� ����� ������ �������', '', 1, 'OBJECT_SRCTAB_NOT_DEFINED');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, '�� ������� �������� ������� "%s"', '', 1, 'OBJECT_SRCTAB_NOT_EXISTS');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, '�� ������� ������� ������ "%s"', '', 1, 'OBJECT_SRCTAB_NOT_EXISTS');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, '�� ������� �������� ���� "%s" �������� ������� "%s"', '', 1, 'OBJECT_SRCTABKEY_NOT_EXISTS');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, '�� �������� ������� ���� "%s" ������ ������i "%s"', '', 1, 'OBJECT_SRCTABKEY_NOT_EXISTS');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, '�� ������� �������� ������� "%s"', '', 1, 'OBJECT_HTAB_NOT_EXISTS');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, '�� �������� ������� ������� "%s"', '', 1, 'OBJECT_HTAB_NOT_EXISTS');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, '�� ������� ������� ������ ���������� "%s" ��� �������� ������� "%s"', '', 1, 'OBJECT_HTAB_FLTR_NOT_EXISTS');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, '�� �������� ������� ������ ��������i� "%s" ��� ������� ������i "%s"', '', 1, 'OBJECT_HTAB_FLTR_NOT_EXISTS');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, '�� ������� �������� ���� "%s" ��������� ������������� "%s"', '', 1, 'OBJECT_HTAB_SKEY_NOT_EXISTS');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, '�� �������� ������� ���� "%s" ������ ������i "%s"', '', 1, 'OBJECT_HTAB_SKEY_NOT_EXISTS');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, '�� ������� �������� ���� "%s" ��������� ������������� "%s"', '', 1, 'OBJECT_HTAB_SKEY_NULL');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, '�� ������� ������� ���� "%s" ������ ������i "%s"', '', 1, 'OBJECT_HTAB_SKEY_NULL');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, '��� ���������� "%s" ��� �������� ������� "%s"', '', 1, 'OBJECT_HTAB_GRNT_NOT_EXISTS');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, '���� ��������i� "%s" ��� ������� ������i "%s"', '', 1, 'OBJECT_HTAB_GRNT_NOT_EXISTS');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, '�� ��������� ��������� ��������� ������������� "%s" � �������� ������� "%s"', '', 1, 'OBJECT_HTAB_SRCV_INCONS');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, '�� ��i����� ��������� ������ ������i "%s" �� ������� ������i "%s"', '', 1, 'OBJECT_HTAB_SRCV_INCONS');

    bars_error.add_message(l_mod, 100, l_exc, l_rus, '�� ������ ���� ���������', '', 1, 'ARCDATE_NOT_DEFINED');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, '�� ������� ���� ���������', '', 1, 'ARCDATE_NOT_DEFINED');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, '������� �������� �������� ���������', '', 1, 'BUSY_STEP_FOUND');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, '������� ������ ������� ���������', '', 1, 'BUSY_STEP_FOUND');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, '������������ ��������� ����', '', 1, 'INVALID_STEP_STATE');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, '������������� ���� �����', '', 1, 'INVALID_STEP_STATE');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, '��������� ���� �� ������', '', 1, 'STEP_PARAM_NOT_DEFINED');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, '��������� ����� �� �����', '', 1, 'STEP_PARAM_NOT_DEFINED');

    bars_error.add_message(l_mod, 105, l_exc, l_rus, '��������� ����������� ��������� [%s] [%s] [%s] [%s]', '', 1, 'INCONSISTENT_STEP_STATE');
    bars_error.add_message(l_mod, 105, l_exc, l_ukr, '��������� �������� ����� [%s] [%s] [%s] [%s]', '', 1, 'INCONSISTENT_STEP_STATE');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, '���������� ����� �� ������������� ������������', '', 1, 'INVALID_MARKOBJ_ROWS');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, 'ʳ������ ����� �� ������� ��������', '', 1, 'INVALID_MARKOBJ_ROWS');

    bars_error.add_message(l_mod, 150, l_exc, l_rus, '��������������� ��������� ������ %s � %s', '', 1, 'INCONSISTENT_TABLES');
    bars_error.add_message(l_mod, 150, l_exc, l_ukr, '�� ������� ��������� ������� %s �� %s', '', 1, 'INCONSISTENT_TABLES');

    bars_error.add_message(l_mod, 201, l_exc, l_rus, '���� %s / %s (%s) ��� �������������', '', 1, 'ACC_ALREADY_MARKED');
    bars_error.add_message(l_mod, 201, l_exc, l_ukr, '������� %s / %s (%s) ��� ��������������', '', 1, 'ACC_ALREADY_MARKED');

    bars_error.add_message(l_mod, 202, l_exc, l_rus, '�������� � %s ��� �������������', '', 1, 'DOC_ALREADY_MARKED');
    bars_error.add_message(l_mod, 202, l_exc, l_ukr, '�������� � %s ��� ��������������', '', 1, 'DOC_ALREADY_MARKED');

    bars_error.add_message(l_mod, 203, l_exc, l_rus, '���������� ������� ����������� ���� �%s (%s) � ������������� %s ��� �������������', '', 1, 'DPT_ALREADY_MARKED');
    bars_error.add_message(l_mod, 203, l_exc, l_ukr, '���������� ������ ������� ����� �%s (%s) � ������� %s ��� ��������������', '', 1, 'DPT_ALREADY_MARKED');

    bars_error.add_message(l_mod, 204, l_exc, l_rus, '���������� ������� ����������� ���� � %s (%s) � ������������� %s ��� �������������', '', 1, 'SOC_ALREADY_MARKED');
    bars_error.add_message(l_mod, 204, l_exc, l_ukr, '���������� ������ ������� ����� �%s (%s) � ������� %s ��� ��������������', '', 1, 'SOC_ALREADY_MARKED');

    bars_error.add_message(l_mod, 205, l_exc, l_rus, '���������� ������� ������������ ���� �%s ��� �������������', '', 1, 'DPU_ALREADY_MARKED');
    bars_error.add_message(l_mod, 205, l_exc, l_ukr, '���������� ������ �������� ����� �%s ��� ��������������', '', 1, 'DPU_ALREADY_MARKED');

    bars_error.add_message(l_mod, 206, l_exc, l_rus, '�������� � %s �� �����������', '', 1, 'INVALID_DOC_STATE_VISA');
    bars_error.add_message(l_mod, 206, l_exc, l_ukr, '�������� � %s �� ����������', '', 1, 'INVALID_DOC_STATE_VISA');

    bars_error.add_message(l_mod, 207, l_exc, l_rus, '�������� � %s �� ��������', '', 1, 'INVALID_DOC_STATE_SIGN');
    bars_error.add_message(l_mod, 207, l_exc, l_ukr, '�������� � %s �� ���������', '', 1, 'INVALID_DOC_STATE_SIGN');

    bars_error.add_message(l_mod, 208, l_exc, l_rus, '�������� � %s �� ������� � ��� Oracle', '', 1, 'INVALID_DOC_STATE_ODB');
    bars_error.add_message(l_mod, 208, l_exc, l_ukr, '�������� � %s �� ��������� � ��� Oracle', '', 1, 'INVALID_DOC_STATE_ODB');

    bars_error.add_message(l_mod, 9999, l_exc, l_rus, '���������� ������ ������ %s %s %s %s', '', 1, 'INTERNAL_ERROR');
    bars_error.add_message(l_mod, 9999, l_exc, l_ukr, '�������� ������� ������ %s %s %s %s', '', 1, 'INTERNAL_ERROR');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_ARC.sql =========*** Run *** ==
PROMPT ===================================================================================== 
