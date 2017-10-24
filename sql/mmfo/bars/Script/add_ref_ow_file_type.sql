insert into REFERENCES (  TABID,  TYPE)
    select tabid, 29
    from meta_tables m 
    where tabname='V_OW_FILE_TYPE' and not exists
    ( select 1 from REFERENCES where tabid =m.tabid);
/
  insert into  REFAPP (  TABID, CODEAPP,  ACODE,  APPROVE )
    select tabid, '$RM_OWAY','RW',1
    from meta_tables m 
    where tabname='V_OW_FILE_TYPE' and not exists
    ( select 1 from REFAPP where codeapp ='$RM_OWAY' and tabid =m.tabid);
/
commit;
/

