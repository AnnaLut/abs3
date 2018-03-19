prompt create view v_sos_xrm

create or replace view v_sos_xrm
as
select * from op_sos;

grant select,delete,update,insert on bars.v_sos_xrm to bars_access_defrole;
                


