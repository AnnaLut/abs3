prompt ===================================== 
prompt == Ф601 Частина 2 Інформація про кредитну операцію боржника - ФО
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_reports       DWH_REPORTS%rowtype;    
   l_reportsr      DWH_REPORTS%rowtype;    
   l_isnew     smallint:=0;       

begin     
   l_reports.name := 'Ф601 Частина 2 Інформація про кредитну операцію боржника - ФО';
   l_reports.id := '6006';

   begin                                                   
      select id into l_reportsr.id                      
      from DWH_REPORTS where id=l_reports.id;             
   exception when no_data_found then                       
      l_isnew:=1;                                          
   end;                                     
                                            

    ---------------------------    
    --  main dku_zvt zapros  --    
    ---------------------------    
                                  
    l_reports.name                 := 'Ф601 Частина 2 Інформація про кредитну операцію боржника - ФО';
    l_reports.TYPEID               := '2';
    l_reports.PARAMS               := '[{"Name":"p_sFdat1","Type":"Date","Value":"","Label":"Останній сформований звіт в період з"},
 {"Name":"p_sFdat2","Type":"Date","Value":"","Label":"По"}]';
    l_reports.TEMPLATE_NAME        := '';
    l_reports.RESULT_FILE_NAME     := '''601p2_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat2,''DDMMYY.rar''),1,10)';
    l_reports.SQLPREPARE          := 'select'||nlchr||
                           ' ROWNUM N, '||nlchr||
                           ' c.TYPECREDIT Вид_кредиту_наданого_фін_зоб,'||nlchr||
                           ' c.NUMDOG Номер_договору,'||nlchr||
                           ' c.DOGDAY Дата_укладання_договору,'||nlchr||
                           ' c.ENDDAY Кінцева_дата_погашення,'||nlchr||
                           ' c.SUMZAGAL Загальна_сума_наданого_ФЗ,'||nlchr||
                           ' c.R030 Код_валюти,'||nlchr||
                           ' c.PROCCREDIT Процентна_ставка,'||nlchr||
                           ' c.SUMPAY Розмір_платежів_за_КО,'||nlchr||
                           ' c.PERIODBASE Періодичність_сплати_осн_б,'||nlchr||
                           ' c.PERIODPROC Періодичність_сплати_проц,'||nlchr||
                           ' c.SUMARREARS Заборгованість_за_КО,'||nlchr||
                           ' c.ARREARBASE Прострочена_заборг_осн_б,'||nlchr||
                           ' c.ARREARPROC Прострочена_заборг_проц,'||nlchr||
                           ' c.DAYBASE Кільк_днів_простр_заб_осн_б,'||nlchr||
                           ' c.DAYPROC Кіль_днів_простр_заб_проц,'||nlchr||
                           ' c.FACTENDDAY Дата_фактичного_погашення,'||nlchr||
                           ' c.FLAGZ Примусове_стягнення_боргу,'||nlchr||
                           ' c.KLASS Клас_боржника,'||nlchr||
                           ' c.RISK Величина_кредитного_ризику'||nlchr||
                           'from '||nlchr||
                           ' branch b,'||nlchr||
                           '(select * from  nbu_gateway.CORE_CREDIT c where REQUEST_ID in('||nlchr||
                           ' (select id from'||nlchr||
                           ' (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=15'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) c,'||nlchr||
                           '(select * from  nbu_gateway.core_person_fo pf where REQUEST_ID in('||nlchr||
                           ' (select id from'||nlchr||
                           ' (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=1'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) pf,'||nlchr||
                           '       (select * from  nbu_gateway.NBU_SESSION n where trunc(CAST(n.CREATED_AT AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(n.CREATED_AT AS DATE)) <= :sFdat2) n'||nlchr||
                           'where'||nlchr||
                           'b.branch = sys_context(''bars_context'',''user_branch'')'||nlchr||
                           'and c.rnk=pf.rnk'||nlchr||
                           'and n.OBJECT_ID=c.LOAN_OBJECT_ID'||nlchr||
                           'and n.STATE_ID=9';
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
  
  l_sql := dwh_cbirep.bind_variables(l_reports.sqlprepare,l_cbirep_q.KEY_PARAMS);
 
  XLSX_BUILDER_PKG.clear_workbook;
  XLSX_BUILDER_PKG.new_sheet(''Звіт'');    
  XLSX_BUILDER_PKG.set_column(6,XLSX_BUILDER_PKG.get_NumFmt(''#,##0.00''));
  XLSX_BUILDER_PKG.set_column(8,XLSX_BUILDER_PKG.get_NumFmt(''#,##0.00''));
  XLSX_BUILDER_PKG.set_column(9,XLSX_BUILDER_PKG.get_NumFmt(''#,##0.00''));
  XLSX_BUILDER_PKG.set_column(12,XLSX_BUILDER_PKG.get_NumFmt(''#,##0.00''));
  XLSX_BUILDER_PKG.set_column(13,XLSX_BUILDER_PKG.get_NumFmt(''#,##0.00''));
  XLSX_BUILDER_PKG.set_column(14,XLSX_BUILDER_PKG.get_NumFmt(''#,##0.00''));

  XLSX_BUILDER_PKG.query2sheet(l_sql, p_column_headers => true, p_sheet => 1 );

XLSX_BUILDER_PKG.set_column_width(1, 10); 
XLSX_BUILDER_PKG.set_column_width(2, 30);
XLSX_BUILDER_PKG.set_column_width(3, 30);
XLSX_BUILDER_PKG.set_column_width(4, 25);
XLSX_BUILDER_PKG.set_column_width(5, 25);
XLSX_BUILDER_PKG.set_column_width(6, 26);
XLSX_BUILDER_PKG.set_column_width(7, 12);
XLSX_BUILDER_PKG.set_column_width(8, 17);
XLSX_BUILDER_PKG.set_column_width(9, 23);
XLSX_BUILDER_PKG.set_column_width(10, 30);
XLSX_BUILDER_PKG.set_column_width(11, 30);
XLSX_BUILDER_PKG.set_column_width(12, 29);
XLSX_BUILDER_PKG.set_column_width(13, 30);
XLSX_BUILDER_PKG.set_column_width(14, 30);
XLSX_BUILDER_PKG.set_column_width(15, 30);
XLSX_BUILDER_PKG.set_column_width(16, 30);
XLSX_BUILDER_PKG.set_column_width(17, 30);
XLSX_BUILDER_PKG.set_column_width(18, 30);
XLSX_BUILDER_PKG.set_column_width(19, 20);
XLSX_BUILDER_PKG.set_column_width(20, 30); 

  l_blob := XLSX_BUILDER_PKG.FINISH;  
     
  Insert into BARS.DWH_CBIREP_QUERIES_DATA  
              (CBIREP_QUERIES_ID, RESULT_FILE_NAME, LENGTH_FILE, fil)
  Values  (p_cbirep_queries_id, l_file_name, DBMS_LOB.GETLENGTH (l_blob), l_blob);

end; ';
    l_reports.stmt                := '';
    l_reports.FILE_NAME           := '''601p2_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat2,''DDMMYY.xlsx''),1,11)';
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
