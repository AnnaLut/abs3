prompt ======================================================
prompt *** Run *** === split partitions CUSTOMERW 
prompt ======================================================

set serveroutput on size unlimited
set sqlblanklines on

declare
  -- for better performance view V_DBO
  -- split partition P_OTHERS with values 'NDBO', 'DDBO' into P_NDBO, P_DDBO
  -- split partition P_DEFAULT with value SDBO into P_SDBO

  type tt_dbo_values is table of varchar2(30);
  l_table_name       varchar2(30) := 'CUSTOMERW';
  l_part_name        varchar2(30);
  l_part_curr        varchar2(30);
  l_dbo_values       tt_dbo_values := tt_dbo_values(q'['NDBO']', q'['DDBO']', q'['SDBO']');
  l_sttm             varchar2(4000);
  l_status           number := 0;
  l_time             number; 

     function get_part(p_value varchar2) return varchar2
      is
     begin
        for i in(
                 select partition_name
                       ,high_value 
                   from all_tab_partitions
                  where table_name  = l_table_name
                  ) loop
          if dbms_lob.instr(i.high_value, p_value) > 0 then
            return i.partition_name;
          end if;
        end loop;          
        return null;
     end;  
     -- find the value in the default partition
     function get_from_default(p_value varchar2) return varchar2
      is
       l_qty number;
     begin 
        execute immediate'
                 select count(*)
                   from '|| l_table_name || ' partition (p_default) '||
                ' where rownum <= 1 and tag = '|| p_value into l_qty;
        return case when l_qty > 0 then 'P_DEFAULT' end;
     end;  

begin
   execute immediate 'alter session enable parallel ddl';
   execute immediate 'alter session enable parallel dml';
   
   for i in 1..l_dbo_values.count loop
     l_part_name := 'P_'||replace(l_dbo_values(i), '''');
     l_part_curr := get_part(l_dbo_values(i));
     if l_part_curr is null then
       l_part_curr := get_from_default(l_dbo_values(i));
     end if;
     if l_part_curr is not null and l_part_curr <> l_part_name then
       l_sttm :=  'alter table '|| l_table_name ||
                  ' split partition '|| l_part_curr || ' values ('||l_dbo_values(i)||')'||
                  ' into (partition '|| l_part_name ||
                  '      ,partition '|| l_part_curr ||')' || ' update indexes';
       dbms_output.put_line(l_sttm);
       l_time := dbms_utility.get_time;
       execute immediate l_sttm;
       dbms_output.put_line((dbms_utility.get_time - l_time)/ 100|| ' sec');
       l_status := 1;
     elsif l_part_curr is null then 
       dbms_output.put_line('Partition not found for value > '||l_dbo_values(i));
     else
       dbms_output.put_line('Partition already exists > '||l_part_name);
     end if;                                    
   end loop;  
   if l_status = 1 then 
      dbms_output.put_line('start stats');
      l_time := dbms_utility.get_time;           
      dbms_stats.gather_table_stats( 
                           ownname          => 'BARS'
                          ,tabname          => l_table_name
                          ,estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE
                          );
      dbms_output.put_line((dbms_utility.get_time - l_time)/ 100|| ' sec');
   end if; 
end;
/

prompt ======================================================
prompt *** End *** === split partitions CUSTOMERW 
prompt ======================================================
