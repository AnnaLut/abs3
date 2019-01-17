
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/pkg_ddl.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PKG_DDL is

  -- Author  : ADMIN
  -- Created : 10.10.2018 17:48:50
  -- Purpose : execute ddl command
  
  procedure p_partition_truncate
  (
   ip_table        in varchar2,
   ip_partition    in varchar2
  ); 
  
  procedure p_subpartition_for_lock
  (
   ip_table        in varchar2,
   ip_for          in varchar2
  );
  
  procedure p_table_truncate
  (
   ip_table        in varchar2
  );
  
  procedure p_subpartition_truncate
 (
  ip_table        in varchar2,
  ip_part_value   in date,
  ip_subp_value   in varchar2
 );
  
  
end PKG_DDL;
/
CREATE OR REPLACE PACKAGE BODY BARS.PKG_DDL is
 
 procedure execute_immediate
 (
  ip_sql in varchar2
 )
 as
 pragma autonomous_transaction;
 begin
   execute immediate ip_sql;
 end;
 
 procedure p_partition_truncate
  (
   ip_table        in varchar2,
   ip_partition    in varchar2
  )
 as
 begin
   execute_immediate('alter table '||ip_table||' truncate partition '||ip_partition);
 end; 

 procedure p_subpartition_for_lock
  (
   ip_table        in varchar2,
   ip_for          in varchar2
  )
  as
 begin
  execute_immediate('lock table '||ip_table||' subpartition for '||ip_for||' in exclusive mode');
 end;
 
 procedure p_table_truncate
  (
   ip_table        in varchar2
  )
  as
 begin
   execute_immediate('truncate table '||ip_table);
 end;
 
 
 procedure p_subpartition_truncate
 (
  ip_table        in varchar2,
  ip_part_value   in date,
  ip_subp_value   in varchar2
 )
 as
 begin
   execute_immediate( 'alter table '||ip_table||' truncate subpartition for (date '''||to_char(ip_part_value,'YYYY-MM-DD')||''', ''' || ip_subp_value || ''' )') ;
 end;
 


end PKG_DDL;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/pkg_ddl.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 