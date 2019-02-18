
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/pkg_sql.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PKG_SQL is

  -- Author  : Unity Bars Team
  -- Created : 19.10.2018 14:35:21
  -- Purpose : execute dynamic sql from table tts  
  
  -- for bind variables like #(NLS)
  procedure p_bind#_add(ip_param# in varchar2, ip_value in varchar2);
  procedure p_bind#_add(ip_param# in varchar2, ip_value in number)  ;
  procedure p_bind#_add(ip_param# in varchar2, ip_value in date)    ;

  -- for bind variables like :NLS
  procedure p_bind_add(ip_param in varchar2, ip_value in varchar2);
  procedure p_bind_add(ip_param in varchar2, ip_value in number)  ;
  procedure p_bind_add(ip_param in varchar2, ip_value in date)    ;
  


  /*
    выполн€ет динамический код вида
    select ip_sql from dual  где ip_sql = function|formula|select
    возвращает одно значение
  */
  procedure p_dual_exec(ip_formula in varchar2, op_result out varchar2);
  procedure p_dual_exec(ip_formula in varchar2, op_result out number);
  procedure p_dual_exec(ip_formula in varchar2, op_result out date);

  /*
    выполн€ет динамический код вида
    begin res := ip_sql; end; 
    возвращает одно значение
  */

  procedure p_block_exec(ip_formula in varchar2, op_result out varchar2);
  procedure p_block_exec(ip_formula in varchar2, op_result out number);
  procedure p_block_exec(ip_formula in varchar2, op_result out date);
                             

end PKG_SQL;
/
CREATE OR REPLACE PACKAGE BODY BARS.PKG_SQL is

  g_bind_all pkg_dbms_sql.t_bind; -- list of all posible bind variables
  g_bind     pkg_dbms_sql.t_bind; -- list of bind variables after check on exists in SQL
  
  c_bind#_type constant varchar2(1) := '#';
  c_bind_type  constant varchar2(1) := ':';
  
  procedure p_exception(ip_text in varchar2) 
   as
  begin
    raise_application_error(-20001, ip_text);
  end;
  
  -- cnv# конвертирует параметр вида #PARAM to :PARAM
  function cnv#(ip_par# in varchar2) 
    return varchar2 
  as
  begin
    return replace(replace(replace(ip_par#, '#', ':'), ')'), '(');
  end;
  
  
  procedure p_param#check(ip_param# in varchar2) 
  as
  begin
    if trim(ip_param#) is null then
      p_exception('Ќе заполнен параметр');
    end if;
    if ip_param# not like '#(_%)' then
      p_exception('Ќе корректное наименование переменной прив€зки = ''' || ip_param# || '''');
    end if;
    if length(ip_param#) > 31 then
      p_exception('ƒлина наименовани€ параметра = ''' || ip_param# ||
                  ''' больше 31 символа');
    end if;
  end;

  procedure p_bind#_add(ip_param# in varchar2, ip_value in varchar2) 
  as
  begin
    p_param#check(ip_param#);
    pkg_dbms_sql.p_add_bind(ip_param#, c_bind#_type, ip_value, g_bind_all);
  end;

  procedure p_bind#_add(ip_param# in varchar2, ip_value in number) 
  as
  begin
    p_param#check(ip_param#);
    pkg_dbms_sql.p_add_bind(ip_param#, c_bind#_type, ip_value, g_bind_all);
  end;

  procedure p_bind#_add(ip_param# in varchar2, ip_value in date) 
  as
  begin
    p_param#check(ip_param#);
    pkg_dbms_sql.p_add_bind(ip_param#, c_bind#_type, ip_value, g_bind_all);
  end;
  
  --  primitive parser for params like #(NAME), :NAME  
  procedure p_formula2SQL
  (
   ip_formula in  varchar2,
   op_sql     out varchar2
  )
  as
    l_param  pkg_dbms_sql.refVariableLen;
    l_bind   pkg_dbms_sql.refVariableLen;
  begin
     op_sql := ip_formula;
     l_bind := g_bind_all.first;      
     
     while l_bind is not null    
     loop
       case g_bind_all(l_bind).bind_type
         -- bind variable in ip_formula like #(NLS)
         when  c_bind#_type  then 
               if instr(ip_formula, l_bind) > 0 then         
                  l_param := cnv#(l_bind);
                  g_bind(l_param) := g_bind_all(l_bind);          
                  op_sql := replace(op_sql, l_bind, l_param);          
                end if;
         -- bind variable in ip_formula like :NLS
         when c_bind_type then 
               if instr(ip_formula, c_bind_type||l_bind) > 0 then         
                  l_param := l_bind;
                  g_bind(l_param) := g_bind_all(l_bind);
               end if;
         end case;     

         l_bind := g_bind_all.next(l_bind); -- next bind variable for parsing
        
      end loop;      
  end;
  
  procedure p_close_cursor(ip_cursor in out integer) as
  begin
    -- cleanup global collection
    g_bind.delete;
    g_bind_all.delete;
    
    if dbms_sql.is_open(ip_cursor) then
      pkg_dbms_sql.p_close_cursor(ip_cursor);
    end if;
  
  end;

  procedure p_dual_exec_base
  (
   ip_formula  in varchar,
   ip_typecode in pls_integer,
   op_result   out pkg_dbms_sql.r_anydata
   )
  as
    v_cursor integer;
    v_ignore integer;
    v_sql    varchar2(32000);
  begin
    p_formula2SQL(ip_formula, v_sql);
     
    v_sql := 'select ' || v_sql || ' from dual';
    
    v_cursor := dbms_sql.open_cursor;
      
    pkg_dbms_sql.p_parse(v_cursor, v_sql);
  
    -- всегда одна колонка
    pkg_dbms_sql.p_define_column(v_cursor, 1, ip_typecode);
    --
    pkg_dbms_sql.p_bind_variable(v_cursor, g_bind);
    --
    v_ignore := DBMS_SQL.EXECUTE(v_cursor);
  
    v_ignore := DBMS_SQL.FETCH_ROWS(v_cursor);
  
    pkg_dbms_sql.p_column_value(v_cursor, 1, op_result);
  
    p_close_cursor(v_cursor);
  
  exception
    when others then
      p_close_cursor(v_cursor);
      raise;
  end;

  procedure p_dual_exec(ip_formula in varchar2, op_result out date) 
  as
    v_result_value pkg_dbms_sql.r_anydata;
    v_result_type  pls_integer := dbms_types.Typecode_Date;
  begin
    p_dual_exec_base(ip_formula, v_result_type, v_result_value);
  
    op_result := v_result_value.date_value;
  end;

  procedure p_dual_exec(ip_formula in varchar2, op_result out number) 
  as
    v_result_value pkg_dbms_sql.r_anydata;
    v_result_type  pls_integer := dbms_types.Typecode_Number;
  begin
    p_dual_exec_base(ip_formula, v_result_type, v_result_value);
  
    op_result := v_result_value.number_value;
  end;

  procedure p_dual_exec(ip_formula in varchar2, op_result out varchar2) 
  as
    v_result_value pkg_dbms_sql.r_anydata;
    v_result_type  pls_integer := dbms_types.Typecode_Varchar2;
  begin
    p_dual_exec_base(ip_formula, v_result_type, v_result_value);
  
    op_result := v_result_value.varchar2_value;
  end;

---------------------------block--------------------------------------------
  procedure p_block_exec_base
  (
   ip_formula  in varchar,
   ip_typecode in pls_integer, -- typecode of op_result 
   op_result   out pkg_dbms_sql.r_anydata
   )
  as
    v_cursor integer;
    v_ignore integer;
    v_sql    varchar2(32000);
  begin
    p_formula2SQL(ip_formula, v_sql);
     
    v_sql := 'begin :rez := ' || v_sql || '; end;';
    
    v_cursor := dbms_sql.open_cursor;
      
    pkg_dbms_sql.p_parse(v_cursor, v_sql);
    -- bind variable 
    pkg_dbms_sql.p_bind_variable(v_cursor, g_bind);
    -- bind result  
    pkg_dbms_sql.p_bind_variable_out(v_cursor, ':rez', ip_typecode);
    --
    v_ignore := DBMS_SQL.EXECUTE(v_cursor);
    -- get value 
    pkg_dbms_sql.p_variable_value(v_cursor,':rez',ip_typecode,op_result);
    
    p_close_cursor(v_cursor);
  
  exception
    when others then
      p_close_cursor(v_cursor);
      raise;
  end;  
  
  procedure p_block_exec(ip_formula in varchar2, op_result out date) 
  as
    v_result_value pkg_dbms_sql.r_anydata;
    v_result_type  pls_integer := dbms_types.Typecode_Date;
  begin
    p_block_exec_base(ip_formula, v_result_type, v_result_value);
  
    op_result := v_result_value.date_value;
  end;

  procedure p_block_exec(ip_formula in varchar2, op_result out number) 
  as
    v_result_value pkg_dbms_sql.r_anydata;
    v_result_type  pls_integer := dbms_types.Typecode_Number;
  begin
    p_block_exec_base(ip_formula, v_result_type, v_result_value);
  
    op_result := v_result_value.number_value;
  end;

  procedure p_block_exec(ip_formula in varchar2, op_result out varchar2) 
  as
    v_result_value pkg_dbms_sql.r_anydata;
    v_result_type  pls_integer := dbms_types.Typecode_Varchar2;
  begin
    p_block_exec_base(ip_formula, v_result_type, v_result_value);
  
    op_result := v_result_value.varchar2_value;
  end;
  
  ----------------------------------------------------------------------------
  procedure p_param_check(ip_param in varchar2) 
  as
  begin
    if trim(ip_param) is null then
      p_exception('Ќе заполнен параметр');
    end if;
    if ip_param like '#(_%)' then
      p_exception('Ќе корректное наименование переменной прив€зки = ''' || ip_param || '''');
    end if;
    if ip_param like ':_%'  then
       p_exception('ѕараметр = ''' || ip_param || ''''||' содержит недопустимый символ '':''');
    end if;
    if length(ip_param) > 30 then
      p_exception('ƒлина наименовани€ параметра = ''' || ip_param ||
                  ''' больше 30 символов');
    end if;
  end;
  
  procedure p_bind_add(ip_param in varchar2, ip_value in varchar2) 
  as
  begin
    p_param_check(ip_param);
    pkg_dbms_sql.p_add_bind(ip_param, c_bind_type, ip_value, g_bind_all);
  end;

  procedure p_bind_add(ip_param in varchar2, ip_value in number) 
  as
  begin
    p_param_check(ip_param);
    pkg_dbms_sql.p_add_bind(ip_param, c_bind_type, ip_value, g_bind_all);
  end;

  procedure p_bind_add(ip_param in varchar2, ip_value in date) 
  as
  begin
    p_param_check(ip_param);
    pkg_dbms_sql.p_add_bind(ip_param, c_bind_type, ip_value, g_bind_all);
  end;


end PKG_SQL;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/pkg_sql.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 
