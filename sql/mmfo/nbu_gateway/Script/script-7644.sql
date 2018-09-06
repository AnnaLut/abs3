declare 
  v_num integer;
begin
  select count(1) into v_num
    from user_types 
    where lower(type_name) = 't_compare_json_tab';
  if v_num = 1 then
   execute immediate 'drop type t_compare_json_tab';
  end if;

  select count(1) into v_num
    from user_types 
    where lower(type_name) = 't_compare_json';
  if v_num = 1 then
   execute immediate 'drop type t_compare_json';
  end if;
end;
/
