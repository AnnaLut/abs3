create or replace type t_core_person_document force as object
(
    typed                 number(1),                               -- ��� ��������� (1 - ��������� �������, 2 - ����������� �������, 3 - ID ������, 4 - ����)
    seriya                varchar2(20 char),                       -- ���� ���������. ���� ��� ��������� ID ������ (typeD = 3), ����������� ��������� ����� ������
                                                                   -- � ������� ���������� �������������� �����
    nomerd                varchar2(20 char),                       -- ����� ���������
    dtd                   date                                     -- ���� ������ ���������
);
/
create or replace type t_core_person_documents force is table of t_core_person_document;
/
