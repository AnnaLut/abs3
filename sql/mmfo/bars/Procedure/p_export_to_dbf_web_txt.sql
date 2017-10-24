

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_EXPORT_TO_DBF_WEB_TXT.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_EXPORT_TO_DBF_WEB_TXT ***

  CREATE OR REPLACE PROCEDURE BARS.P_EXPORT_TO_DBF_WEB_TXT (p_kodz    number,
                                                     p_stmt    varchar2)
is
   l_clob        clob;
   l_blob        blob;
   nlchr         char (2) := chr (13) || chr (10);
   l_form_proc   varchar2 (4000);
   l_stmt        varchar2 (4000);
   l_tag         varchar2 (4000);
   l_value       varchar2 (4000);

   type empcurtyp is ref cursor;

   emp_cv        empcurtyp;

   type rec is record (name varchar2 (4000));

   emp_rec       rec;
   sql_stmt      varchar2 (4000);
   l_namef       varchar2 (4000);
   l_exec_name   varchar2 (4000);

   function c2b (c in clob)
      return blob
   is
      pos       pls_integer := 1;
      buffer    raw (32767);
      res       blob;
      lob_len   pls_integer := dbms_lob.getlength (c);
   begin
      dbms_lob.createtemporary (res, true);
      dbms_lob.open (res, dbms_lob.lob_readwrite);

      loop
         buffer := utl_raw.cast_to_raw (dbms_lob.substr (c, 16000, pos));

         if utl_raw.length (buffer) > 0
         then
            dbms_lob.writeappend (res, utl_raw.length (buffer), buffer);
         end if;

         pos := pos + 16000;
         exit when pos > lob_len;
      end loop;

      return res;
   end c2b;
function replace_sfdat (p_tag varchar2, p_cnt number default 5)
   return varchar2
is
   l_tag   varchar2 (4000);
begin
l_tag:=p_tag;
   for c in 1 .. p_cnt
   loop
      l_tag :=
         replace (l_tag,
                  ':sFdat' || c,
                  'to_date(:sFdat' || c || ',''dd/mm/yyyy'')');
   end loop;
   return l_tag;
end;

begin
   l_stmt := nvl(p_stmt,0);

   select form_proc ,namef,txt
     into l_form_proc,l_namef,sql_stmt
     from zapros
    where kodz = p_kodz;

   l_form_proc :=replace_sfdat(l_form_proc);
   l_namef :=replace_sfdat(l_namef);
   sql_stmt :=replace_sfdat(sql_stmt);


   for c in 1 .. length (l_stmt) - length (replace (l_stmt, ':', ''))
   loop
      l_tag := substr (l_stmt, instr (l_stmt, ':'), instr (l_stmt, '=') - 1);
      l_value :=
         substr (l_stmt,
                 instr (l_stmt, '=') + 1,
                 instr (l_stmt, ';') - 1 - instr (l_stmt, '='));
      l_stmt := substr (l_stmt, instr (l_stmt, ';') + 1, length (l_stmt));
      l_value := '''' || l_value || '''';
      if l_form_proc is not null then
      l_form_proc := replace (l_form_proc, l_tag, l_value);
      end if;
      if l_namef is not null then
      l_namef     := replace (l_namef, l_tag, l_value);
      end if;
      if sql_stmt is not null then
      sql_stmt    := replace (sql_stmt, l_tag, l_value);
      end if;

   end loop;



   execute immediate 'begin ' || l_form_proc || '; end;';
   execute immediate l_namef into l_exec_name;


   open emp_cv for sql_stmt;
   loop
      fetch emp_cv into emp_rec;

      exit when emp_cv%notfound;
      l_clob := l_clob || emp_rec.name || nlchr;
   end loop;
   close emp_cv;

   if l_clob<>empty_clob()  then
   l_blob := c2b (l_clob);
  

   insert into tmp_export_to_dbf (id,
                                  kodz,
                                  userid,
                                  creating_date,
                                  data,
                                  file_name)
        values (s_tmp_export_to_dbf.nextval,
                p_kodz,
                user_id,
                sysdate,
                l_blob,
                l_exec_name);
   end if;
end;
/
show err;

PROMPT *** Create  grants  P_EXPORT_TO_DBF_WEB_TXT ***
grant EXECUTE                                                                on P_EXPORT_TO_DBF_WEB_TXT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_EXPORT_TO_DBF_WEB_TXT.sql ======
PROMPT ===================================================================================== 
