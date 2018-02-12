begin
   begin insert into ins_ewa_document_types values('ID_PASSPORT','ID-паспорт',1);
   exception when others then
   if sqlcode = -1 then null; else raise; end if;
   end;
end;
/
commit;
