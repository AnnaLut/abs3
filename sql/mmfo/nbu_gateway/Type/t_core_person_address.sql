create or replace type t_core_person_address force as object
(
       codregion           varchar2(2 char),       -- ��� ������
       area                varchar2(100 char),     -- �����
       zip                 varchar2(10 char),      -- �������� ������
       city                varchar2(254 char),     -- ����� ���������� ������ 
       streetaddress       varchar2(254 char),     -- ������
       houseno             varchar2(50 char),      -- �������
       adrkorp             varchar2(10 char),      -- ������ (�������)
       flatno              varchar2(10 char)       -- ��������
);
/
create or replace type t_core_person_addresses force as table of t_core_person_address;
/
