begin
insert into cc_tag (tag,
                    name,
                    tagtype,
                    table_name,
                    type,
                    nsisqlwhere,
                    edit_in_form,
                    not_to_edit,
                    code)
select 'S_S36',
       'Комісія за обслуговування кредиту',
       'CCK',
       null,
       'N',
       null,
       null,
       0,
       'MAIN'
  from dual 
  where not exists (select 1 from cc_tag where tag = 'S_S36');
end;

/
