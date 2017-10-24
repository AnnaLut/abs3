prompt ===================================== 
prompt == ������������ � ����� �� ��
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_reports       DWH_REPORTS%rowtype;    
   l_reportsr      DWH_REPORTS%rowtype;    
   l_isnew     smallint:=0;       

begin     
   l_reports.name := '������������ � ����� �� ��';
   l_reports.id := '674';

   begin                                                   
      select id into l_reportsr.id                      
      from DWH_REPORTS where id=l_reports.id;             
   exception when no_data_found then                       
      l_isnew:=1;                                          
   end;                                     
                                            

    ---------------------------    
    --  main dku_zvt zapros  --    
    ---------------------------    
                                  
    l_reports.name                 := '������������ � ����� �� ��';
    l_reports.TYPEID               := '2';
    l_reports.PARAMS               := '[{"Name":"p_sFdat1","Type":"Date","Value":"","Label":"����� ����"}]';
    l_reports.TEMPLATE_NAME        := '';
    l_reports.RESULT_FILE_NAME     := '''DeloidKD_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat1,''DDMMYY.rar''),1,10)';
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
        
  p_cck_deloit ( 1,to_date (p_sFdat1,''dd/mm/yyyy''));
           
  l_sql := ''SELECT sysdate  "�����_����",
       D.BRANCH "���",
       decode(D.VIDD,1,''''�����������'''',2,''''����. ���'''',3,''''�. ���. ����. ���'''',11,''''�� ����������� ������'''',12,''''��  ����.�����'''',13,''''��  �/� ����.�����'''',4,''''����������'''',14,''''���������� ���'''',''''�� ���������'''') "���_�����",
       case when d.vidd in (1,2,3) then (select substr(dd.prod,1,4)from cc_deal dd where dd.nd=d.nd)
            when d.vidd in (4,14)  then (select max(a.nbs) from accounts a, acc_over o where a.acc=o.acc and o.nd=d.nd) else null end "���_�������",
       case when d.vidd in (1,2,3) then (select substr(dd.prod,5,2)from cc_deal dd where dd.nd=d.nd)
            when d.vidd in (4,14) then  (select max(a.nbs) from accounts a, acc_over o where a.acc=o.acc and o.nd=d.nd) else null end "OB22",
       D.ND "��������_�����",
       D.CC_ID "�����_�����",
       D.RNK "�����_���_�볺���",
       D.NMK "�����_�볺���",
       D.OKPO "������", 
       D.KV "���_����_�����",
       D.SDATE "����_�����_�����",
       D.WDATE "����_�����_�����",
       D.IR "ĳ���_����_������",
       case when (select substr(dd.prod,1,1)from cc_deal dd where dd.nd=d.nd)=''''9'''' then 0 else D.SS end "������_��_�_���",
       D.SDI  "�������_�_���",
       D.SN  "�����_���_�_���",
       case when (select substr(dd.prod,1,1)from cc_deal dd where dd.nd=d.nd)=''''9'''' then D.SS else D.CR9 end "����������_�_���",
       D.DAT_SP "����_������_��",
       D.DAT_SPN "����_������_�����",
       D.FIN23 "Գ�_����_��_23",
       D.OBS23 "���_�����_��_23",
       D.KAT23 "���_�����_��_23",
       D.DAZS "����_����_��",
       t.*
   FROM TMP_DELOIT_PAWN t, tmp_deloit_cck d
   WHERE t.nd(+) = d.nd AND d.vidd IN (1, 2, 3, 4, 14)'';
   
  XLSX_BUILDER_PKG.query2sheet(l_sql); 
 -- XLSX_BUILDER_PKG.SET_ROW_HEIGHT(1, 26);
  XLSX_BUILDER_PKG.set_column_width(2, 25);
  XLSX_BUILDER_PKG.set_column_width(3, 25);
  XLSX_BUILDER_PKG.set_column_width(9, 55);
 -- XLSX_BUILDER_PKG.SET_AUTOFILTER(p_column_start => null, p_column_end => 25, P_ROW_START => 1, P_ROW_END => 1); 
  l_blob := XLSX_BUILDER_PKG.FINISH;  
    
    
    
    
Insert into BARS.DWH_CBIREP_QUERIES_DATA  (  CBIREP_QUERIES_ID, RESULT_FILE_NAME, LENGTH_FILE, fil)
 Values  (  p_cbirep_queries_id, l_file_name, DBMS_LOB.GETLENGTH (l_blob)   , l_blob);

    

end; ';
    l_reports.stmt                := '';
    l_reports.FILE_NAME           := '''DeloidKD_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat1,''DDMMYY.xlsx''),1,11)';
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
        execute immediate 
        '    Insert into BARS.DWH_REPORT_LINKS  (REPORT_ID, MODULE_ID)'||
        '         Values  (674, ''$RM_UCCK'')';
        exception when dup_val_on_index then 
            null;
end;
/

commit;    
    