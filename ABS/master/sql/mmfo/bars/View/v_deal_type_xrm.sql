create or replace force view bars.v_deal_type_xrm
(
   type,
   name
)
as
   select 'CARD' type, '��� �������� ���������� ��������' name
     from dual
   union
   select 'DEPOSIT' type, '��� �������� ����������� ��������' name
     from dual;
/
grant select on bars.v_deal_type_xrm to bars_intgr;
/