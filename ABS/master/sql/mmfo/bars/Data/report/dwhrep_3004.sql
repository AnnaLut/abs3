prompt ===================================== 
prompt == Виписки по рахунках КД
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_reports       DWH_REPORTS%rowtype;    
   l_reportsr      DWH_REPORTS%rowtype;    
   l_isnew     smallint:=0;       

begin     
   l_reports.name := 'Виписки по рахунках КД';
   l_reports.id := '3004';

   begin                                                   
      select id into l_reportsr.id                      
      from DWH_REPORTS where id=l_reports.id;             
   exception when no_data_found then                       
      l_isnew:=1;                                          
   end;                                     
                                            

    ---------------------------    
    --  main dku_zvt zapros  --    
    ---------------------------    
                                  
    l_reports.name                 := 'Виписки по рахунках КД';
    l_reports.TYPEID               := '2';
    l_reports.PARAMS               := '[{"Name":"p_sFdat1","Type":"Date","Value":"","Label":"Дата з"},
 {"Name":"p_sFdat2","Type":"Date","Value":"","Label":"Дата по"},
 {"Name":"~p_nd","Type":"Decimal","Value":"0","Label":"Референс договору"},
 {"Name":"~p_nls","Type":"Text","Value":"%","Label":"Маска рахунка"},
 {"Name":"~p_kv","Type":"Text","Value":"0","Label":"Валюта","Control":{"Type":"select","Data":[{"Value":"0","Text":"Всі валюти"},{"Value":"980","Text":"Нац.валюта"},{"Value":"-980","Text":"Ін.валюта"}]}}
]';
    l_reports.TEMPLATE_NAME        := '';
    l_reports.RESULT_FILE_NAME     := '''VP''||case when ~p_kv = 980 then ''GRN'' when ~p_kv = ''-980'' then ''VAL'' else ''_'' end||''_''||~p_nd||''_''||substr(dwh_cbirep.frmt_date(p_sFdat1,''DMYY''),1,6)||''.rar''';
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



for c0 in (select a.rnk, a.nls, a.kv
             from accounts a, nd_acc n
            where a.acc=n.acc and n.nd = ~p_nd and a.nls like ~p_nls and case when ~p_kv = 0                     then 1
                                                               when ~p_kv = 980  and  a.kv = 980  then 1
                                                               when ~p_kv = -980 and  a.kv != 980 then 1
                                                                                                  else 0
                                                          end = 1 )
loop

p_lic_blob_nls (p_rnk   => c0.rnk,
                p_nls   => c0.nls,
                p_dat1  => to_date(p_sFdat1,''dd-mm-yyyy''),
                p_dat2  => to_date(p_sFdat2,''dd-mm-yyyy''),
                p_kv    => c0.kv,
                p_filemask => l_file,
                p_blob     => l_blob
                );


If DBMS_LOB.GETLENGTH (l_blob) > 476 then

    Insert into BARS.DWH_CBIREP_QUERIES_DATA  (  CBIREP_QUERIES_ID, RESULT_FILE_NAME, LENGTH_FILE, fil)
     Values  (  p_cbirep_queries_id, l_file, DBMS_LOB.GETLENGTH (l_blob)   , l_blob);

end if;

end loop;



end; ';
    l_reports.stmt                := '';
    l_reports.FILE_NAME           := ':FILEMASK||''_''||SUBSTR(dwh_cbirep.frmt_date(p_sFdat1,''DM.0YY''),1,5)';
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
        '         Values  (3004, ''$RM_UCCK'')';
        exception when dup_val_on_index then 
            null;
end;
/

commit;    
    