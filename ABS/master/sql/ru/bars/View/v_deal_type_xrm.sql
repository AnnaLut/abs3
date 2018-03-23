create or replace force view bars.v_deal_type_xrm
(
   type,
   name
)
as
   select 'CARD' type, 'Тип договору карткового продукту' name
     from dual
   union
   select 'DEPOSIT' type, 'Тип договору депозитного продукту' name
     from dual;
/
grant select on bars.v_deal_type_xrm to bars_intgr;
/