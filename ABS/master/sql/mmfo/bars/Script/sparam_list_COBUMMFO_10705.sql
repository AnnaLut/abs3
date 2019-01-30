declare  ff SPARAM_LIST%rowtype;
--------------------------------
begin 

  begin 
    insert into sparam_codes (code, name, ord) values   ('CVK', 'ЦВК', 6);
    exception 
      when dup_val_on_index then 
        null;  
      when others then
        raise;
  end;

  ff.name := 'VALUE' ;  ff.TABNAME  := 'ACCOUNTSW' ;  ff.CODE := 'CVK' ;  ff.INUSE := 1;  ff.BRANCH := '/300465/' ;
  
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'CVK_INF2'  ; ff.semantic  := 'ЦВК. Інформація про відповідального працівника № тел, e-mail';  
  update SPARAM_LIST  set semantic   = ff.semantic 
   where TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then 
    select max(SPID) + 1 into ff.SPID from SPARAM_LIST;  
    ff.TYPE := 'S'; 
    insert into SPARAM_LIST Values ff; 
  end if;

end;
/
COMMIT;
---------------------------------

begin
  delete from PS_SPARAM where spid in (select spid from SPARAM_LIST where code = 'CVK' and tag = 'CVK_INF2');

  insert into PS_SPARAM(NBS, SPID) 
                 select p.nbs, l.spid 
                 from ps p, SPARAM_LIST l
                 where p.nbs in (select distinct nbs from ps_sparam where spid in (select spid from SPARAM_LIST where code = 'CVK' and tag = 'CVK_INF'))
                   and l.TABNAME = 'ACCOUNTSW' and l.tag in ('CVK_INF2') ;
end;
/
commit;



