begin 
    update mbm_rel_customers m 
       set m.doc_type = 1
     where m.doc_type = 'PASSPORT';
    commit;
end;
/