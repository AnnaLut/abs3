declare 
  v_num number;
Begin
   INSERT INTO SPARAM_LIST(SPID,NAME,SEMANTIC,TABNAME,TYPE,NSINAME,INUSE,PKNAME,DELONNULL,NSISQLWHERE,SQLCONDITION,TAG,TABCOLUMN_CHECK,CODE,HIST,MAX_CHAR,BRANCH,DEF_FLAG,EDITABLE) 
    select (select max(spid)+1 from sparam_list),'VALUE','Дата договору','ACCOUNTSW','D','',1,'',null,'','','DKD','','SPECPARAM',null,null,'/300465/','N',1
      from dual 
      where not exists (select 1 from sparam_list where tag = 'DKD');
  insert into ps_sparam
    select '1500',spid,'1',''
       from sparam_list 
       where tag = 'DKD' and not exists (select 1 from ps_sparam p, sparam_list s where p.nbs = '1500' and s.tag = 'DKD' and p.spid = s.spid);
  
  insert into accounts_field 
    select 'DKD','Дата договору для рахунку 1500*',null,0
      from dual 
      where not exists (select 1 from accounts_field where tag = 'DKD');

    exception when dup_val_on_index then null;
end;
/
commit;
