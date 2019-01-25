

 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_nominal.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
declare 
  v_num integer;
  v_type varchar2(30) := 'T_NOMINAL';
begin
  select count(1) into v_num
    from user_types 
    where type_name = v_type;
  if v_num = 0 then
    execute immediate 'CREATE OR REPLACE TYPE '||v_type||' force as object
    (r_Value    integer,
     r_IsChange integer,
     r_Count    integer,
     r_enq_id   integer)';
  end if;
end;

/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_nominal.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 