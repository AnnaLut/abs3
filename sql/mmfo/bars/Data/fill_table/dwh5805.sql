prompt ===================================== 
prompt == Звіт завізованих документів другою візою
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_reports       DWH_REPORTS%rowtype;    
   l_reportsr      DWH_REPORTS%rowtype;    
   l_isnew     smallint:=0;       

begin     
   l_reports.name := 'Звіт завізованих документів другою візою';
   l_reports.id := '5805';

   begin                                                   
      select id into l_reportsr.id                      
      from DWH_REPORTS where id=l_reports.id;             
   exception when no_data_found then                       
      l_isnew:=1;                                          
   end;                                     
                                            

    ---------------------------    
    --  main dku_zvt zapros  --    
    ---------------------------    
                                  
    l_reports.name                 := 'Звіт завізованих документів другою візою';
    l_reports.TYPEID               := '2';
    l_reports.PARAMS               := '[{"Name":"p_sFdat1","Type":"Date","Value":"","Label":"На дату"},
 {"Name":"p_user","Type":"Text","Value":"0","Label":"ID виконавця"},
 {"Name":"p_che","Type":"Text","Value":"0","Label":"Група контролю","Control":{"Type":"select","Data":[{"Value":"%","Text":"%"},{"Value":"2","Text":"2"},{"Value":"11","Text":"11"},{"Value":"17","Text":"17"},{"Value":"24","Text":"24"},
 {"Value":"39","Text":"39"},{"Value":"41","Text":"41"},{"Value":"70","Text":"70"},{"Value":"71","Text":"71"},{"Value":"74","Text":"74"},{"Value":"75","Text":"75"}]}}
 ]';
    l_reports.TEMPLATE_NAME        := '';
    l_reports.RESULT_FILE_NAME     := '''5805_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat1,''DDMMYY.rar''),1,10)';
    l_reports.SQLPREPARE          := '     select oop.ref Референс_документу,'||nlchr||
                           '        oop.s Сума,'||nlchr||
                           '        oop.kv Валюта,'||nlchr||
                           '        oop.nlsa Рахунок_А,'||nlchr||
                           '        oop.nlsb Рахунок_B,'||nlchr||
                           '        oop.nazn Призначення_платежу,'||nlchr||
                           '        oop.tt Код_операції,'||nlchr||
                           '        st.fio ПІБ_виконавця,'||nlchr||
                           '        t.dat Час_візування_2ю_візою'||nlchr||
                           '   from oper oop,'||nlchr||
                           '        staff$base st,'||nlchr||
                           '        ((select n, ref, groupid, dat,userid'||nlchr||
                           '            from (select row_number() over(partition by op.ref order by op.dat) n,'||nlchr||
                           '                         op.ref,'||nlchr||
                           '                         op.groupid,'||nlchr||
                           '                         op.dat,'||nlchr||
                           '                         op.userid'||nlchr||
                           '                    from oper_visa op'||nlchr||
                           '                   where op.ref in'||nlchr||
                           '                         (select op_v.ref'||nlchr||
                           '                            from oper_visa op_v'||nlchr||
                           '                           where (decode(p_che,''%'',''%'',null) = ''%'''||nlchr||
                           '                                  and groupid in (11, 17, 24, 2, 39, 41, 70, 71, 74, 75)'||nlchr||
                           '                                  and op_v.userid = p_user and op_v.dat between trunc(to_date(p_sFdat1,''dd.mm.yyyy'')) and trunc(to_date(p_sFdat1,''dd.mm.yyyy'')+1)'||nlchr||
                           '                                 )'||nlchr||
                           '                              or (decode(p_che,''%'',''%'',''%%'') ^= ''%'''||nlchr||
                           '                                  and groupid in (p_che)'||nlchr||
                           '                                  and op_v.userid = p_user and op_v.dat between trunc(to_date(p_sFdat1,''dd.mm.yyyy'')) and trunc(to_date(p_sFdat1,''dd.mm.yyyy'')+1)'||nlchr||
                           '                                 )'||nlchr||
                           '                         )'||nlchr||
                           '                         and op.groupid is not null'||nlchr||
                           '                  )'||nlchr||
                           '           where n = 2'||nlchr||
                           '             and userid = p_user'||nlchr||
                           '             and ((decode(p_che,''%'',''%'',null) = ''%'' and groupid in (11, 17, 24, 2, 39, 41, 70, 71, 74, 75))'||nlchr||
                           '               or (decode(p_che,''%'',''%'',''%%'') ^= ''%'' and groupid in (p_che))'||nlchr||
                           '                 )'||nlchr||
                           '           )) t'||nlchr||
                           '  where t.userid = st.id'||nlchr||
                           '    and t.ref = oop.ref'||nlchr||
                           '';
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
  XLSX_BUILDER_PKG.set_column(2,XLSX_BUILDER_PKG.get_NumFmt(''#,##0.00''));
  XLSX_BUILDER_PKG.set_column(1,XLSX_BUILDER_PKG.get_NumFmt(''############''));

  XLSX_BUILDER_PKG.query2sheet(l_sql, p_column_headers => true, p_sheet => 1 );

XLSX_BUILDER_PKG.set_column_width(1, 25);  
XLSX_BUILDER_PKG.set_column_width(2, 30);
XLSX_BUILDER_PKG.set_column_width(3, 25);
XLSX_BUILDER_PKG.set_column_width(4, 25);
XLSX_BUILDER_PKG.set_column_width(5, 30);
XLSX_BUILDER_PKG.set_column_width(6, 90);
XLSX_BUILDER_PKG.set_column_width(7, 25);
XLSX_BUILDER_PKG.set_column_width(8, 43);
XLSX_BUILDER_PKG.set_column_width(9, 35);


  l_blob := XLSX_BUILDER_PKG.FINISH;  
     
  Insert into BARS.DWH_CBIREP_QUERIES_DATA  
              (CBIREP_QUERIES_ID, RESULT_FILE_NAME, LENGTH_FILE, fil)
  Values  (p_cbirep_queries_id, l_file_name, DBMS_LOB.GETLENGTH (l_blob), l_blob);

end; ';
    l_reports.stmt                := '';
    l_reports.FILE_NAME           := '''5805_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat1,''DDMMYY.xlsx''),1,11)';
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
   (5805, '$RM_DRU1');
COMMIT;
exception when others then null;
end;
/ 