declare
 tabid_  int; 
 tab_          meta_tables.tabname%type  := 'MBDK_PRODUCT'; 
 tab_semantic_ meta_tables.semantic%type := 'MBDK: Продукти';
 begin

    begin 
       select tabid into tabid_ from meta_tables where tabname=tab_;
    EXCEPTION WHEN NO_DATA_FOUND THEN tabid_ := NULL;
       tabid_ := bars_metabase.get_newtabid;
       bars_metabase.add_table (tabid_, tab_, tab_semantic_,null);
    end;
    begin
       Insert into BARS.REFAPP (TABID , CODEAPP, ACODE, APPROVE, GRANTOR) 
                        Values (tabid_, '$RM_MBDK' , 'RW' , 1      , 1      );
    exception when dup_val_on_index then  null;
    end;
    begin
       Insert into BARS.REFERENCES  (TABID, TYPE) Values   (tabid_, 8);
    exception when dup_val_on_index then  null;
    end;

 end;
/
commit;
/
