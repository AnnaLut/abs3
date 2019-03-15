prompt ===================================== 
prompt == DBF-Динамiка змiни залишкiв(вихiдних)по рахунках клiєнтiв
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_reports       DWH_REPORTS%rowtype;    
   l_reportsr      DWH_REPORTS%rowtype;    
   l_isnew     smallint:=0;       

begin     
   l_reports.name := 'DBF-Динамiка змiни залишкiв(вихiдних)по рахунках клiєнтiв';
   l_reports.id := '5053';

   begin                                                   
      select id into l_reportsr.id                      
      from DWH_REPORTS where id=l_reports.id;             
   exception when no_data_found then                       
      l_isnew:=1;                                          
   end;                                     
                                            

    ---------------------------    
    --  main dku_zvt zapros  --    
    ---------------------------    
                                  
    l_reports.name                 := 'DBF-Динамiка змiни залишкiв(вихiдних)по рахунках клiєнтiв';
    l_reports.TYPEID               := '2';
    l_reports.PARAMS               := '[{"Name":"p_sFdat1","Type":"Date","Value":"","Label":"Звітна дата"},
 {"Name":"p_mfo","Type":"Text","Value":"%","Label":"МФО","Control":{"Type":"book" ,"Data":"v_mfo_ru"}}]';
    l_reports.TEMPLATE_NAME        := '';
    l_reports.RESULT_FILE_NAME     := '''dyn_ch_zal_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat1,''DDMMYY.rar''),1,10)';
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
  
    l_sql := ''
    select to_date(''''''||p_sFdat1||'''''',''''dd/mm/yyyy'''') "Звітна дата",
       to_number(a.kf) "МФО",
       substr(c.okpo, 1, 10) "ЗКПО",
       substr(c.nmk, 1, 50) "Назва клієнта",
       to_number(a.nbs) "Б/Р",
       substr(a.nms, 1, 50) "Найменування рахунку",
       a.kv "Валюта",
       a.ob22 OB22,
       r.r011 R011,
       r.r013 R013,
       r.s240 S240,
       a.nls "Рахунок",
       case when fost(a.acc, to_date(''''''||p_sFdat1||'''''',''''dd/mm/yyyy'''')) < 0 then 1
            else 2
       end "Д/К",
       fost(a.acc, to_date(''''''||p_sFdat1||'''''',''''dd/mm/yyyy'''')) / 100 "Залишок,грн."
  from customer c, scli_r20 b, scli_zkp k, accounts a, specparam r
 where c.kf=decode(''''''||p_mfo||'''''',''''%'''',c.kf,''''''||p_mfo||'''''') 
   and a.rnk = c.rnk
   and a.kf = c.kf
   and (dazs is null or dazs > to_date(''''''||p_sFdat1||'''''',''''dd/mm/yyyy''''))
   and a.nbs = b.r020
   and c.okpo = k.zkpo
   and a.acc = r.acc(+)
 order by r.r013, 2
    '';
 
  XLSX_BUILDER_PKG.clear_workbook;
  XLSX_BUILDER_PKG.new_sheet(''Звіт'');    
-- Приклади в пакеті FIN_REP
  XLSX_BUILDER_PKG.set_row(1,
                          p_fontId => XLSX_BUILDER_PKG.get_font( ''Times New Roman'', 2,11,1,false, false ,true),
                          p_borderId => XLSX_BUILDER_PKG.get_border( null, ''thin'', null, null ),
                          p_fillId => XLSX_BUILDER_PKG.get_fill( ''solid'', p_fgRGB => ''C0C0C0'' )
                          );
  XLSX_BUILDER_PKG.set_column(14,XLSX_BUILDER_PKG.get_NumFmt(''#,##0.00''));
  XLSX_BUILDER_PKG.query2sheet(l_sql, p_column_headers => true, p_sheet => 1 );

--  XLSX_BUILDER_PKG.SET_ROW_HEIGHT(1, 26);
  XLSX_BUILDER_PKG.set_column_width(1, 12);  
  XLSX_BUILDER_PKG.set_column_width(3, 12);  
  XLSX_BUILDER_PKG.set_column_width(4, 35);  
  XLSX_BUILDER_PKG.set_column_width(6, 35);  
  XLSX_BUILDER_PKG.set_column_width(12, 16);  
  XLSX_BUILDER_PKG.set_column_width(14, 20);  
--  XLSX_BUILDER_PKG.set_column(14,XLSX_BUILDER_PKG.get_NumFmt(''#,##0.00''));
--  XLSX_BUILDER_PKG.SET_AUTOFILTER(p_column_start => null, p_column_end => 25, P_ROW_START => 1, P_ROW_END => 1); 
--  XLSX_BUILDER_PKG.cell( 2, 1, ''МФО'', 
--                      p_borderId => XLSX_BUILDER_PKG.get_border( ''thin'', ''thin'', ''thin'', ''thin'' ),
--                      p_alignment =>XLSX_BUILDER_PKG.GET_ALIGNMENT(''center'', ''center'', true),
--                      p_fillId => XLSX_BUILDER_PKG.get_fill( ''solid'', p_fgRGB => ''C0C0C0'' ) );

  l_blob := XLSX_BUILDER_PKG.FINISH;  
    
    
    
Insert into BARS.DWH_CBIREP_QUERIES_DATA  (  CBIREP_QUERIES_ID, RESULT_FILE_NAME, LENGTH_FILE, fil)
 Values  (  p_cbirep_queries_id, l_file_name, DBMS_LOB.GETLENGTH (l_blob)   , l_blob);

    

end; ';
    l_reports.stmt                := '';
    l_reports.FILE_NAME           := '''dyn_ch_zal_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat1,''DDMMYY.xlsx''),1,11)';
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
       insert into DWH_REPORT_LINKS values (5053,'$RM_CRPC');
       exception
         when others then
           if sqlcode = -00001 
              then dbms_output.put_line('Record exists. Sql_code='||sqlcode);
              else raise;
           end if;
end;
/
commit;                                     

declare 
    l_codeoper number;
    l_codearm  varchar2(10) := '$RM_CRPC';
    l_name     operlist.name%type := 'Формування звітів';
    l_funcname operlist.funcname%type := '/barsroot/dwh/report/index?moduleId=$RM_CRPC';

begin 
    -- Создать обновить функцию
    l_codeoper := operlist_adm.add_new_func (p_name  =>  l_name, p_funcname  =>  l_funcname, p_frontend  =>  1 ); 
    -- добавить функциюв Арм
    umu.add_func2arm(l_codeoper, l_codearm, 1 );     
    commit;
end;
/
