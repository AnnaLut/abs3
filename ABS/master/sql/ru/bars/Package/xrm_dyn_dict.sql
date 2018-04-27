create or replace package xrm_dyn_dict
as
   type t_tag_value is record
   (
      tag     varchar2 (5),
      key     varchar2 (220),
      descr   varchar2 (220)
   );

   type t_tag_value_set is table of t_tag_value;

   function get_tag_value
      return t_tag_value_set
      pipelined;
end xrm_dyn_dict;
/

create or replace package body xrm_dyn_dict
is
   function get_tag_value
      return t_tag_value_set
      pipelined
   is
      l_tab   t_tag_value_set;

      l_sql_stmt    varchar2 (4000);
   begin
      for c in (select tag, regexp_replace(lower(substr (browser, 12, length (browser) - 13)),'select ','select '''||tag||''' tag, ',1,0) sql_stmt --обрезать поля
                  from op_field
                 where     browser is not null
                       and regexp_count (substr (browser, 1, instr (lower (browser), 'from')), ',') = 1)
      loop
         
         begin 
         
            l_sql_stmt:=c.sql_stmt;   
         
            execute immediate l_sql_stmt  bulk collect into l_tab ;

            
            for i in 1..l_tab.count()
            loop
                pipe row (l_tab(i));
            end loop;
            
         exception when others 
            then  
                    if sqlcode = -00903 or sqlcode = -00904  or sqlcode = -01741   or sqlcode = -00942 or sqlcode = -01756 or sqlcode = -01722 or sqlcode= -06502
                            then 
                             null;
                    else raise; 
                    end if;
         end;
                     
      end loop;
   end;
begin
   null;
end xrm_dyn_dict;
/

grant execute on xrm_dyn_dict to bars_access_defrole;
grant execute on xrm_dyn_dict to bars_intgr with grant option;