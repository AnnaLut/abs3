create or replace type t_core_person_workplace force as object
(
       typew      number(1),                   -- ��� ����������� (1 � ������������ � �������� �����, 2 � ������� ����� � ��ᒺ�� ������������ ��������.)
       codedrpou  varchar2(20 char),
       namew      varchar2(254 char)
);
/

create or replace type t_core_person_workplaces force as table of t_core_person_workplace;
/
