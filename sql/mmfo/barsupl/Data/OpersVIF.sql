prompt Файл выгрузки OpersVIF

set define off
declare 
l_sql clob := to_clob(q'$
declare
l_param1 varchar2(128) := :param1;
cur sys_refcursor;
type t_text is table of varchar2(600);
l_bulk_data t_text := t_text();
l_index pls_integer := 1;
l_file_part_index pls_integer := 1;

l_clob_data clob;

l_filename varchar2(256);
------------------------------------------------------------------------------
begin
    l_filename := BARSUPL.BARS_UPLOAD.get_param('STAT_FILE_NAME');

    begin
        dbms_lob.createtemporary(l_clob_data, true);

        open cur for
        select (select bars.gl.kf from dual)||';'||
           o.mfoa||';'||
           o.nlsa||';'||
           o.mfob||';'||
           o.nlsb||';'||
           to_char(o.dk)||';'||
           to_char(o.s)||';'||
           to_char(o.vob)||';'||
           to_char(trunc(od.ref / 100))||';'||
           to_char(o.kv)||';'||
           to_char(o.datd, 'dd/mm/yyyy')||';'||
           o.nam_a||';'||
           o.nam_b||';'||
           o.nazn||';'||
           o.id_a||';'||
           o.id_b||';'||
           to_char(od.fdat, 'dd/mm/yyyy') text
      from bars.oper o, bars.opldok od
     where od.ref = o.ref
       and od.sos = 5
       and od.fdat between trunc(TO_DATE (l_param1, 'dd/mm/yyyy'), 'YEAR') and TRUNC(ADD_MONTHS(TO_DATE(l_param1, 'dd/mm/yyyy'), 12), 'YEAR')-1;
       
       loop
           -- collect data
           fetch cur bulk collect into l_bulk_data limit 100000;
           l_index := l_bulk_data.first;
           if DBMS_LOB.isopen(l_clob_data) = 0
           then
                dbms_lob.open(l_clob_data, dbms_lob.lob_readwrite);
           end if;
           while l_index is not null
           loop
               dbms_lob.writeappend( l_clob_data, length(l_bulk_data(l_index))+1, l_bulk_data(l_index) || chr(10) );
               l_index := l_bulk_data.next(l_index);
               
               if dbms_lob.getlength(l_clob_data) > 1073741824 then
                   -- make file on CLOB maxsize (1GB)
                   dbms_xslprocessor.clob2file(cl        => l_clob_data,
                                               flocation => 'UPLD',
                                               fname     => l_filename || '_p' || l_file_part_index);
                   l_file_part_index := l_file_part_index + 1;
                   if DBMS_LOB.isopen(l_clob_data) = 1
                   then
                       DBMS_LOB.Close(l_clob_data);
                   end if;
                   dbms_lob.freetemporary(l_clob_data);
                   dbms_lob.createtemporary(l_clob_data, true);
               end if;
           end loop;
       exit when cur%notfound;
       end loop;

       -- make last file
       dbms_xslprocessor.clob2file(cl        => l_clob_data,
                                   flocation => 'UPLD',
                                   fname     => l_filename || '_p'||l_file_part_index);
       dbms_lob.freetemporary(l_clob_data);


       commit;
    end;
                                   
   -- merge files into one
   declare
   l_dir_path varchar2(160);
   l_os varchar2(64);
   begin
       select directory_path into l_dir_path from all_directories where directory_name = 'UPLD';
       select value into l_os from upl_params where param = 'ORACLE_OS';
       -- java call
       barsos.j_mergeFiles(l_dir_path, l_filename, l_dir_path || case when l_os = 'UNIX' then '/' else '\' end || l_filename);
   end;
exception
    when others then
        bars.bars_audit.error('VIF_UPLOAD OpersVIF: '||l_filename||':'||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
        raise;
end;
$');
begin
    update upl_sql
    set after_proc = l_sql
    where sql_id = 98;
    commit;
end;
/