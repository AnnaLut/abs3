create or replace type t_core_company_owner_person force as object
(
       -- �������, ���, �� ������� ������� ����� (��������� fio)
       lastname         varchar2(100 char),
       firstname        varchar2(100 char),
       middlename       varchar2(100 char),
       isrez            varchar2(5 char),               -- true � ���� ����� � ����������; false � ���� ����� �� � ����������
       inn              varchar2(20 char),              -- ���������������� ���
       countrycod       varchar2(3 char),               -- ��� ����� ���� ���������
       per�ent          number(9, 6)                    -- ������ �������� ������� �����
);
/
create or replace type t_core_company_owner_persons force as table of t_core_company_owner_person;
/
