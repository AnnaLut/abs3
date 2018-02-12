prompt Importing table dyn_filter...
set feedback off
set define off
begin
  update dyn_filter d
     set d.where_clause = '(  $~~ALIAS~~$.RNK IN ( select rnk from customerw where tag = ''RIZIK'' and lower(value) like ''%����������� �������%'' ))'
   where d.semantic = '�볺��� � ����������� ������� ����� ������'
     and d.USERID is null;
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
       '�볺��� � ����������� ������� ����� ������',
       null,
       '(  $~~ALIAS~~$.RNK IN ( select rnk from customerw where tag = ''RIZIK'' and lower(value) like ''%����������� �������%'' ))',
       null,
       '/',
       null);
  end if;
end;
/
commit;