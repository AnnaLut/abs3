
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_high_value_part_tbl.sql =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_HIGH_VALUE_PART_TBL ( p_table_name in varchar2, p_partition_name in varchar2 )
  return varchar2
  authid current_user
 is
     l_high_value user_tab_partitions.high_value%type;
 begin
     select high_value into l_high_value
       from user_tab_partitions
      where table_name = p_table_name
        and partition_name = p_partition_name;

    if ( l_high_value is not null )
     then
     return substr(l_high_value, 1, 4000);
     else
       return null;
     end if;
 end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_high_value_part_tbl.sql =======
 PROMPT ===================================================================================== 
 