

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/KFILE_FORM_REPORT_BLOB.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure KFILE_FORM_REPORT_BLOB ***

  CREATE OR REPLACE PROCEDURE BARS.KFILE_FORM_REPORT_BLOB (
                                               p_kodz            number,
                                               p_encode          varchar2,
                                               p_reptype         number,
                                               p_prior_statement varchar2,
                                               p_fname_statement varchar2,
                                               p_rep_date        date,
                                               p_filename out varchar2,
                                               p_path     out varchar2,
                                               p_blob     out blob) is
    l_row      zapros%rowtype;
    l_txt      varchar2(4000);
    l_datechr  varchar2(10);
    l_filename varchar2(1000);
    l_trace    varchar2(1000) :=  'kfileform_report_blob: ';

    TYPE EmpCurTyp  IS REF CURSOR;
    v_emp_cursor    EmpCurTyp;
    type t_rec is record ( x clob);
    l_rec t_rec;
    l_clob clob;
  begin

    bars_audit.log_info('kfileform_report_blob',
                        'p_kodz            : ' || p_kodz            || chr(10) ||
                        'p_encode          : ' || p_encode          || chr(10) ||
                        'p_reptype         : ' || p_reptype         || chr(10) ||
                        'p_fname_statement : ' || p_fname_statement || chr(10) ||
                        'p_prior_statement : ' || p_prior_statement || chr(10) ||
                        'p_rep_date        : ' || p_rep_date,
                        p_make_context_snapshot => true);
--    dbms_output.put_line();

    gl.pl_dat(p_rep_date);

    select * into l_row from zapros where kodz = p_kodz;
    execute immediate 'alter session set nls_date_format="dd/mm/yyyy"';
    l_datechr  := to_char(gl.bd, 'dd/mm/yyyy');
    l_txt      := replace(l_row.txt,
                          ':sFdat1',
                          ' to_char(gl.bd,''dd/mm/yyyy'') ');

    execute immediate (p_fname_statement) into l_filename;


    if (p_prior_statement is not null) then
       execute immediate('begin ' ||p_prior_statement||'; end;');
    end if;

    bars_audit.info(l_trace || 'formula for file name: ' || l_filename);

    --DBF формат
    if p_reptype = 201 then
      open v_emp_cursor FOR l_txt;

      loop
        fetch v_emp_cursor into l_rec;
        exit when v_emp_cursor%notfound;
        l_clob := l_clob ||l_rec.x||chr(13)||chr(10);
      end loop;
      close v_emp_cursor;
      if l_clob is not null then
         p_blob := pfu.pfu_utl.clob_to_blob(l_clob);
      end if;
      /*bars_dbf.dbf_from_sql(p_sql       => l_txt,
                            p_dbfstruct => 'NAME CHAR(800)',
                            p_encode    => p_encode,
                            p_blobdbf   => p_blob);*/
    end if;

    p_filename := l_filename;/*
    begin
      execute immediate 'select ' || l_filename || ' from dual'
        into p_filename;
    exception
      when others then
        bars_audit.error(l_trace ||
                         'Некооректно указана формула для имени файла: ' ||
                         l_filename);
        raise;
    end;*/
    p_path := branch_attribute_utl.get_value('TMS_REPORTS_DIR');
 exception
    when others then
         bars_audit.log_error('bars_report.form_report_blob', l_filename || sqlerrm || chr(10) || dbms_utility.format_error_backtrace(), p_make_context_snapshot => true);
         raise;

end ;
/
show err;

PROMPT *** Create  grants  KFILE_FORM_REPORT_BLOB ***
grant EXECUTE                                                                on KFILE_FORM_REPORT_BLOB to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/KFILE_FORM_REPORT_BLOB.sql =======
PROMPT ===================================================================================== 
