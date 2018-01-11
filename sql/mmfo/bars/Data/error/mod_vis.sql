PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_VIS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ VIS ***
declare
  l_mod  varchar2(3) := 'VIS';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�����������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_geo, 'Internal ECP absent', '', 1, 'INT_SIGN_EMPTY');
    bars_error.add_message(l_mod, 1, l_exc, l_rus, '����������� ���������� ���', '', 1, 'INT_SIGN_EMPTY');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '³������ �������� ���', '', 1, 'INT_SIGN_EMPTY');

    bars_error.add_message(l_mod, 2, l_exc, l_geo, 'External ECP absent', '', 1, 'EXT_SIGN_EMPTY');
    bars_error.add_message(l_mod, 2, l_exc, l_rus, '����������� ������� ���', '', 1, 'EXT_SIGN_EMPTY');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '³������ ������� ���', '', 1, 'EXT_SIGN_EMPTY');

    bars_error.add_message(l_mod, 3, l_exc, l_geo, 'Visa level can not be negative.', '', 1, 'LEVEL_NEGATIV');
    bars_error.add_message(l_mod, 3, l_exc, l_rus, '������� ���� �� ����� ���� �������������.', '', 1, 'LEVEL_NEGATIV');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'г���� ��� �� ���� ���� ����������.', '', 1, 'LEVEL_NEGATIV');

    bars_error.add_message(l_mod, 4, l_exc, l_geo, 'Visa of level $(VISA) not found!', '', 1, 'VISA_NOT_FOUND');
    bars_error.add_message(l_mod, 4, l_exc, l_rus, '���� ������ $(VISA) �� �������!', '', 1, 'VISA_NOT_FOUND');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '³�� ���� $(VISA) �� ��������!', '', 1, 'VISA_NOT_FOUND');

    bars_error.add_message(l_mod, 5, l_exc, l_geo, 'Impossible locked document REF=$(REF) on visa N $(VISA): Incorrect value of field SOS=$(SOS)', '', 1, 'INCORRECT_SOS');
    bars_error.add_message(l_mod, 5, l_exc, l_rus, '���������� ������������� �������� REF=$(REF) �� ���� � $(VISA): �������� �������� ���� SOS=$(SOS)', '', 1, 'INCORRECT_SOS');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '��������� ����������� �������� REF=$(REF) �� �� � $(VISA): ������ �������� ���� SOS=$(SOS)', '', 1, 'INCORRECT_SOS');

    bars_error.add_message(l_mod, 6, l_exc, l_geo, 'Impossible locked document REF=$(REF) on visa N $(VISA): Incorrect value of field NEXTVISAGRP=$(NEXTVISAGRP)', '', 1, 'INCORRECT_NEXTVISAGRP');
    bars_error.add_message(l_mod, 6, l_exc, l_rus, '���������� ������������� �������� REF=$(REF) �� ���� � $(VISA): �������� �������� ���� NEXTVISAGRP=$(NEXTVISAGRP)', '', 1, 'INCORRECT_NEXTVISAGRP');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '��������� ����������� �������� REF=$(REF) �� �� � $(VISA): ������ �������� ���� NEXTVISAGRP=$(NEXTVISAGRP)', '', 1, 'INCORRECT_NEXTVISAGRP');

    bars_error.add_message(l_mod, 7, l_exc, l_geo, 'Impossible locked document REF=$(REF) on visa N $(VISA): Document not found in visa queue REF_QUE!', '', 1, 'DOC_NOT_FOUND_REFQUE');
    bars_error.add_message(l_mod, 7, l_exc, l_rus, '���������� ������������� �������� REF=$(REF) �� ���� � $(VISA): �������� �� ������ � ������� ����������� REF_QUE!', '', 1, 'DOC_NOT_FOUND_REFQUE');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '��������� ����������� �������� REF=$(REF) �� �� � $(VISA): �������� �� �������� � ������� �������� REF_QUE!', '', 1, 'DOC_NOT_FOUND_REFQUE');

    bars_error.add_message(l_mod, 8, l_exc, l_geo, 'Impossible locked document REF=$(REF) on visa N $(VISA): Document not found!', '', 1, 'DOC_NOT_FOUND_GENERAL');
    bars_error.add_message(l_mod, 8, l_exc, l_rus, '���������� ������������� �������� REF=$(REF) �� ���� � $(VISA): �������� �� ������ ������!', '', 1, 'DOC_NOT_FOUND_GENERAL');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '��������� ����������� �������� REF=$(REF) �� �� � $(VISA): �������� �� ��������!', '', 1, 'DOC_NOT_FOUND_GENERAL');

    bars_error.add_message(l_mod, 9, l_exc, l_geo, 'Impossible locked document REF=$(REF) on visa N $(VISA)', '', 1, 'ERR_BLOCK_DOC');
    bars_error.add_message(l_mod, 9, l_exc, l_rus, '���������� ������������� �������� REF=$(REF) �� ���� � $(VISA)', '', 1, 'ERR_BLOCK_DOC');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '��������� ����������� �������� REF=$(REF) �� �� � $(VISA)', '', 1, 'ERR_BLOCK_DOC');

    bars_error.add_message(l_mod, 10, l_exc, l_geo, 'Impossible locked document REF=$(REF) on visa N $(VISA): Document locked other user', '', 1, 'DOC_IS_BLOCKED');
    bars_error.add_message(l_mod, 10, l_exc, l_rus, '���������� ������������� �������� REF=$(REF) �� ���� � $(VISA): �������� ������������ ������ �������������', '', 1, 'DOC_IS_BLOCKED');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '��������� ����������� �������� REF=$(REF) �� �� � $(VISA): �������� ����������� ����� ������������', '', 1, 'DOC_IS_BLOCKED');

    bars_error.add_message(l_mod, 11, l_exc, l_geo, 'Document not found. REF=%$(REF)', '', 1, 'DOC_NOT_FOUND');
    bars_error.add_message(l_mod, 11, l_exc, l_rus, '�������� �� ������. REF=%$(REF)', '', 1, 'DOC_NOT_FOUND');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '�������� �� ��������. REF=$(REF)', '', 1, 'DOC_NOT_FOUND');

    bars_error.add_message(l_mod, 12, l_exc, l_geo, 'Error on getting document parameters REF=$(REF) on visa N $(VISA)', '', 1, 'ERR_GET_PARAMS');
    bars_error.add_message(l_mod, 12, l_exc, l_rus, '������ ��������� ���������� ��������� REF=$(REF) �� ���� � $(VISA)', '', 1, 'ERR_GET_PARAMS');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '������� ��������� ��������� ��������� REF=$(REF) �� �� � $(VISA)', '', 1, 'ERR_GET_PARAMS');

    bars_error.add_message(l_mod, 32, l_exc, l_geo, 'Invalid visa condition: $(COND)', '', 1, 'ERR_VIS_COND');
    bars_error.add_message(l_mod, 32, l_exc, l_rus, '��������� ������� �� ����: $(COND)', '', 1, 'ERR_VIS_COND');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, '������� � ���� �� ��: $(COND)', '', 1, 'ERR_VIS_COND');

    bars_error.add_message(l_mod, 33, l_exc, l_geo, 'Unable to execute procedure $(PROC)', '', 1, 'UNHANDLED_NO_DATA_FOUND');
    bars_error.add_message(l_mod, 33, l_exc, l_rus, '���������� ��������� ��������� $(PROC)', '', 1, 'UNHANDLED_NO_DATA_FOUND');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, '��������� �������� ��������� $(PROC)', '', 1, 'UNHANDLED_NO_DATA_FOUND');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_VIS.sql =========*** Run *** ==
PROMPT ===================================================================================== 
