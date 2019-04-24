prompt ===================================== 
prompt == �601 ������� 4 ���������� ��� ��������  - ��
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_reports       DWH_REPORTS%rowtype;    
   l_reportsr      DWH_REPORTS%rowtype;    
   l_isnew     smallint:=0;       

begin     
   l_reports.name := '�601 ������� 4 ���������� ��� ��������  - ��';
   l_reports.id := '6008';

   begin                                                   
      select id into l_reportsr.id                      
      from DWH_REPORTS where id=l_reports.id;             
   exception when no_data_found then                       
      l_isnew:=1;                                          
   end;                                     
                                            

    ---------------------------    
    --  main dku_zvt zapros  --    
    ---------------------------    
                                  
    l_reports.name                 := '�601 ������� 4 ���������� ��� ��������  - ��';
    l_reports.TYPEID               := '2';
    l_reports.PARAMS               := '[{"Name":"p_sFdat1","Type":"Date","Value":"","Label":"������� ����������� ��� � ����� �"},
 {"Name":"p_sFdat2","Type":"Date","Value":"","Label":"��"}]';
    l_reports.TEMPLATE_NAME        := '';
    l_reports.RESULT_FILE_NAME     := '''601p4_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat2,''DDMMYY.rar''),1,10)';
    l_reports.SQLPREPARE          := 'select '||nlchr||
                           ' pu.rnk rnk,'||nlchr||
                           ' pu.NAMEUR ������������,'||nlchr||
                           ' pu.CODEDRPOU ����������������_���,'||nlchr||
                           ' pu.ISREZ ������������,'||nlchr||
                           ' pu.COUNTRYCODNEREZ ���_�����_�������_�����,'||nlchr||
                           ' pu.REGISTRYDAY || '' '' || pu.NUMBERREGISTRY as ����_��_�����_����_�����,'||nlchr||
                           ' pu.K110 ���_���������_��������,'||nlchr||
                           ' pu.EC_YEAR �����_����_���_������_�����,'||nlchr||
                           ' uo.SALES ������_�����_SALES,'||nlchr||
                           ' uo.EBIT ������_�����_EBIT,'||nlchr||
                           ' uo.EBITDA ������_�����_EBITDA,'||nlchr||
                           ' uo.TOTALDEBT ������_�����_TOTAL_NET_DEBT,'||nlchr||
                           ' gu.WHOIS ��������_��_����_�����_�����,'||nlchr||
                           ' gu.NAMEURGR ������_�_�����_�����_�����,'||nlchr||
                           ' gu.CODEDRPOUGR ����_������_��_���_�������,'||nlchr||
                           ' pu.ISCONTROLLER ������_�����_�_����,'||nlchr||
                           ' uos.SALESGR ������_�����_�����_����_SALES,'||nlchr||
                           ' uos.EBITGR ������_�����_�����_����_EBIT,'||nlchr||
                           ' uos.EBITDAGR ������_�����_���_����_EBITDA,'||nlchr||
                           ' uos.TOTALDEBTGR ������_�����_�_����_TOTAL_N_D,'||nlchr||
                           ' pru.NAMEURPR �����_��_����_�_���_�����_���,'||nlchr||
                           ' pru.CODEDRPOUPR ����_������_�_���_�����_���,'||nlchr||
                           ' FINU.SALES ����_�����_����_SALES,'||nlchr||
                           ' FINU.EBIT ����_�����_����_EBIT,'||nlchr||
                           ' FINU.EBITDA ����_�����_����_EBITDA,'||nlchr||
                           ' FINU.TOTALDEBT ����_�����_����_TOTAL_N_D,'||nlchr||
                           ' pu.ISAUDIT ����_������_������_���_����,'||nlchr||
                           ' pu.K060 ���_����_�����_�_����_�����,'||nlchr||
                           ' pu.ISKR ���_��������_�����_���_��_���'||nlchr||
                           ' from'||nlchr||
                           'branch b,'||nlchr||
                           '(select * from  nbu_gateway.CORE_PERSON_UO pu where REQUEST_ID in('||nlchr||
                           '      (select id from'||nlchr||
                           '      (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=6'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) pu,'||nlchr||
                           '(select * from  nbu_gateway.CORE_PARTNERS_UO pru where REQUEST_ID in('||nlchr||
                           '      (select id from'||nlchr||
                           '      (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=10'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) pru,'||nlchr||
                           '(select * from  nbu_gateway.CORE_FINPERFORMANCEPR_UO FINU where REQUEST_ID in('||nlchr||
                           '      (select id from'||nlchr||
                           '      (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=11'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) FINU,'||nlchr||
                           '(select * from  nbu_gateway.core_finperformance_uo uo where REQUEST_ID in('||nlchr||
                           '      (select id from'||nlchr||
                           '      (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=7'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) uo,'||nlchr||
                           '(select * from  nbu_gateway.CORE_FINPERFORMANCEGR_UO uos where REQUEST_ID in('||nlchr||
                           '      (select id from'||nlchr||
                           '      (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=9'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) uos,'||nlchr||
                           '(select * from  nbu_gateway.CORE_GROUPUR_UO gu where REQUEST_ID in('||nlchr||
                           '      (select id from'||nlchr||
                           '      (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=8'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) gu,'||nlchr||
                           '       (select * from  nbu_gateway.NBU_SESSION n where trunc(CAST(n.CREATED_AT AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(n.CREATED_AT AS DATE)) <= :sFdat2) n'||nlchr||
                           'where'||nlchr||
                           'b.branch = sys_context(''bars_context'',''user_branch'')'||nlchr||
                           'and pu.rnk=pru.rnk(+)'||nlchr||
                           'and pu.rnk=FINU.rnk(+)'||nlchr||
                           'and pu.rnk=uo.rnk(+)'||nlchr||
                           'and pu.rnk=uos.rnk(+)'||nlchr||
                           'and pu.rnk=gu.rnk(+)'||nlchr||
                           'and n.OBJECT_ID=pu.COMPANY_OBJECT_ID'||nlchr||
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
  XLSX_BUILDER_PKG.new_sheet(''���'');    
 -- XLSX_BUILDER_PKG.set_column(14,XLSX_BUILDER_PKG.get_NumFmt(''#,##0.00''));

  XLSX_BUILDER_PKG.query2sheet(l_sql, p_column_headers => true, p_sheet => 1 );

XLSX_BUILDER_PKG.set_column_width(1, 12);  
XLSX_BUILDER_PKG.set_column_width(2, 40);
XLSX_BUILDER_PKG.set_column_width(3, 23);
XLSX_BUILDER_PKG.set_column_width(4, 32);
XLSX_BUILDER_PKG.set_column_width(5, 30);
XLSX_BUILDER_PKG.set_column_width(6, 10);
XLSX_BUILDER_PKG.set_column_width(7, 29);
XLSX_BUILDER_PKG.set_column_width(8, 30);
XLSX_BUILDER_PKG.set_column_width(9, 45);
XLSX_BUILDER_PKG.set_column_width(10, 17);
XLSX_BUILDER_PKG.set_column_width(11, 39);
XLSX_BUILDER_PKG.set_column_width(12, 30);
XLSX_BUILDER_PKG.set_column_width(13, 30);
XLSX_BUILDER_PKG.set_column_width(14, 30);
XLSX_BUILDER_PKG.set_column_width(15, 30);


  l_blob := XLSX_BUILDER_PKG.FINISH;  
     
  Insert into BARS.DWH_CBIREP_QUERIES_DATA  
              (CBIREP_QUERIES_ID, RESULT_FILE_NAME, LENGTH_FILE, fil)
  Values  (p_cbirep_queries_id, l_file_name, DBMS_LOB.GETLENGTH (l_blob), l_blob);

end; ';
    l_reports.stmt                := '';
    l_reports.FILE_NAME           := '''601p4_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat2,''DDMMYY.xlsx''),1,11)';
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
