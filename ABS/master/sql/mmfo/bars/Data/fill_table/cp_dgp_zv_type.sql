begin
  insert into   cp_dgp_zv_type (type_id, type_name, type_view)
           values (7, 'Інвестиції в боргові цінні папери, окрім державних', 'v_cp_dgp007');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert into   cp_dgp_zv_type (type_id, type_name, type_view)
           values (8, 'Інвестиції у державні цінні папери', 'v_cp_dgp008');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

begin
  insert into   cp_dgp_zv_type (type_id, type_name, type_view)
           values (9, 'Інвестиції в пайові цінні папери та в асоційовані і дочірні компанії', 'v_cp_dgp009');
exception when dup_val_on_index then null;
          when others then raise;
end;
/

commit;