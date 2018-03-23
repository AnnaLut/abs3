begin
  update sparam_list s
     set s.nsiname         = 'V_BPK_PROECT',
         s.pkname          = 'ID',
         s.nsisqlwhere     = '(ID != -1)',
         s.tabcolumn_check = 'ID'
   where s.tabname = 'ACCOUNTSW'
     and s.tag = 'PK_PRCT'
     and s.code = 'BPK';
  if sql%rowcount = 0 then
    insert into sparam_list
      (SPID,
       NAME,
       SEMANTIC,
       TABNAME,
       TYPE,
       NSINAME,
       INUSE,
       PKNAME,
       DELONNULL,
       NSISQLWHERE,
       SQLCONDITION,
       TAG,
       TABCOLUMN_CHECK,
       CODE,
       HIST,
       MAX_CHAR,
       BRANCH)
    values
      (68,
       'VALUE',
       'БПК. Зарплатний проект',
       'ACCOUNTSW',
       'S',
       'V_BPK_PROECT',
       1,
       'ID',
       1,
       '(ID != -1)',
       null,
       'PK_PRCT',
       'ID',
       'BPK',
       null,
       null,
       '/300465/');
  end if;
end;
/

commit;