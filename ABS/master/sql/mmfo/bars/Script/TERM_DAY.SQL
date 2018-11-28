declare  ff SPARAM_LIST%rowtype;
--------------------------------
begin 

  update SPARAM_CODES set NAME = 'Оверд+Фин.Деб' where code = 'OVRN';

  begin Insert into SPARAM_CODES   (CODE, NAME, ORD) Values   ('OVRN', 'Оверд+Фин.Деб', 8);
  exception when dup_val_on_index then null;  
  end;

  ff.name     := 'VALUE' ;  
  ff.TABNAME  := 'ACCOUNTSW' ;  
  ff.CODE     := 'OTHERS' ;  
  ff.INUSE    := 1;  --ff.BRANCH := '/' ;
  ff.tag      := 'TERM_DAY'; 
  ff.semantic := 'Термін(день міс) для сплати %% та комісій';  

  begin select * into ff from  SPARAM_LIST where  TABNAME = ff.TABNAME and tag = ff.tag ;
        update SPARAM_LIST set semantic  = ff.semantic, code = ff.code  where  SPID = ff.SPID ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  
       select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  
       ff.TYPE := 'N'  ; 
      insert into SPARAM_LIST Values ff ; 
  end;

--insert into PS_SPARAM( NBS, SPID )  select '3578', ff.SPID from dual where not exists (select 1 from PS_SPARAM where NBS = '3578' and  SPID = ff.SPID);

  insert into PS_SPARAM( NBS, SPID ) 
   select distinct a.nbs , f.SPID 
   from accounts a, PRVN_FIN_DEB x ,   (select SPID from  SPARAM_LIST where  TABNAME ='ACCOUNTSW' and tag ='TERM_DAY') f
   where a.acc = x.acc_ss and not exists (select 1 from PS_SPARAM where NBS = a.nbs and  SPID = f.SPID);


  update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;  
  if SQL%rowcount=0 then Insert into ACCOUNTS_FIELD    (TAG, NAME, USE_IN_ARCH) Values   (ff.tag, ff.name, 0); end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
end;
/
commit ;

