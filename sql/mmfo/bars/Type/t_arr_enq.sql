

 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_arr_enq.sql =========*** Run *** ====
 PROMPT ===================================================================================== 

declare 
  v_num integer;
  v_type varchar2(30) := 'T_ARR_ENQ';
begin
    execute immediate 'CREATE OR REPLACE TYPE '||v_type||' force is table of t_EnquiryData';
end;

/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_arr_enq.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 