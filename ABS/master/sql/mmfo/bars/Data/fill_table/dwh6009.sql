prompt ===================================== 
prompt == Ф601 Част.5 Інформація щодо власників істотної участі боржника-ЮО
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_reports       DWH_REPORTS%rowtype;    
   l_reportsr      DWH_REPORTS%rowtype;    
   l_isnew     smallint:=0;       

begin     
   l_reports.name := 'Ф601 Част.5 Інформація щодо власників істотної участі боржника-ЮО';
   l_reports.id := '6009';

   begin                                                   
      select id into l_reportsr.id                      
      from DWH_REPORTS where id=l_reports.id;             
   exception when no_data_found then                       
      l_isnew:=1;                                          
   end;                                     
                                            

    ---------------------------    
    --  main dku_zvt zapros  --    
    ---------------------------    
                                  
    l_reports.name                 := 'Ф601 Част.5 Інформація щодо власників істотної участі боржника-ЮО';
    l_reports.TYPEID               := '2';
    l_reports.PARAMS               := '[{"Name":"p_sFdat1","Type":"Date","Value":"","Label":"Останній сформований звіт в період з"},
 {"Name":"p_sFdat2","Type":"Date","Value":"","Label":"По"}]';
    l_reports.TEMPLATE_NAME        := '';
    l_reports.RESULT_FILE_NAME     := '''601p5_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat2,''DDMMYY.rar''),1,10)';
    l_reports.SQLPREPARE          := '';
    l_reports.DESCRIPTION         := '';
    l_reports.FORM_PROC           := 'declare
l_cbirep_q DWH_CBIREP_QUERIES%rowtype;
l_reports  DWH_REPORTS%rowtype;
p_cbirep_queries_id number := #P_ID#;
l_file_name varchar2(254);
l_sqlprepare varchar2(32000);
l_blob blob;
l_sql varchar2(32000);
l_per number;
begin

select *
  into l_cbirep_q
  from DWH_CBIREP_QUERIES
 where id =  p_cbirep_queries_id;
 
select *
  into l_reports
  from DWH_REPORTS
 where id = l_cbirep_q.rep_id;
 
     dwh_cbirep.set_status(p_cbirep_queries_id, ''startcreatedfile'');
     commit;
              
    l_file_name := ''select ''||dwh_cbirep.bind_variables(l_reports.file_name,l_cbirep_q.KEY_PARAMS)||'' from dual''; 
                                      
    EXECUTE IMMEDIATE   l_file_name into l_file_name;
      
    l_sql :=''
   select
 ROWNUM "N", 
 f.LASTNAME || '''' '''' || f.FIRSTNAME || '''' '''' || f.MIDDLENAME as "ФО ПІБ",
 f.INN "ФО номер платн. подат.",
 f.ISREZ "ФО резидентність",
 f.COUNTRYCOD "ФО код країни реєстрац. нериз.",
 f.PERCENT "ФО частка у статут. капіталі",
 f.STREETADDRESS || '''' ''''|| f.HOUSENO as "ФО місце реєстрації",
 uu.NAMEOJ "ЮО найменування",
 uu.CODEDRPOUOJ "ЮО код ЄДРПОУ",
 uu.REGISTRYDAYOJ || '''' ''''||  uu.NUMBERREGISTRYOJ as "ЮО дата та номер ДР",
 uu.ISREZOJ "ЮО резидентність",
 uu.COUNTRYCODOJ "ЮО код країни реєстрац. нериз.",
 uu.PERCENTOJ "ЮО частка у статут. капіталі"
from 
(select * from  nbu_gateway.CORE_OWNERPP_UO f where REQUEST_ID in(
   (select id from
   (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat 
       where DATA_TYPE_ID=12
       and (RPAD(LPAD(dat.KF, 7, ''''/''''), 8, ''''/''''))=DECODE ((sys_context(''''bars_context'''',''''user_branch'''')),''''/'''',(RPAD(LPAD(dat.KF, 7, ''''/''''), 8, ''''/'''')),(sys_context(''''bars_context'''',''''user_branch'''')))
       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(''''''||p_sFdat1||'''''',''''dd/mm/yyyy'''')
       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(''''''||p_sFdat2||'''''',''''dd/mm/yyyy'''')
       group by dat.KF)))) f,   
(select * from  nbu_gateway.CORE_OWNERJUR_UO uu where REQUEST_ID in(
   (select id from
   (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat 
       where DATA_TYPE_ID=13
       and (RPAD(LPAD(dat.KF, 7, ''''/''''), 8, ''''/''''))=DECODE ((sys_context(''''bars_context'''',''''user_branch'''')),''''/'''',(RPAD(LPAD(dat.KF, 7, ''''/''''), 8, ''''/'''')),(sys_context(''''bars_context'''',''''user_branch'''')))
       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(''''''||p_sFdat1||'''''',''''dd/mm/yyyy'''')
       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(''''''||p_sFdat2||'''''',''''dd/mm/yyyy'''')
       group by dat.KF)))) uu,
 branch b
where
 b.branch = sys_context(''''bars_context'''',''''user_branch'''')
 and f.rnk=uu.rnk
    '';
XLSX_BUILDER_PKG.clear_workbook;
XLSX_BUILDER_PKG.new_sheet(''Звіт'');    
XLSX_BUILDER_PKG.set_column(6,XLSX_BUILDER_PKG.get_NumFmt(''#,##0.00''));
XLSX_BUILDER_PKG.query2sheet(l_sql, p_column_headers => true, p_sheet => 1 );
  XLSX_BUILDER_PKG.set_column_width(2, 50);
  XLSX_BUILDER_PKG.set_column_width(3, 22);
  XLSX_BUILDER_PKG.set_column_width(4, 17);
  XLSX_BUILDER_PKG.set_column_width(5, 29);
  XLSX_BUILDER_PKG.set_column_width(6, 28);
  XLSX_BUILDER_PKG.set_column_width(7, 30);
  XLSX_BUILDER_PKG.set_column_width(8, 69);
  XLSX_BUILDER_PKG.set_column_width(9, 22);
  XLSX_BUILDER_PKG.set_column_width(10, 38);
  XLSX_BUILDER_PKG.set_column_width(11, 17);
  XLSX_BUILDER_PKG.set_column_width(12, 29);
  XLSX_BUILDER_PKG.set_column_width(13, 28);
  XLSX_BUILDER_PKG.query2sheet(l_sql); 
  l_blob := XLSX_BUILDER_PKG.FINISH;  
    
Insert into BARS.DWH_CBIREP_QUERIES_DATA  (  CBIREP_QUERIES_ID, RESULT_FILE_NAME, LENGTH_FILE, fil)
 Values  (  p_cbirep_queries_id, l_file_name, DBMS_LOB.GETLENGTH (l_blob)   , l_blob);

end; ';
    l_reports.stmt                := '';
    l_reports.FILE_NAME           := '''601p5_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat2,''DDMMYY.xlsx''),1,11)';
    l_reports.encoding            := 'UKG';

    ----------------------------------    
    --  main dku_zvt insert/update  --    
    ----------------------------------    
                                          

    if l_isnew = 1 then           
       insert into DWH_REPORTS values l_reports;  
    else                           
      update DWH_REPORTS set name         = l_reports.name,        
                         TYPEID           = l_reports.TYPEID, 
                         PARAMS           = l_reports.PARAMS,    
                         TEMPLATE_NAME    = l_reports.TEMPLATE_NAME,        
                         RESULT_FILE_NAME = l_reports.RESULT_FILE_NAME,   
                         SQLPREPARE       = l_reports.SQLPREPARE,     
                         DESCRIPTION      = l_reports.DESCRIPTION,      
                         FORM_PROC        = l_reports.FORM_PROC,     
                         STMT             = l_reports.STMT,          
                         FILE_NAME        = l_reports.FILE_NAME,          
                         ENCODING         = l_reports.ENCODING   
       where id=l_reports.id;                                
                                                           
    end if;                                                
end;                                        
/                                           
                                            
commit;          


begin
Insert into BARS.DWH_REPORT_LINKS
   (REPORT_ID, MODULE_ID)
 Values
   (6009, '$RM_DRU1');
COMMIT;
exception when others then null;
end;                           
/
