declare
 tabid_  int; 
 tab_          meta_tables.tabname%type  := 'NBUR_KOR_DATA_4BX'; 
 tab_semantic_ meta_tables.semantic%type := '4BX -достатність регулятивного капіталу та економічні нормативи';
begin

    begin 
       select tabid into tabid_ from meta_tables where tabname=tab_;
    EXCEPTION WHEN NO_DATA_FOUND THEN tabid_ := NULL;
       tabid_ := bars_metabase.get_newtabid;
       bars_metabase.add_table (tabid_, tab_, tab_semantic_,null);
    end;
    begin
       Insert into BARS.REFAPP (TABID , CODEAPP, ACODE, APPROVE, GRANTOR) 
                        Values (tabid_, '$RM_NBUR' , 'RW' , 1      , 1      );
    exception when dup_val_on_index then  null;
    end;
    begin
       Insert into BARS.REFERENCES  (TABID, TYPE, ROLE2EDIT) Values   (tabid_, 20, 'RPBN002');
    exception when dup_val_on_index then  null;
    end;

end;
/

commit;
/
