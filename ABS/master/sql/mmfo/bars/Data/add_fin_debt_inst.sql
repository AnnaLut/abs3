begin
   bc.go('/');

   Insert into FIN_DEBT   (nbs_n, nbs_p, nbs_k, mod_abs, comm) Values   ('357053', '357054', NULL, 9, '¡œ  INSTOLMENT');
   commit;

   exception
     when dup_val_on_index then
          null;
end;
/
