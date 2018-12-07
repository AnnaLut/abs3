begin
   bc.go('/');

   Insert into bars.FIN_DEBM   (id, name) Values   (9, '¡œ  INSTOLMENT');
   commit;

   exception
     when dup_val_on_index then
          null;
end;
/
