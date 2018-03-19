create or replace force view bars.v_banks_xrm
(
   mfo,
   nb
)
as
   select mfo, nb from banks$base;
/
grant select,delete,update,insert on bars.v_banks_xrm to bars_access_defrole;
/ 
