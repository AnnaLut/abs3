begin 
  begin 
    dbms_apply_adm.drop_apply('CB_APPLY');
  exception  when others then
    if sqlcode = -26701 then null; else raise; end if;
  end;
  begin
    dbms_capture_adm.drop_capture('CB_CAPTURE');
  exception  when others then
    if sqlcode = -26701 then null; else raise; end if;
  end;
  begin
    dbms_propagation_adm.drop_propagation('TR_PROPAGATION');
  exception  when others then
    if sqlcode = -23601 then null; else raise; end if;
  end;
end;
/