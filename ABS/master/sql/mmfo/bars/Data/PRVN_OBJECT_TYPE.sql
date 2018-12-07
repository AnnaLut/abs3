begin
   bc.go('/');

   Insert into PRVN_OBJECT_TYPE   (id, name, prd_tp) Values   ('INS', 'Инстолмент', 23);
   commit;

   exception
     when dup_val_on_index then
          null;
end;
/
