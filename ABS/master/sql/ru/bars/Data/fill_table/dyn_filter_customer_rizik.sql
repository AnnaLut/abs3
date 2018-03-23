prompt Importing table dyn_filter...
set feedback off
set define off
begin
  update dyn_filter d
     set d.where_clause = '(  $~~ALIAS~~$.RNK IN ( select rnk from customerw where tag = ''RIZIK'' and lower(value) like ''%неприйнятно високий%'' ))'
   where d.semantic = 'Клієнти з неприйнятно високим рівнем ризику'
     and d.USERID is null
	 and d.TABID = get_tabid('CUSTOMER');
  if sql%rowcount = 0 then
    insert into dyn_filter
      (FILTER_ID,
       TABID,
       USERID,
       SEMANTIC,
       FROM_CLAUSE,
       WHERE_CLAUSE,
       PKEY,
       BRANCH,
       CONDITION_LIST)
    values
      (s_dyn_filter.nextval,
       get_tabid('CUSTOMER'),
       null,
       'Клієнти з неприйнятно високим рівнем ризику',
       null,
       '(  $~~ALIAS~~$.RNK IN ( select rnk from customerw where tag = ''RIZIK'' and lower(value) like ''%неприйнятно високий%'' ))',
       null,
       '/',
       null);
  end if;
  update dyn_filter d
     set d.where_clause = '(  $~~ALIAS~~$.RNK IN ( select rnk from customerw where tag = ''RIZIK'' and lower(value) like ''%неприйнятно високий%'' ))'
   where d.semantic = 'Клієнти з неприйнятно високим рівнем ризику'
     and d.USERID is null
	 and d.TABID = get_tabid('V_CUSTOMER');
  if sql%rowcount = 0 then
    insert into dyn_filter
      (FILTER_ID,
       TABID,
       USERID,
       SEMANTIC,
       FROM_CLAUSE,
       WHERE_CLAUSE,
       PKEY,
       BRANCH,
       CONDITION_LIST)
    values
      (s_dyn_filter.nextval,
       get_tabid('V_CUSTOMER'),
       null,
       'Клієнти з неприйнятно високим рівнем ризику',
       null,
       '(  $~~ALIAS~~$.RNK IN ( select rnk from customerw where tag = ''RIZIK'' and lower(value) like ''%неприйнятно високий%'' ))',
       null,
       '/',
       null);
  end if;
end;
/
commit;