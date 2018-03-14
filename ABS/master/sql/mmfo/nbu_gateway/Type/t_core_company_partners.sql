create or replace type t_core_company_partner force as object
(
       isrezpr          varchar2(5 char),              -- true � ���� ����� � ����������; false � ���� ����� �� � ����������
       codedrpoupr      varchar2(20 char),              -- ��� ������
       nameurpr         varchar2(254 char),             -- ������������ �����
       countrycodpr     varchar2(3 char)                -- ��� ����� ���� ��������� (����������� ��� �����-�����������)
);
/

create or replace type t_core_company_partners force as table of t_core_company_partner;
/
