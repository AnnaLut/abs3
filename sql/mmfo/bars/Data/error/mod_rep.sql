PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_REP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ REP ***
declare
  l_mod  varchar2(3) := 'REP';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '����������, ���.�������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '������ �� ������: %s: %s', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '����� �� ��������: %s: %s', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '������ ��� ��������� ��������� %s: %s', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '������� ��������� ��������� %s: %s', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '�� ������� ������� %s', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '�� �������� ������� %s', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '����������� ��������� ������ SELECT ��� ������', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '���������� ������ ����� SELECT ��� ��i��', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '����������� ����� ��� ���� %s - %s, ������� ���� ����� �� (DATE, VARCHAR2, CHAR, NUMBER) ', '������������ ��������� �� �������� ��������� DBF', 1, 'NOTCORRECT_DATATYPE');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '���������� ������ ��� ���� %s - %s, ������� ���� ����� � (DATE, VARCHAR2, CHAR, NUMBER)', '����������� ����� �� ��������� ��������� DBF    ', 1, 'NOTCORRECT_DATATYPE');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '���� ������ ���.������� ������ �������� ���������� ��� � ������ ��� � �����', '1', 1, '6');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '���� ������ ���.������ ������� �������� _�������_� ��� ��� ������ ��� ��� ����', '1', 1, '6');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '����������� ��� ���������������� ��� DBF ���� %s', '1', 1, '7');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '���_����� ��� DBF ���� %s ��� ��� ��� �� �_���������� ', '1', 1, '7');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '���������� ��������� �������� %s � ����� � ������ %s ������� %s ��� ������� � ������� %s', '1', 1, '8');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '��������� ��������� �������� %s � ����� � ����� %s ������i %s ��� ������� � ������� %s', '1', 1, '8');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, '���������� ��������� �������� %s � ������� ���� � ������ %s, ������� %s ��� ������� � ������� %s', '1', 1, '9');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '��������� ��������� �������� %s �� ������� ���� � ����� %s, ������i %s  ��� ������� � ������� %s', '1', 1, '9');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '���������� ���� %s, �� F � �� T � ������ %s ������� %s  ��� ������� � ������� %s', '1', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '���_��� ���� %s, �� F _ �� T � ����� %s ������i %s  ��� ������� � ������� %s', '1', 1, '10');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '��������� ����� ����� � SQL ������� �� ��������� � ���-��� ����� � �������� ���������', '1', 1, '11');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '������� ����� ���_� � SQL �����_ �� ��_����� � �_�-�� ���_� � ����_ ���������', '1', 1, '11');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '��������� ��������� %s - �����������. ������ ���� ����� �� (WIN,DOS,UKG)', '1', 1, '12');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '������� ��������� %s - ����������. ������ ���� ����� � (WIN,DOS,UKG)', '1', 1, '12');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '����������� ���������� �������� ���������� ��������� ������ %s', '1', 1, '13');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '���������� ���������� �������� �������� ����.���� %s ', '1', 1, '13');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '����� �������� ������ %s -  ��� ����������', '1', 1, '14');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '����� ����. ���� %s -  ���� ����', '1', 1, '14');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, '���������� �������� ��� ��������� ������ �� ������ ���. ������� � %s', '1', 1, '15');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, '�� ����� ���. ������� %s �� ��������� �� ���� �������� �����', '', 1, '16');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '�� ����� ���.������ %s �� �������� � ���� ���������� ���', '', 1, '16');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, '����������� ������ ����� �����: %s', '', 1, '17');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, '���������� ������ ����� �����: %s', '', 1, '17');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, '����������� ������ ������ ����: %s', '', 1, '18');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, '���������� ������ ������ ����: %s', '', 1, '18');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, '���-�� ����� � SQL-� (%s) �� ��������� � ���-��� ����� ��������� � ��������� DBF (%s)', '', 1, 'WRONG_COLCNT');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'ʳ���-�� ���� � SQL (%s) �� ������� � ����-�� ����, �� ������� � �������� DBF (%s)', '', 1, 'WRONG_COLCNT');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '��� ������� %s(%s) � �������� DBF ��������� �� ��������� � ����� ������� � SQL-�(%s)', '', 1, 'WRONG_COLTYPES');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, '��� ������� %s(%s) � ���� DBF ��������� �� ������� � ����� ������� � SQL-�(%s)', '', 1, 'WRONG_COLTYPES');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '��� ������ ������ ���� LOGICAL �� ����� �� ������ �� �������� (0,1,F,T). �������� ��������-%s', '1', 1, '21');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, '��� ������ ������ ���� LOGICAL �� ���� � ������ �� �������(0,1,F,T). ������� ��������-%s', '1', 1, '21');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '�� ���������������� ���������� �����', '', 1, '22');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, '�� ���������� ����� ��� �����', '', 1, '22');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, '������������ ��� ������� %s ��� ORACLE', '1', 1, '23');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, '����������� ��`� ������� %s ��� ORACLE', '1', 1, '23');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, '���������� ������� ���� %s � ����� ���������� %s ', '1', 1, '24');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, '��������� ������� ���� %s � ����� �������� %s', '1', 1, '24');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, '������ �����. �������� %s ��� �������, ���� ������� ���������� (��������� �������� - 0,1,2,3)', '1', 1, '25');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, '������� ��������� �������� %s ��� 䳿 ���� ������� ���� (������ ������� - 0,1,2,3)', '1', 1, '25');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, '��������� ����� ����� %s ��� memo ���� �� ���������� ��� ������� %s', '1', 1, '26');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, '��������� ����� ����� %s ��� memo ���� �� ����  ��� ������i %s', '1', 1, '26');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, '������ ����� memo %s �� ������ 512. ��������� - �����������', '1', 1, '27');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, '����� ����� memo %s �� ������ 512. ��������� - �����������', '1', 1, '27');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, '� ����� DBF ��������� ����� ������ ���� ���� - �� ��������������', '1', 1, '28');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, '� ���� DBF ����������� ����� ������ ���� ���� - �� �����������', '1', 1, '28');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, '�� ��������� ��� ������ �����������', '', 1, '29');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, '�� ��������� ��� ������ �����������', '', 1, '29');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, '�� ��������� ��������� ��������� ��� %s �� %s', '', 1, '30');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, '�� �������� ��������� ������i��� ��� %s �� %s', '', 1, '30');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '�� ��������� ������ ������ �� ���������� ���������� ��� ����� %s', '1', 1, '31');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, '�� �������� ����� ���� �� ���������� ����������  ��� ������� %s', '1', 1, '31');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, '������� ��� ����������� �����������', '', 1, '32');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, '������� ��� ����������� ���������', '', 1, '32');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, '���   ������  �����������', '', 1, '33');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, '���� ������  ���������', '', 1, '33');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, '���������� ���� �������� - PO1, PO3 ', '', 1, '34');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, '��������  ���� �������� - PO1, PO3 ', '', 1, '34');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, '����� ����� %s �� ������ ���������� � �������� % � _ ', '1', 1, '35');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, '����� ������� %s �� ������� ���������� � ������� % �� _', '1', 1, '35');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, '���������� ����� �����(������� 3 ������� �����������)', '1', 1, '36');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, '������ ����� �������(����� 3 ������� � �����������)', '1', 1, '36');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, '����� ����� %s ����� ��������� ������� %s ������� �����', '', 1, '37');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, '����� �������  %s ������� ������ ����� %s ������� ����', '', 1, '37');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, '������ ����� ���� �� ������ 30 ����', '', 1, '38');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, '����� ����  ���� �� ����� 30 ���', '', 1, '38');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, '��� �������� ���� ����� ����� ���������� ������� AND ��� OR � ������ �-��� validate_two_nlsmasks', '', 1, '39');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, '��� �������� ���� ����� ������� ��������� ������� AND ��� OR � ����� �-��� validate_two_nlsmasks', '', 1, '39');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, '������ ��� ����� ����� ������� �����: ', '', 1, '40');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, '������� ��� ���� ����� ������� �������:', '', 1, '40');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, '������ ��� ����� ����� ������� �����: %s', '', 1, '41');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, '������� ��� ���� ����� ������� �������: %s', '', 1, '41');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, '���� �� ��� ������ ����� � ���������� ����� ������ ��������� ������� %s ������� �����', '', 1, '42');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, '���� � ��� ������ ������� � ���������� ����� ������� ������ ����� %s ������ ����', '', 1, '42');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, '��� ��������� ��������� ������� ���� ������ %s ������ �������� ���� %s', '', 1, '43');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, '��� ��������� ������� ������ ���� ������� %s ����� �� ������ ���� %s', '', 1, '43');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, '��� ������� ������, ������ ������� ��� �� ������ ��������� %s ����, ��������� ���� ������ ���������� %s ����', '', 1, '44');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, '��� ������ ����, ����� ������� ��� �� ������� ������������ %s ���, �������� ���� ����� ������� %s ���', '', 1, '44');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, '�� ������ ��� �������������', '', 1, 'BRANCH_IS_NULL');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, '�� ������� ��� ��������', '', 1, 'BRANCH_IS_NULL');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, '��� ������������������ ��������� %s �� ������ ��������� �������� � ��� = %s', '', 1, 'NO_ORIGIN_DOC');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, '��� ����������������� ��������e %s �� ��������� ��������� �������� � ��� = %s', '', 1, 'NO_ORIGIN_DOC');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, '� �������� ��������� DBF ���� ����������� ������ ��� �������� ����������� ����', '', 1, 'NO_CLOSE_BRACKET');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, '� ���� ��������� DBF ���� ���������� ������ ��� ����� ������ ����', '', 1, 'NO_CLOSE_BRACKET');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, '� �������� dbf ����� ���������� ����� ���� ���� ����', '', 1, 'NOT_CORRECT_DBFSTRUCT');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, '� �������� dbf ����� ���������� ����� ���� ���� ����', '', 1, 'NOT_CORRECT_DBFSTRUCT');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, '����������� ������ DBF ����� %s �� ����������(������ ���� � ��������� �����)', '', 1, 'NOT_CORRECT_DBFTYPE');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, '������� ����� DBF ����� %s �� ����(������ ���� � ��������� �����)', '', 1, 'NOT_CORRECT_DBFTYPE');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, '��������� ������ DBF ����� %s (������ ���� � ���������) �� ������������ ���� ���, ���� � �������� ��������� ������������ ���� ���� ���� ��� ������� %s', '', 1, 'NOT_CORRECT_DBFMEMO');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, '������� ����� DBF ����� %s (������ ���� � ��������� �����) �� �������� ���� ���, ��� � ���� ��������� ����� ������� ���� ���� ���� ��� ������� %s', '', 1, 'NOT_CORRECT_DBFMEMO');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, '���������� ��������� �������� %s � �����(������ �� ���� ����) � ������ %s ������� %s ��� ������� � ������� %s', '', 1, 'NOT_CORRECT_MEMOREF');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, '��������� ��������� �������� %s � �����(��������� �� ���� ����)  � ����� %s ������i %s ��� ������� � ������� %s', '', 1, 'NOT_CORRECT_MEMOREF');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, '������ ������������ �� ����� 4-� ����� ����, � ������������� ��������� %s � �����', '', 1, 'TO_MANY_MEMOS');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, '������ ������� �� ����� 4-� ���� ����, � ����������� ��������� %s � ���� %s', '', 1, 'TO_MANY_MEMOS');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, '���������� ���������� ������� - ������', '', 1, 'RESULT_ISEMPTY');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, '����� ���������� ������ - �������', '', 1, 'RESULT_ISEMPTY');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, '�� ���������� ������ ������ ������������� ������� ��� ������� %s', '', 1, 'NO_SUCH_SQLID');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, '�� ���� ������ ������ ���������� ������ ��� ������� %s', '', 1, 'NO_SUCH_SQLID');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, '�� ���������� ������������ � ������� ������� %s', '', 1, 'NO_SUCH_USERNAME');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, '�� ���� �����������  %s', '', 1, 'NO_SUCH_USERNAME');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, '����������� ������� ��������� %s - ������ ���� ����� �� WIN, UKG', '', 1, 'UNKNOWN_ENCODE');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, '����������� ������� ��������� %s - ������� ���� ����� �� WIN, UKG', '', 1, 'UNKNOWN_ENCODE');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, '��� ������������� ���� ������� ������ ������� %s, ��� ���������� ������� ������ ������� ����� %s (�������� �����, ��� �-�� �������� �� ������� ������� � ������� ������', '', 1, 'NOTCORRECT_LIST');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, '��� ������������� ���� ������� ������ ������� %s, ��� ���������� ������� ������ ������� ����� %s (�������� �����, ��� �-�� �������� �� ������� ������� � ������� ������', '', 1, 'NOTCORRECT_LIST');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, '������������ �������� ��� ��������� ��� ��������� � ������ %s. ������ ���� ���� �� N ��� Y', '', 1, 'NOT_CORRECT_USEVP');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, '���������� �������� ��� ��������� ��� ���������� �� ������� %s. ������� ���� ����� � N ��� Y', '', 1, 'NOT_CORRECT_USEVP');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, '�������� ���� �������� %s �� ���������� � �����������', '', 1, 'NOT_SUCH_KODU');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, '�������� ���� �������� %s �� ���� � ��������', '', 1, 'NOT_SUCH_KODU');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, '%s, ������: s%', '', 1, 'CANNOT_EXEC_SQL');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, '%s, �������: s%', '', 1, 'CANNOT_EXEC_SQL');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, '���������� ���������� �������: %s', '', 1, 'CANNOT_INSERT_DATA');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, '��������� �������� �������: %s', '', 1, 'CANNOT_INSERT_DATA');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, '������ ������ �� ����� ������, ��� ������� ���������� ��� : %s', '', 1, 'LARGE_VALUE');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, '������� ������ i� ���i� ������ �i� ������� � ��������i ��� : s%', '', 1, 'LARGE_VALUE');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, '%s', '', 1, 'GENERIC_ERROR');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, '%s', '', 1, 'GENERIC_ERROR');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, '������������� ��������: ���-�� ����� � ������� �� ��������� � ���-��� ����� ��������� � ��������� DBF �����', '', 1, 'CH_WRONG_COLCNT');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, '������������ ��������: ����-�� ���� � ������� �� ������� � ����-�� ����, �� ������� � �������� DBF �����', '', 1, 'CH_WRONG_COLCNT');

    bars_error.add_message(l_mod, 65, l_exc, l_rus, '������������� ��������: ��� ������� � �������� DBF ����� �� ��������� � ����� ������� � �������', '', 1, 'CH_WRONG_COLTYPES');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, '������������ ��������: ��� ������� � ���� DBF ����� �� ������� � ����� ������� � �������', '', 1, 'CH_WRONG_COLTYPES');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_REP.sql =========*** Run *** ==
PROMPT ===================================================================================== 
