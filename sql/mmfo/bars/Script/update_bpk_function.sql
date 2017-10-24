
begin   
   
   umu.remove_function('/barsroot/Way4Bpk/Way4Bpk');
   
   operlist_adm.modify_func_by_path (
        p_funcpath       => '/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio',
        p_new_funcpath   => '/barsroot/Way4Bpk/Way4Bpk');
   COMMIT;
   
   update operlist set name=name||' (тн)' where funcname = '/barsroot/Way4Bpk/Way4Bpk';
   commit;
END;
/