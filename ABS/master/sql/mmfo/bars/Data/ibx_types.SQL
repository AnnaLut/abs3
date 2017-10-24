set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции MA1
prompt Наименование операции: Дочірня до MAS
declare
  cnt_  number;
  v_staff_id number;
begin
  --------------------------------
  -- Основные свойства ibx_types --
  --------------------------------

begin
select t.id into v_staff_id from STAFF$BASE t
where logname like 'TECH_TOMAS';
exception
    when no_data_found then
     select t.id into v_staff_id from STAFF$BASE t
         where logname like 'ABSADM';
end;


  begin
     insert into ibx_types (id, name, nls, ext_okpo, ext_nls, ext_mfo, ext_nazn_mask, staff_id, proc_getinfo, proc_pay, abs_nazn_mask)
     values ('TOMAS', 'Томас', '&&v_nls', null, '&&v_trans_nls', null, null, v_staff_id, 'ibx_pack.get_info_nonstop24', 'ibx_pack.pay_gl', '&&v_abs_nazn_mask');
                         
  exception
    when others then
	if sqlcode=-00001 then
    update ibx_types
   set  nls = '&&v_nls',
      ext_nls = '&&v_trans_nls', 
       staff_id = v_staff_id,
       abs_nazn_mask = '&&v_abs_nazn_mask'
 where id = 'TOMAS';
	end if;
end;
end;
/  

commit;

