prompt refill table bars_intgr.imp_object

delete from bars_intgr.imp_object;

insert all
into bars_intgr.imp_object(object_name, object_proc, imp_order, active) values ('CLIENTFO2', 'xrm_import.import_clientfo2', 1, 1)
select 1 from dual;

commit;
