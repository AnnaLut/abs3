
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/secaudit_utl.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.SECAUDIT_UTL is

   ---------------------------------------------------------
   --
   --  Пакет по работе с бранчами
   --
   ---------------------------------------------------------

   ----------------------------------------------
   --  константы
   ----------------------------------------------

   G_HEADER_VERSION    constant varchar2(64) := 'version 1.0  08.02.2016';


   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   function header_version return varchar2;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   function body_version return varchar2;


 --------------------------------------------------------------
  --
  --  VIEW_ARC_DATA
  --
  --   Прилинковать к таблице  sec_audit_arch  - все файлы, которые отвечают архивным датам
  --
  procedure view_arc_data( p_start_date date,
                              p_end_date  date  default sysdate);


 --------------------------------------------------------------
  --
  --  ARCH_SECAUDIT
  --
  --   Архивация журнала
  --
  procedure arch_secaudit;

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.SECAUDIT_UTL is


   ---------------------------------------------------------
   --
   --  Пакет по работе c архивацией журнала аудита
   --
   ---------------------------------------------------------

   ----------------------------------------------
   --  константы
   ----------------------------------------------

   g_awk_body_defs     constant varchar2(512)  := '';
   G_BODY_VERSION      constant varchar2(64) := 'version 1.0  29.01.2016';
   G_TRACE             constant varchar2(50) := 'secaudit_utl.';
   G_ERRMOD            constant varchar2(10) := 'JAU';

   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   --
   --
   function header_version return varchar2
   is
   begin
       return 'package header secaudit_utl: ' || G_HEADER_VERSION;
   end header_version;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   --
   --
   function body_version return varchar2
   is
   begin
       return 'package body secaudit_utl: ' || G_BODY_VERSION;
   end body_version;



  --------------------------------------------------------------
  --
  --  CHECK_INTERVAL
  --
  --   Интервал не должен привышать пол года
  --
  function check_interval(p_start_date date,
                          p_end_date   date) return boolean
  is
  begin
     if  months_between(p_end_date,p_start_date) > 6 then return false;
	 else return true;
	 end if;
  end;


  --------------------------------------------------------------
  --
  --  LINK_TABLE
  --
  --   Прилинковать к таблице  sec_audit_arch  - все файлы, которые отвечают архивным датам
  --
  procedure link_table(p_start_date date,
                       p_end_date  date default sysdate)
  is
     start_date number;
     end_date number;
     l_file_name varchar2(50) := 'sec_audit_arch_';
     l_ddl_stmt  varchar2(32767) := 'alter table sec_audit_arch location (';
	 l_trace     varchar2(100)   := G_TRACE||'link_table:';
  begin
     start_date := to_number(to_char(trunc(p_start_date), 'j'));
     end_date   := to_number(to_char(trunc(p_end_date), 'j'));
     for cur_r in start_date..end_date loop
        l_ddl_stmt := l_ddl_stmt||''''||l_file_name||to_char(to_date(cur_r, 'j'), 'yyyy-mm-dd')||''''||case when cur_r <> end_date then ',' else ')' end;
     end loop;
     bars_audit.info(l_ddl_stmt);
     execute immediate l_ddl_stmt;
     bars_audit.info(l_trace||'Были прилинкованы файлы для просмотра архива журнала аудита с '||to_char(p_start_date,'dd/mm/yyyy')||' по '||to_char(p_end_date,'dd/mm/yyyy'));
	 dbms_output.put_line(l_ddl_stmt);
  end;

  --------------------------------------------------------------
  --
  --  VIEW_ARC_DATA
  --
  --   Прилинковать к таблице  sec_audit_arch  - все файлы, которые отвечают архивным датам
  --
  procedure view_arc_data( p_start_date date,
                              p_end_date  date  default sysdate) is
  begin
      if check_interval(p_start_date, p_end_date) then
	     link_table(p_start_date, p_end_date);
	  else
	     bars_error.raise_nerror('G_ERRMOD', 'INTERVAL_TOO_LONG');
      end if;
  end;



  --------------------------------------------------------------
  --
  --  ARCH_SECAUDIT
  --
  --   Архивация журнала
  --
  procedure arch_secaudit is
      l_c_min_date varchar2(100);
      l_d_min_date date;
      l_interval interval year to month;
      l_file_name varchar2(50) := 'sec_audit_arch_';
      l_partition_name varchar2(100);
  begin
    select tp.high_value, tp.partition_name
	  into l_c_min_date, l_partition_name
    from user_tab_partitions tp
    where tp.table_name = 'SEC_AUDIT'
    and tp.partition_position = 2;
    execute immediate 'select numtoyminterval(months_between(sysdate,'||l_c_min_date||'), ''month''),'||l_c_min_date||' from dual' into l_interval, l_d_min_date;
    --if l_interval >= numtoyminterval(1,'year') then
        l_file_name := l_file_name||to_char(l_d_min_date-(24/60/60),'yyyy-mm-dd');
        execute immediate 'create table upload_data_pump organization external
                          (type oracle_datapump
                           default directory DATA_PUMP_DIR
                           access parameters (compression enabled nologfile)
                           location ('''||l_file_name||''')) as
                           select rec_id,
                                  rec_uid,
                                  rec_uname,
                                  rec_uproxy,
                                  rec_date,
                                  rec_bdate,
                                  rec_type,
                                  rec_module,
                                  rec_message,
                                  machine,
                                  rec_object,
                                  rec_userid,
                                  branch,
                                  rec_stack,
                                  client_identifier
                           from sec_audit partition ('||l_partition_name||')';
        execute immediate 'drop table upload_data_pump purge';
        execute immediate 'alter table sec_audit_arch location ('''||l_file_name||''')';
        execute immediate 'alter table sec_audit drop partition '||l_partition_name||' update global indexes';
    --end if;
   end;






end secaudit_utl;
/
 show err;
 
PROMPT *** Create  grants  SECAUDIT_UTL ***
grant EXECUTE                                                                on SECAUDIT_UTL    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/secaudit_utl.sql =========*** End **
 PROMPT ===================================================================================== 
 