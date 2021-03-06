prompt ===================================== 
prompt == �601 ����.1 ���������� ���� �������� ������� ����� ��������-��
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_reports       DWH_REPORTS%rowtype;    
   l_reportsr      DWH_REPORTS%rowtype;    
   l_isnew     smallint:=0;       

begin     
   l_reports.name := '�601 ����.1 ���������� ���� �������� ������� ����� ��������-��';
   l_reports.id := '6005';

   begin                                                   
      select id into l_reportsr.id                      
      from DWH_REPORTS where id=l_reports.id;             
   exception when no_data_found then                       
      l_isnew:=1;                                          
   end;                                     
                                            

    ---------------------------    
    --  main dku_zvt zapros  --    
    ---------------------------    
                                  
    l_reports.name                 := '�601 ����.1 ���������� ���� �������� ������� ����� ��������-��';
    l_reports.TYPEID               := '2';
    l_reports.PARAMS               := '[{"Name":"p_sFdat1","Type":"Date","Value":"","Label":"�������� ����������� ��� � ����� �"},
 {"Name":"p_sFdat2","Type":"Date","Value":"","Label":"��"}]';
    l_reports.TEMPLATE_NAME        := '';
    l_reports.RESULT_FILE_NAME     := '''601p1_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat2,''DDMMYY.rar''),1,10)';
    l_reports.SQLPREPARE          := 'select'||nlchr||
                           '       ROWNUM  N,'||nlchr||
                           '       c.lastname || '' '' || c.firstname || '' '' || c.middlename as �������_���_��_�������,'||nlchr||
                           '       c.birthday as ����_����������,'||nlchr||
                           '       d.seriya||'' ''||d.nomerd as ����_��_�����_��������,'||nlchr||
                           '       d.dtd as ����_������_��������,'||nlchr||
                           '       null as �����,'||nlchr||
                           '       c.inn ����������������_���_��������,'||nlchr||
                           '       f.codregion ���_������_���������,'||nlchr||
                           '       trim(f.area||'' ''||f.zip||'' ''||f.city||'' ''||f.streetAddress||'' ''||f.houseNo||'' ''||f.adrKorp||'' ''||f.flatno) as ������_���������,'||nlchr||
                           '       c.isrez �������������,'||nlchr||
                           '       c.countrycodnerez �����_�����_��_�����������,'||nlchr||
                           '       o.namew ̳���_������_������������,'||nlchr||
                           '       o.codedrpou ̳���_������_������,'||nlchr||
                           '       p.real6month �����_������������,'||nlchr||
                           '       p.noreal6month �����_��������������,'||nlchr||
                           '       fam.status_f ѳ������_����,'||nlchr||
                           '       fam.members ʳ������_���_��_���������,'||nlchr||
                           '       c.k060 ���_����_�����_�_������_�����,'||nlchr||
                           '       c.iskr ������_�����_�����_���_��_��� '||nlchr||
                           'from '||nlchr||
                           '(select * from  nbu_gateway.CORE_CREDIT cr where REQUEST_ID in ('||nlchr||
                           '       (select id from'||nlchr||
                           '       (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=15'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) cr,'||nlchr||
                           '(select * from  nbu_gateway.core_person_fo c where REQUEST_ID in('||nlchr||
                           '       (select id from'||nlchr||
                           '       (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=1'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) c,'||nlchr||
                           '(select * from  nbu_gateway.core_document_fo d  where REQUEST_ID in('||nlchr||
                           '       (select id from'||nlchr||
                           '       (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=2'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) d,'||nlchr||
                           '(select * from  nbu_gateway.core_address_fo f where REQUEST_ID in('||nlchr||
                           '       (select id from'||nlchr||
                           '       (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=3'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) f,'||nlchr||
                           '(select * from  nbu_gateway.core_profit_fo p where REQUEST_ID in('||nlchr||
                           '       (select id from'||nlchr||
                           '       (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=4'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) p,'||nlchr||
                           '(select * from nbu_gateway.core_family_fo fam where REQUEST_ID in('||nlchr||
                           '       (select id from'||nlchr||
                           '       (select dat.KF, max(ID) id from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=5'||nlchr||
                           '       and (RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/''))=DECODE ((sys_context(''bars_context'',''user_branch'')),''/'',(RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')),(sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= to_date(p_sFdat1,''dd.mm.yyyy'')'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= to_date(p_sFdat2,''dd.mm.yyyy'')'||nlchr||
                           '       group by dat.KF)))) fam,'||nlchr||
                           'branch b,'||nlchr||
                           'nbu_gateway.core_organization_fo o,'||nlchr||
                           '(select * from  nbu_gateway.NBU_SESSION n where trunc(CAST(n.CREATED_AT AS DATE)) >= :sFdat1'||nlchr||
                           'and trunc(CAST(n.CREATED_AT AS DATE)) <= :sFdat2) n'||nlchr||
                           'where'||nlchr||
                           'b.branch = sys_context(''bars_context'',''user_branch'')'||nlchr||
                           'and c.rnk(+) = cr.rnk'||nlchr||
                           'and f.rnk(+) = cr.rnk '||nlchr||
                           'and o.rnk(+) = cr.rnk'||nlchr||
                           'and p.rnk(+) = cr.rnk'||nlchr||
                           'and fam.rnk(+) = cr.rnk'||nlchr||
                           'and d.rnk(+) = cr.rnk'||nlchr||
                           'and n.OBJECT_ID=cr.LOAN_OBJECT_ID'||nlchr||
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
XLSX_BUILDER_PKG.set_column_width(16, 14);
XLSX_BUILDER_PKG.set_column_width(17, 37);
XLSX_BUILDER_PKG.set_column_width(18, 30);
XLSX_BUILDER_PKG.set_column_width(19, 41);
XLSX_BUILDER_PKG.set_column_width(20, 41); 

  l_blob := XLSX_BUILDER_PKG.FINISH;  
    
    
    
  Insert into BARS.DWH_CBIREP_QUERIES_DATA  
              (CBIREP_QUERIES_ID, RESULT_FILE_NAME, LENGTH_FILE, fil)
  Values  (p_cbirep_queries_id, l_file_name, DBMS_LOB.GETLENGTH (l_blob), l_blob);

end; ';
    l_reports.stmt                := '';
    l_reports.FILE_NAME           := '''601p1_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat2,''DDMMYY.xlsx''),1,11)';
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
