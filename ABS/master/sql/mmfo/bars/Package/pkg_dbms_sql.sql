
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/pkg_dbms_sql.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PKG_DBMS_SQL is

   subtype refVariableLen is varchar2(30);
   
   type r_anydata is record
                (                   
                  typecode       pls_integer -- тип данных
                 ,number_value   number
                 ,varchar2_value varchar2(4000)
                 ,date_value     date
                 );
  type r_bind is record
                (                   
                  typecode       pls_integer  -- тип данных
                 ,bind_type      varchar2(1)  -- # - #(NLS), : - :NLS
                 ,number_value   number
                 ,varchar2_value varchar2(4000)
                 ,date_value     date
                 );


   type t_bind is table of r_bind index by refVariableLen; -- param_name

   -- add bind variable to collection
   procedure p_add_bind(ip_param_name in varchar2, ip_bind_type in varchar2, ip_value in number,   p_bind in out nocopy t_bind );
   procedure p_add_bind(ip_param_name in varchar2, ip_bind_type in varchar2, ip_value in varchar2, p_bind in out nocopy t_bind );
   procedure p_add_bind(ip_param_name in varchar2, ip_bind_type in varchar2, ip_value in date,     p_bind in out nocopy t_bind );
   
   -- dbms_sql.bind_variable 
   procedure p_bind_variable(ip_cursor in integer, ip_bind in t_bind);

   procedure p_bind_variable_out(ip_cursor in integer, ip_variable_nm in varchar2, ip_typecode in pls_integer);
   
   
   -- dbms_sql.parse
   procedure p_parse(ip_cursor in integer, ip_sql    in varchar2);
   -- dbms_sql.define_column
   procedure p_define_column(ip_cursor in integer, ip_position in integer, ip_typecode in pls_integer);
   -- dbms_sql.column_value
   procedure p_column_value(ip_cursor in integer, ip_position in integer, op_val out r_anydata);
   -- dbms_sql.variable_value
   procedure p_variable_value(ip_cursor in integer, ip_variable_nm in varchar2, ip_typecode  in pls_integer, op_val out r_anydata);
   
   
   -- dbms_sql.close_cursor
   procedure p_close_cursor(ip_cursor in out integer);

end PKG_DBMS_SQL;
/
CREATE OR REPLACE PACKAGE BODY BARS.PKG_DBMS_SQL is

 type t_val    is table of pls_integer index by pls_integer; 
 type t_array  is table of t_val       index by pls_integer; 
 
 g_columns  t_array; -- descrg_columns(cursor)(position) := dbms_types.typecode_..
 
 procedure p_column_add
 (
  ip_cursor   in integer,
  ip_position in pls_integer,
  ip_typecode in pls_integer  
 )
 as
 begin
  g_columns(ip_cursor)(ip_position) := ip_typecode;
 end;
 
 procedure g_columns_delete
 (
  ip_cursor in integer
 )
 as
 begin
   if ip_cursor is not null then 
       g_columns(ip_cursor).delete;
   end if;
 exception
   when NO_DATA_FOUND then 
     null;
 end;

 
 function f_get_column_typecode
 (
  ip_cursor   in integer,
  ip_position in pls_integer  
 )
 return pls_integer
 as
 begin
   return g_columns(ip_cursor)(ip_position);
 end;
 
 procedure p_add_bind
 (
  ip_param_name in varchar2,
  ip_bind_type  in varchar2,
  ip_value      in number,
  p_bind        in out nocopy t_bind
 )
 as
 begin   
   p_bind(ip_param_name).number_value := ip_value;
   p_bind(ip_param_name).bind_type    := ip_bind_type;
   p_bind(ip_param_name).typecode     := DBMS_TYPES.TYPECODE_NUMBER;
 end;
 
 procedure p_add_bind
 (
  ip_param_name in varchar2,
  ip_bind_type  in varchar2,
  ip_value      in varchar2,
  p_bind        in out nocopy t_bind  
 )
 as
 begin   
   p_bind(ip_param_name).varchar2_value := ip_value;
   p_bind(ip_param_name).bind_type      := ip_bind_type;   
   p_bind(ip_param_name).typecode       := DBMS_TYPES.TYPECODE_VARCHAR2;
 end;
 
 procedure p_add_bind
 (
  ip_param_name in varchar2,
  ip_bind_type  in varchar2,  
  ip_value      in date,
  p_bind        in out nocopy t_bind  
 )
 as
 begin   
   p_bind(ip_param_name).date_value := ip_value;
   p_bind(ip_param_name).bind_type  := ip_bind_type;   
   p_bind(ip_param_name).typecode   := DBMS_TYPES.TYPECODE_DATE;
 end;
 
 procedure p_bind_variable
 (
  ip_cursor     in integer,
  ip_bind       in t_bind
 )
 as
  v_bind_nm refVariableLen;
 begin
   v_bind_nm := ip_bind.first; 
   while v_bind_nm is not null
   loop
    case ip_bind(v_bind_nm).typecode
     when dbms_types.typecode_DATE then 
       dbms_sql.bind_variable(ip_cursor, v_bind_nm, ip_bind(v_bind_nm).date_value);
     when dbms_types.typecode_NUMBER then 
       dbms_sql.bind_variable(ip_cursor, v_bind_nm, ip_bind(v_bind_nm).number_value);
     when dbms_types.TYPECODE_VARCHAR2 then 
       dbms_sql.bind_variable(ip_cursor, v_bind_nm, ip_bind(v_bind_nm).varchar2_value);
    end case; 
    v_bind_nm := ip_bind.next(v_bind_nm);                
  end loop;        
 end;

 procedure p_bind_variable_out
 (
  ip_cursor      in integer,
  ip_variable_nm in varchar2,
  ip_typecode    in pls_integer  
 )
 as
 v_bind   r_anydata;
 begin
   case ip_typecode
     when dbms_types.typecode_DATE then 
       dbms_sql.bind_variable(ip_cursor, ip_variable_nm, v_bind.date_value);
     when dbms_types.typecode_NUMBER then 
       dbms_sql.bind_variable(ip_cursor, ip_variable_nm, v_bind.number_value);
     when dbms_types.TYPECODE_VARCHAR2 then 
       dbms_sql.bind_variable(ip_cursor, ip_variable_nm, v_bind.varchar2_value, 4000);
    end case; 
 end;


 procedure p_parse
 (
  ip_cursor in integer,
  ip_sql    in varchar2
 )
 as
 begin   
   dbms_sql.parse(ip_cursor, ip_sql ,dbms_sql.native);
 exception
   when others then -- error of parsing
     null;
     raise;
 end;

 procedure p_define_column
 (
  ip_cursor   in integer,
  ip_position in integer,
  ip_typecode in pls_integer
 )
 as
  l_date      date;
  l_number    number;
  l_varchar2  varchar2(4000);  
 begin
    case ip_typecode
      when DBMS_TYPES.TYPECODE_DATE then 
        DBMS_SQL.DEFINE_COLUMN(ip_cursor, ip_position, l_date);       
      when DBMS_TYPES.TYPECODE_NUMBER then 
        DBMS_SQL.DEFINE_COLUMN(ip_cursor, ip_position, l_number);
      when DBMS_TYPES.TYPECODE_VARCHAR2 then 
        DBMS_SQL.DEFINE_COLUMN(ip_cursor, ip_position, l_varchar2, 4000);
    end case;

    p_column_add(ip_cursor, ip_position, ip_typecode);
    
 end;    

 procedure p_column_value
 (
  ip_cursor   in integer,
  ip_position in integer,
  op_val      out r_anydata
 )
 as
 begin    
   case f_get_column_typecode(ip_cursor,ip_position)
      when DBMS_TYPES.TYPECODE_DATE then 
        DBMS_SQL.COLUMN_VALUE(ip_cursor, ip_position, op_val.date_value);
      when DBMS_TYPES.TYPECODE_NUMBER then 
        DBMS_SQL.COLUMN_VALUE(ip_cursor, ip_position, op_val.number_value);
      when DBMS_TYPES.TYPECODE_VARCHAR2 then 
        DBMS_SQL.COLUMN_VALUE(ip_cursor, ip_position, op_val.varchar2_value);
    end case;                 
 end;    
 
 procedure p_variable_value
 (
  ip_cursor      in integer,
  ip_variable_nm in varchar2,
  ip_typecode    in pls_integer,
  op_val         out r_anydata
 )
 as  
 begin
   case ip_typecode
      when DBMS_TYPES.TYPECODE_DATE then 
        DBMS_SQL.VARIABLE_VALUE(ip_cursor, ip_variable_nm, op_val.date_value);       
      when DBMS_TYPES.TYPECODE_NUMBER then 
        DBMS_SQL.VARIABLE_VALUE(ip_cursor, ip_variable_nm, op_val.number_value);
      when DBMS_TYPES.TYPECODE_VARCHAR2 then 
        DBMS_SQL.VARIABLE_VALUE(ip_cursor, ip_variable_nm, op_val.varchar2_value);
    end case;        
 end;
 
 procedure p_close_cursor
 (
  ip_cursor in out integer
 )
 as
 begin   
   -- cleanup collection
   g_columns_delete(ip_cursor);
      
   dbms_sql.close_cursor(ip_cursor);   
 end; 
 

end PKG_DBMS_SQL;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/pkg_dbms_sql.sql =========*** End **
 PROMPT ===================================================================================== 
 
