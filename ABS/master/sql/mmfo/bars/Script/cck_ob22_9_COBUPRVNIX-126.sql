declare  l_tabid int  :=  bars_metabase.get_tabid('CCK_OB22_9');
begin 

  delete from REFAPP     where tabid  = l_tabid;
  delete from REFERENCES where tabid  = l_tabid;

  Insert into REFERENCES   (TABID, TYPE) Values   (l_tabid, 22);
  Insert into REFAPP   (TABID, CODEAPP, ACODE, APPROVE, REVOKED)
            select    l_tabid, CODEAPP, ACODE, APPROVE, REVOKED
            from REFAPP where TABID = bars_metabase.get_tabid('CCK_OB22');
end;
/
commit ;
