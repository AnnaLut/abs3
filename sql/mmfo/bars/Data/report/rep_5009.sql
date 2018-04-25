prompt ===================================== 
prompt == Звіт для фін монітор опер по платіжн карткам
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_reports       DWH_REPORTS%rowtype;    
   l_reportsr      DWH_REPORTS%rowtype;    
   l_isnew     smallint:=0;       

begin     
   l_reports.name := 'Звіт для фін монітор опер по платіжн карткам';
   l_reports.id := '5009';

   begin                                                   
      select id into l_reportsr.id                      
      from DWH_REPORTS where id=l_reports.id;             
   exception when no_data_found then                       
      l_isnew:=1;                                          
   end;                                     
                                            

    ---------------------------    
    --  main dku_zvt zapros  --    
    ---------------------------    
                                  
    l_reports.name                 := 'Звіт для фін монітор опер по платіжн карткам';
    l_reports.TYPEID               := '2';
    l_reports.PARAMS               := '[{"Name":"p_sFdat1","Type":"Date","Value":"","Label":"Дата з"},
 {"Name":"p_sFdat2","Type":"Date","Value":"","Label":"Дата по"},
 {"Name":"~p_nls","Type":"Text","Value":"%","Label":"Маска рахунка"}
]';
    l_reports.TEMPLATE_NAME        := '';
    l_reports.RESULT_FILE_NAME     := '''VP''||''_''||substr(dwh_cbirep.frmt_date(p_sFdat1,''DMYY''),1,6)||''.rar''';
    l_reports.SQLPREPARE          := '';
    l_reports.DESCRIPTION         := '';
    l_reports.FORM_PROC           := 'declare
l_cbirep_q DWH_CBIREP_QUERIES%rowtype;
l_reports  DWH_REPORTS%rowtype;
p_cbirep_queries_id number := #P_ID#;
l_file_name varchar2(254);
l_sqlprepare varchar2(32000);
l_file varchar2(50);
l_blob blob;
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



for c0 in (select  a.nls, a.kv
             from v_gl a 
            where  a.nls like ~p_nls and a.nbs in (''2625'',''2605'') 
			  and daos <= to_date(p_sFdat2,''dd-mm-yyyy'') 
              and nvl(dazs, to_date(p_sFdat2,''dd-mm-yyyy'')) between to_date(p_sFdat1,''dd-mm-yyyy'') and to_date(p_sFdat2,''dd-mm-yyyy'')
			  and exists (select 1 from saldoa where acc = a.acc and fdat between to_date(p_sFdat1,''dd-mm-yyyy'')  and to_date(p_sFdat2,''dd-mm-yyyy'') and (dos+kos) != 0 )
			  )
loop

 l_blob := f_rep_1009(to_date(p_sFdat1,''dd-mm-yyyy''), to_date(p_sFdat2,''dd-mm-yyyy'') , c0.nls, c0.kv);
 l_file := c0.nls||''_''||c0.kv||''.csv'';

If DBMS_LOB.GETLENGTH (l_blob) > 0 then

    Insert into BARS.DWH_CBIREP_QUERIES_DATA  (  CBIREP_QUERIES_ID, RESULT_FILE_NAME, LENGTH_FILE, fil)
     Values  (  p_cbirep_queries_id, l_file, DBMS_LOB.GETLENGTH (l_blob)   , l_blob);

end if;

end loop;



end; ';
    l_reports.stmt                := '';
    l_reports.FILE_NAME           := '~p_nls||''_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat1,''DM.0YY''),1,5)';
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
    ' Insert into BARS.DWH_REPORT_LINKS (REPORT_ID, MODULE_ID)'||
    '  Values (5009, ''$RM_DRU1'')';
exception when dup_val_on_index then 
  null;
end;
/

COMMIT;