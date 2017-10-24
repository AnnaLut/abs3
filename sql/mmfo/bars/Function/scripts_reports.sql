
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/scripts_reports.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SCRIPTS_REPORTS (p_rep_id number, p_kodz number) return clob
 as
       nlchr      char(2) := chr(13)||chr(10);
       l_txt      varchar2(32000);
 
       l_clob     clob;
       p_clob_scrpt clob;
       l_text1 varchar2(4000);
       l_table_name USER_TAB_PRIVS_MADE.table_name%type;
       
       l_rep_id reports.id%type;
       l_idf reports.idf%type;
       l_kodz zapros.kodz%type;
       l_pkey zapros.pkey%type;
       l_form int;
            
       PRAGMA AUTONOMOUS_TRANSACTION;
       
 begin
 
  
        p_clob_scrpt:= null;   l_clob:= null;
       dbms_lob.createtemporary(l_clob,  FALSE);
       
     begin 
      select rep_id, idf, kodz, pkey, to_number(substr(param,instr(param,',')+1,instr(substr(param,instr(param,',')+1,10),',')-1)) form 
        into l_rep_id, l_idf, l_kodz, l_pkey, l_form
        from V_CBIREP_REPPARAMS 
       where rep_id = p_rep_id;
     exception when no_data_found then 
     l_kodz:=p_kodz;  
     end;
 
     dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);
     dbms_lob.append(l_clob,          rpad('PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/'||replace(l_pkey,'\','_')||'.sql'||' =========*** Run *** ',92,'=') ||nlchr);
     dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);
 
 
  
        bars_report.export_to_script(
                                      p_kodz          => l_kodz,
                                      p_repinsert     => 1,
                                      p_repfixid      => l_rep_id,
                                      p_reptype       => l_form,
                                      p_repfolder     => l_idf --,     p_clob_scrpt    => p_clob_scrpt
                                      );
     bars_lob.import_clob(p_clob_scrpt);                        
     dbms_lob.append(l_clob, p_clob_scrpt||nlchr);  
     commit;
    
      
    dbms_lob.append(l_clob, nlchr||nlchr||'PROMPT ===================================================================================== ' ||nlchr);   
    dbms_lob.append(l_clob,       rpad(   'PROMPT *** End *** ========== Scripts /Sql/Bars/Data/'||replace(l_pkey,'\','_')||'.sql'||' =========*** End *** ',92,'=') ||nlchr);
    dbms_lob.append(l_clob,               'PROMPT ===================================================================================== ' ||nlchr);
      return l_clob;
 end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/scripts_reports.sql =========*** En
 PROMPT ===================================================================================== 
 