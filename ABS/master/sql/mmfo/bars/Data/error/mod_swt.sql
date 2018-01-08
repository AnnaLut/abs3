PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_SWT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ SWT ***
declare
  l_mod  varchar2(3) := 'SWT';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '��������� � SWIFT', 1);

    bars_error.add_message(l_mod, 40, l_exc, l_geo, 'Transaction sum not equal to documents sum (transaction sum %s, documents sum %s)', '', 1, 'CHK_DOCUMENT_DIFFAMOUNT');
    bars_error.add_message(l_mod, 40, l_exc, l_rus, '����� ���������� �� ����� ����� ���������� (����� ���������� %s, ����� ���������� %s)', '', 1, 'CHK_DOCUMENT_DIFFAMOUNT');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, '����� ���������� �� ����� ����� ���������� (����� ���������� %s, ����� ���������� %s)', '', 1, 'CHK_DOCUMENT_DIFFAMOUNT');

    bars_error.add_message(l_mod, 41, l_exc, l_geo, 'Transaction and document currency code not equal (transaction currency %s, document currency %s, document reference %s)', '', 1, 'CHK_DOCUMENT_DIFFCURRENCY');
    bars_error.add_message(l_mod, 41, l_exc, l_rus, '��� ������ ���������� � ��������� �� ��������� (������ ���������� %s, ������ ��������� %s, ���. ��������� %s)', '', 1, 'CHK_DOCUMENT_DIFFCURRENCY');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, '��� ������ ���������� � ��������� �� ��������� (������ ���������� %s, ������ ��������� %s, ���. ��������� %s)', '', 1, 'CHK_DOCUMENT_DIFFCURRENCY');

    bars_error.add_message(l_mod, 42, l_exc, l_geo, 'Transaction and document payment date not equal (transaction date %s, document date %s, document reference %s)', '', 1, 'CHK_DOCUMENT_DIFFVDATE');
    bars_error.add_message(l_mod, 42, l_exc, l_rus, '���� ������������� ���������� � ��������� �� ��������� (���� ���������� %s, ���� ��������� %s, ���. ��������� %s)', '', 1, 'CHK_DOCUMENT_DIFFVDATE');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, '���� ������������� ���������� � ��������� �� ��������� (���� ���������� %s, ���� ��������� %s, ���. ��������� %s)', '', 1, 'CHK_DOCUMENT_DIFFVDATE');

    bars_error.add_message(l_mod, 43, l_exc, l_geo, 'Document not connected with Nostro (document reference %s)', '', 1, 'CHK_DOCUMENT_DIFFACCOUNT');
    bars_error.add_message(l_mod, 43, l_exc, l_rus, '�������� �� ������ � ��������� ������� (���. ��������� %s)', '', 1, 'CHK_DOCUMENT_DIFFACCOUNT');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, '�������� �� ������ � ��������� ������� (���. ��������� %s)', '', 1, 'CHK_DOCUMENT_DIFFACCOUNT');

    bars_error.add_message(l_mod, 50, l_exc, l_geo, 'Error on statement reconciliation ref. %s: %s', '', 1, 'STMT_PARSE_ERROR');
    bars_error.add_message(l_mod, 50, l_exc, l_rus, '������ ��� ������� ������� ���. %s: %s', '', 1, 'STMT_PARSE_ERROR');

    bars_error.add_message(l_mod, 51, l_exc, l_geo, 'Incorrect statement error registration mode [%s]', '', 1, 'INVALID_PARSEERROR_MODE');
    bars_error.add_message(l_mod, 51, l_exc, l_rus, '�������� ����� ����������� ������ ������� [%s]', '', 1, 'INVALID_PARSEERROR_MODE');

    bars_error.add_message(l_mod, 52, l_exc, l_geo, 'Line %s statement SWIFT ref. %s already linked with document(s)', '', 1, 'STMT_ROWDOC_ALREADY_LINKED');
    bars_error.add_message(l_mod, 52, l_exc, l_rus, '������ %s ������� SWIFT ���. %s ��� ������� � ����������(���)', '', 1, 'STMT_ROWDOC_ALREADY_LINKED');

    bars_error.add_message(l_mod, 53, l_exc, l_geo, 'Line %s statement SWIFT ref. %s not linked with document(s)', '', 1, 'STMT_ROWDOC_NOTLINKED');
    bars_error.add_message(l_mod, 53, l_exc, l_rus, '������ %s ������� SWIFT ���. %s �� ������� � ����������(���)', '', 1, 'STMT_ROWDOC_NOTLINKED');

    bars_error.add_message(l_mod, 60, l_exc, l_geo, 'Statement line not found (ref. %s line  %s)', '', 1, 'STMT_ROW_NOTFOUND');
    bars_error.add_message(l_mod, 60, l_exc, l_rus, '�� ������� ������ ������� (���. %s ������  %s)', '', 1, 'STMT_ROW_NOTFOUND');

    bars_error.add_message(l_mod, 61, l_exc, l_geo, 'Statement locked other user, repeat attempt later (ref. %s line %s)', '', 1, 'STMT_ROW_LOCKED');
    bars_error.add_message(l_mod, 61, l_exc, l_rus, '������� ������������� ������ �������������, ��������� ������� ����� (���. %s ������  %s)', '', 1, 'STMT_ROW_LOCKED');

    bars_error.add_message(l_mod, 62, l_exc, l_geo, 'Document ref. %s not found', '', 1, 'IMPMSG_DOCUMENT_NOTFOUND');
    bars_error.add_message(l_mod, 62, l_exc, l_rus, '�������� ���. %s �� ������', '', 1, 'IMPMSG_DOCUMENT_NOTFOUND');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, '�������� ���. %s �� ������', '', 1, 'IMPMSG_DOCUMENT_NOTFOUND');

    bars_error.add_message(l_mod, 63, l_exc, l_geo, 'Statement line not linked with out message (statement %s line %s)', '', 1, 'STMT_SRCMSG_NOTLINKED');
    bars_error.add_message(l_mod, 63, l_exc, l_rus, '������ ������� �� ������� � ���. ���������� (������� %s ������ %s)', '', 1, 'STMT_SRCMSG_NOTLINKED');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, '������ ������� �� ������� � ���. ���������� (������� %s ������ %s)', '', 1, 'STMT_SRCMSG_NOTLINKED');

    bars_error.add_message(l_mod, 64, l_exc, l_geo, 'Statement line already linked with out message (statement %s line %s)', '', 1, 'STMT_SRCMSG_ALREADY_LINKED');
    bars_error.add_message(l_mod, 64, l_exc, l_rus, '������ ������� ��� ������� � ���. ���������� (������� %s ������ %s)', '', 1, 'STMT_SRCMSG_ALREADY_LINKED');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, '������ ������� ��� ������� � ���. ���������� (������� %s ������ %s)', '', 1, 'STMT_SRCMSG_ALREADY_LINKED');

    bars_error.add_message(l_mod, 65, l_exc, l_geo, 'List linked document of out message and statement line not equal (statement %s line %s out.message %s)', '', 1, 'STMT_SRCMSG_NOTEQ_DOCLISTS');
    bars_error.add_message(l_mod, 65, l_exc, l_rus, '������ ����������� ���������� ���. ��������� � ������ ������� �� ��������� (������� %s ������ %s ���. ����. %s)', '', 1, 'STMT_SRCMSG_NOTEQ_DOCLISTS');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, '������ ����������� ���������� ���. ��������� � ������ ������� �� ��������� (������� %s ������ %s ���. ����. %s)', '', 1, 'STMT_SRCMSG_NOTEQ_DOCLISTS');

    bars_error.add_message(l_mod, 66, l_exc, l_geo, 'Basic message and statement line attributes not equal (statement %s line %s out.message %s)', '', 1, 'STMT_SRCMSG_REQDIFF');
    bars_error.add_message(l_mod, 66, l_exc, l_rus, '�������� ��������� ��������� � ������ ������� �� ��������� (������� %s ������ %s ���. ����. %s)', '', 1, 'STMT_SRCMSG_REQDIFF');
    bars_error.add_message(l_mod, 66, l_exc, l_ukr, '�������� ��������� ��������� � ������ ������� �� ��������� (������� %s ������ %s ���. ����. %s)', '', 1, 'STMT_SRCMSG_REQDIFF');

    bars_error.add_message(l_mod, 70, l_exc, l_rus, '�������� ������ ���. ��������� "f"', '', 1, 'GENMSG_INVALID_MTFORMAT');
    bars_error.add_message(l_mod, 70, l_exc, l_ukr, '�������� ������ ���. ��������� "f"', '', 1, 'GENMSG_INVALID_MTFORMAT');

    bars_error.add_message(l_mod, 71, l_exc, l_rus, '����������� ������ ��������� %s', '', 1, 'GENMSG_UNKNOWN_MT');
    bars_error.add_message(l_mod, 71, l_exc, l_ukr, '����������� ������ ��������� %s', '', 1, 'GENMSG_UNKNOWN_MT');

    bars_error.add_message(l_mod, 72, l_exc, l_rus, '�� ������ ���. �������� ��������� "f"', '', 1, 'GENMSG_REQMT_NOTFOUND');
    bars_error.add_message(l_mod, 72, l_exc, l_ukr, '�� ������ ���. �������� ��������� "f"', '', 1, 'GENMSG_REQMT_NOTFOUND');

    bars_error.add_message(l_mod, 73, l_exc, l_rus, '��� ������������� ���� %s', '', 1, 'DOCMSG_MANDATORYFIELD_NOTFOUND');
    bars_error.add_message(l_mod, 73, l_exc, l_ukr, '����� ������������ ���� %s', '', 1, 'DOCMSG_MANDATORYFIELD_NOTFOUND');

    bars_error.add_message(l_mod, 74, l_exc, l_rus, '������� ����� ����� ����� ���� %s ������������', '', 1, 'DOCMSG_TOOMANYOPTIONS_FOUND');
    bars_error.add_message(l_mod, 74, l_exc, l_ukr, '������� ����� ����� ����� ���� %s ������������', '', 1, 'DOCMSG_TOOMANYOPTIONS_FOUND');

    bars_error.add_message(l_mod, 75, l_exc, l_rus, '���������������� ��� ��� ������������� (%s)', '', 1, 'DOCMSG_UNKNOWN_SPECTAG');
    bars_error.add_message(l_mod, 75, l_exc, l_ukr, '���������������� ��� ��� ������������� (%s)', '', 1, 'DOCMSG_UNKNOWN_SPECTAG');

    bars_error.add_message(l_mod, 76, l_exc, l_rus, '�� ������� �������� ���� (��� ���������: %s ���� :%s)', '', 1, 'DOCMSG_MSGMODEL_TAGNOTFOUND');
    bars_error.add_message(l_mod, 76, l_exc, l_ukr, '�� ������� �������� ���� (��� ���������: %s ���� :%s)', '', 1, 'DOCMSG_MSGMODEL_TAGNOTFOUND');

    bars_error.add_message(l_mod, 202, l_exc, l_rus, 'C02: ��� ������ � ����� 71G � 32A ������ ���������', '', 1, 'DOCMSG_MSGCHK_C02');
    bars_error.add_message(l_mod, 202, l_exc, l_ukr, 'C02: ��� ������ � ����� 71G � 32A ������ ���������', '', 1, 'DOCMSG_MSGCHK_C02');

    bars_error.add_message(l_mod, 281, l_exc, l_rus, 'C81: ���� 57a ������ ���� ���������, ���� ��������� ���� 56a', '', 1, 'DOCMSG_MSGCHK_C81');
    bars_error.add_message(l_mod, 281, l_exc, l_ukr, 'C81: ���� 57a ������ ���� ���������, ���� ��������� ���� 56a', '', 1, 'DOCMSG_MSGCHK_C81');

    bars_error.add_message(l_mod, 350, l_exc, l_rus, 'D50: ������������� ���� 71G ��������� ��� �������� SHA ���� 71A', '', 1, 'DOCMSG_MSGCHK_D50');
    bars_error.add_message(l_mod, 350, l_exc, l_ukr, 'D50: ������������� ���� 71G ��������� ��� �������� SHA ���� 71A', '', 1, 'DOCMSG_MSGCHK_D50');

    bars_error.add_message(l_mod, 351, l_exc, l_rus, 'D51: �� ��������� ���� 33B ��� ����������� ���� 71F ��� 71G', '', 1, 'DOCMSG_MSGCHK_D51');
    bars_error.add_message(l_mod, 351, l_exc, l_ukr, 'D51: �� ��������� ���� 33B ��� ����������� ���� 71F ��� 71G', '', 1, 'DOCMSG_MSGCHK_D51');

    bars_error.add_message(l_mod, 367, l_exc, l_rus, 'D67: ������� ������������ ��������� ����� � ���� 23E (%s, %s)', '', 1, 'DOCMSG_MSGCHK_D67');
    bars_error.add_message(l_mod, 367, l_exc, l_ukr, 'D67: ������� ������������ ��������� ����� � ���� 23E (%s, %s)', '', 1, 'DOCMSG_MSGCHK_D67');

    bars_error.add_message(l_mod, 375, l_exc, l_rus, 'D75: �� ��������� ���� 36 ��� ��������� ���� ������ � ����� 33B � 32A ��� ��������� ���� 36 ��� ������������ 33B', '', 1, 'DOCMSG_MSGCHK_D75');
    bars_error.add_message(l_mod, 375, l_exc, l_ukr, 'D75: �� ��������� ���� 36 ��� ��������� ���� ������ � ����� 33B � 32A ��� ��������� ���� 36 ��� ������������ 33B', '', 1, 'DOCMSG_MSGCHK_D75');

    bars_error.add_message(l_mod, 398, l_exc, l_rus, 'D98: �������� ������������������ ����� � ���� 23E', '', 1, 'DOCMSG_MSGCHK_D98');
    bars_error.add_message(l_mod, 398, l_exc, l_ukr, 'D98: �������� ������������������ ����� � ���� 23E', '', 1, 'DOCMSG_MSGCHK_D98');

    bars_error.add_message(l_mod, 401, l_exc, l_rus, 'E01: ������������ ��� � ���� 23E ��� �������� SPRI � ���� 23B', '', 1, 'DOCMSG_MSGCHK_E01');
    bars_error.add_message(l_mod, 401, l_exc, l_ukr, 'E01: ������������ ��� � ���� 23E ��� �������� SPRI � ���� 23B', '', 1, 'DOCMSG_MSGCHK_E01');

    bars_error.add_message(l_mod, 402, l_exc, l_rus, 'E02: ������������� ���� 23E ��������� ��� �������� ���� 23B SSTD ��� SPAY', '', 1, 'DOCMSG_MSGCHK_E02');
    bars_error.add_message(l_mod, 402, l_exc, l_ukr, 'E02: ������������� ���� 23E ��������� ��� �������� ���� 23B SSTD ��� SPAY', '', 1, 'DOCMSG_MSGCHK_E02');

    bars_error.add_message(l_mod, 403, l_exc, l_rus, 'E03: ������������� ���� 53D ��������� ��� �������� ���� 23B SPRI, SSTD ��� SPAY', '', 1, 'DOCMSG_MSGCHK_E03');
    bars_error.add_message(l_mod, 403, l_exc, l_ukr, 'E03: ������������� ���� 53D ��������� ��� �������� ���� 23B SPRI, SSTD ��� SPAY', '', 1, 'DOCMSG_MSGCHK_E03');

    bars_error.add_message(l_mod, 404, l_exc, l_rus, 'E04: ������������ ������������� ���� 53B ��� �������� ���� 23B SPRI, SSTD ��� SPAY', '', 1, 'DOCMSG_MSGCHK_E04');
    bars_error.add_message(l_mod, 404, l_exc, l_ukr, 'E04: ������������ ������������� ���� 53B ��� �������� ���� 23B SPRI, SSTD ��� SPAY', '', 1, 'DOCMSG_MSGCHK_E04');

    bars_error.add_message(l_mod, 405, l_exc, l_rus, 'E05: ������������ ����� ���� 54a ��� �������� ���� 23B SPRI, SSTD ��� SPAY', '', 1, 'DOCMSG_MSGCHK_E05');
    bars_error.add_message(l_mod, 405, l_exc, l_ukr, 'E05: ������������ ����� ���� 54a ��� �������� ���� 23B SPRI, SSTD ��� SPAY', '', 1, 'DOCMSG_MSGCHK_E05');

    bars_error.add_message(l_mod, 406, l_exc, l_rus, 'E06: �� ��������� ���� 53a ��� 54a ��� ����������� ���� 55a', '', 1, 'DOCMSG_MSGCHK_E06');
    bars_error.add_message(l_mod, 406, l_exc, l_ukr, 'E06: �� ��������� ���� 53a ��� 54a ��� ����������� ���� 55a', '', 1, 'DOCMSG_MSGCHK_E06');

    bars_error.add_message(l_mod, 407, l_exc, l_rus, 'E07: ������������ ����� ���� 55a ��� �������� ���� 23B SPRI, SSTD ��� SPAY', '', 1, 'DOCMSG_MSGCHK_E07');
    bars_error.add_message(l_mod, 407, l_exc, l_ukr, 'E07: ������������ ����� ���� 55a ��� �������� ���� 23B SPRI, SSTD ��� SPAY', '', 1, 'DOCMSG_MSGCHK_E07');

    bars_error.add_message(l_mod, 409, l_exc, l_rus, 'E09: ��� �������� SSTD ��� SPAY � ���� 23B ��������� ������ ����� A, C, D(� �������� ����) ���� 57a', '', 1, 'DOCMSG_MSGCHK_E09');
    bars_error.add_message(l_mod, 409, l_exc, l_ukr, 'E09: ��� �������� SSTD ��� SPAY � ���� 23B ��������� ������ ����� A, C, D(� �������� ����) ���� 57a', '', 1, 'DOCMSG_MSGCHK_E09');

    bars_error.add_message(l_mod, 410, l_exc, l_rus, 'E10: �� ��������� ������� "����" � ���� 59a ��� �������� ���� 23B SPRI, SSTD ��� SPAY', '', 1, 'DOCMSG_MSGCHK_E10');
    bars_error.add_message(l_mod, 410, l_exc, l_ukr, 'E10: �� ��������� ������� "����" � ���� 59a ��� �������� ���� 23B SPRI, SSTD ��� SPAY', '', 1, 'DOCMSG_MSGCHK_E10');

    bars_error.add_message(l_mod, 412, l_exc, l_rus, 'E12: ������������� ������������� ����� 70 � 77T ���������', '', 1, 'DOCMSG_MSGCHK_E12');
    bars_error.add_message(l_mod, 412, l_exc, l_ukr, 'E12: ������������� ������������� ����� 70 � 77T ���������', '', 1, 'DOCMSG_MSGCHK_E12');

    bars_error.add_message(l_mod, 413, l_exc, l_rus, 'E13: ������������� ���� 71F ��������� ��� �������� OUR ���� 71A', '', 1, 'DOCMSG_MSGCHK_E13');
    bars_error.add_message(l_mod, 413, l_exc, l_ukr, 'E13: ������������� ���� 71F ��������� ��� �������� OUR ���� 71A', '', 1, 'DOCMSG_MSGCHK_E13');

    bars_error.add_message(l_mod, 415, l_exc, l_rus, 'E15: ��� �������� BEN ���� 71� ���� 71F ������������, ������������� ���� 71G ���������', '', 1, 'DOCMSG_MSGCHK_E15');
    bars_error.add_message(l_mod, 415, l_exc, l_ukr, 'E15: ��� �������� BEN ���� 71� ���� 71F ������������, ������������� ���� 71G ���������', '', 1, 'DOCMSG_MSGCHK_E15');

    bars_error.add_message(l_mod, 416, l_exc, l_rus, 'E16: ����������� ���� 56a ��� �������� SPRI � ���� 23B', '', 1, 'DOCMSG_MSGCHK_E16');
    bars_error.add_message(l_mod, 416, l_exc, l_ukr, 'E16: ����������� ���� 56a ��� �������� SPRI � ���� 23B', '', 1, 'DOCMSG_MSGCHK_E16');

    bars_error.add_message(l_mod, 417, l_exc, l_rus, 'E17: ��� �������� SSTD ��� SPAY � ���� 23B ���� 56a ������ �������������� � ������� � ��� �', '', 1, 'DOCMSG_MSGCHK_E17');
    bars_error.add_message(l_mod, 417, l_exc, l_ukr, 'E17: ��� �������� SSTD ��� SPAY � ���� 23B ���� 56a ������ �������������� � ������� � ��� �', '', 1, 'DOCMSG_MSGCHK_E17');

    bars_error.add_message(l_mod, 418, l_exc, l_rus, 'E18: ������������� ������� "����" � ���� 59a ��������� ��� ������� ���� CHQB � ���� 23E', '', 1, 'DOCMSG_MSGCHK_E18');
    bars_error.add_message(l_mod, 418, l_exc, l_ukr, 'E18: ������������� ������� "����" � ���� 59a ��������� ��� ������� ���� CHQB � ���� 23E', '', 1, 'DOCMSG_MSGCHK_E18');

    bars_error.add_message(l_mod, 444, l_exc, l_rus, 'E44: ��� ���������� ���� 56a ����������� ������������� ����� TELI, PHOI � ���� 23E', '', 1, 'DOCMSG_MSGCHK_E44');
    bars_error.add_message(l_mod, 444, l_exc, l_ukr, 'E44: ��� ���������� ���� 56a ����������� ������������� ����� TELI, PHOI � ���� 23E', '', 1, 'DOCMSG_MSGCHK_E44');

    bars_error.add_message(l_mod, 445, l_exc, l_rus, 'E45: ��� ���������� ���� 57a ����������� ������������� ����� TELE, PHON � ���� 23E', '', 1, 'DOCMSG_MSGCHK_E45');
    bars_error.add_message(l_mod, 445, l_exc, l_ukr, 'E45: ��� ���������� ���� 57a ����������� ������������� ����� TELE, PHON � ���� 23E', '', 1, 'DOCMSG_MSGCHK_E45');

    bars_error.add_message(l_mod, 446, l_exc, l_rus, 'E46: ������� ������������� ���� � ���� 23E', '', 1, 'DOCMSG_MSGCHK_E46');
    bars_error.add_message(l_mod, 446, l_exc, l_ukr, 'E46: ������� ������������� ���� � ���� 23E', '', 1, 'DOCMSG_MSGCHK_E46');

    bars_error.add_message(l_mod, 500, l_exc, l_rus, 'TXX: ��� ���������� ���� 26T �� ��������� ���� 77B', '', 1, 'DOCMSG_MSGCHK_TXX');
    bars_error.add_message(l_mod, 500, l_exc, l_ukr, 'TXX: ��� ���������� ���� 26T �� ��������� ���� 77B', '', 1, 'DOCMSG_MSGCHK_TXX');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_SWT.sql =========*** Run *** ==
PROMPT ===================================================================================== 
