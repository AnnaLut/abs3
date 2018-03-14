create or replace type t_core_company_owner_company force as object
(
       nameoj           varchar2(254 char),             -- ������������ �����
       isrezoj          varchar2(5 char),               -- ������������ ����� (true � ���� ����� � ����������; false � ���� ����� �� � ����������)
       codedrpouoj      varchar2(20 char),              -- ��� ������
       registrydayoj    date,                           -- ���� �������� ���������
       numberregistryoj varchar2(32 char),              -- ����� �������� ���������
       countrycodoj     varchar2(3 char),               -- ��� ����� � ���� ��������� �����������
       per�entoj        number(9, 6)                    -- ������ �������� ������� �����
);
/

create or replace type t_core_company_owner_companies force as table of t_core_company_owner_company;
/
