
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_enquirydata.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
declare 
  v_num integer;
  v_type varchar2(30) := 'T_ENQUIRYDATA';
begin
  select count(1) into v_num 
    from user_types
    where type_name = v_type;
  if v_num = 0 then
    execute immediate 'CREATE OR REPLACE TYPE '||v_type||' force as object
    (r_enq_id       integer,
     r_CurrencyCode integer,
     r_Amount       number,
     r_nominal      t_arr_nom)';
  end if;
end;

/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_enquirydata.sql =========*** End *** 
 PROMPT ===================================================================================== 
 