

 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_arr_nom.sql =========*** Run *** ====
 PROMPT ===================================================================================== 

declare 
  v_num integer;
  v_type varchar2(30) := 'T_ARR_NOM';
begin
    execute immediate 'CREATE OR REPLACE TYPE '||v_type||' force is table of t_Nominal';
end;

/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_arr_nom.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 