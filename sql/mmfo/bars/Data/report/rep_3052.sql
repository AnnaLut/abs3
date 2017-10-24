prompt ===================================== 
prompt == Виписки про рух коштів на рахунок Казначейства
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_reports       DWH_REPORTS%rowtype;    
   l_reportsr      DWH_REPORTS%rowtype;    
   l_isnew     smallint:=0;       

begin     
   l_reports.name := 'Виписки про рух коштів на рахунок Казначейства';
   l_reports.id := '3052';

   begin                                                   
      select id into l_reportsr.id                      
      from DWH_REPORTS where id=l_reports.id;             
   exception when no_data_found then                       
      l_isnew:=1;                                          
   end;                                     
                                            

    ---------------------------    
    --  main dku_zvt zapros  --    
    ---------------------------    
                                  
    l_reports.name                 := 'Виписки про рух коштів на рахунок Казначейства';
    l_reports.TYPEID               := '2';
    l_reports.PARAMS               := '[{"Name":"p_sFdat1","Type":"Date","Value":"","Label":"Дата з"},
 {"Name":"p_sFdat2","Type":"Date","Value":"","Label":"Дата по"}
]';
    l_reports.TEMPLATE_NAME        := '';
    l_reports.RESULT_FILE_NAME     := '''VP_DKSU''||''_''||substr(dwh_cbirep.frmt_date(p_sFdat1,''DMYY''),1,6)||''.rar''';
    l_reports.SQLPREPARE          := 'SELECT  to_char(f_ourmfo)                                     as MFO'||nlchr||
                           '       ,''lic_''||nls||lpad(kv,3,''0'')||''.DBF''                   as FN'||nlchr||
                           '       ,datd                                                  as VDAT'||nlchr||
                           '       , kv                                                   as KV'||nlchr||
                           '       ,nls                                                   as NLS'||nlchr||
                           '       ,(ostf*100)                                            as OST_VX'||nlchr||
                           '       ,((ostf- sum(doss*-1) over (partition by nls,kv,fdat order by nls,kv,fdat) + sum(koss) over (partition by nls,kv,fdat order by nls,kv,fdat))*100) as OST_IS'||nlchr||
                           '       ,sum(doss*-1) over (partition by nls,kv,fdat order by nls,kv,fdat)*100                                              as SDE'||nlchr||
                           '       ,sum(koss) over (partition by nls,kv,fdat order by nls,kv,fdat)*100                                              as SKR'||nlchr||
                           '       ,sum(dossq*-1) over (partition by nls,kv,fdat order by nls,kv,fdat)*100                                             as SDEQ'||nlchr||
                           '       ,sum(kossq) over (partition by nls,kv,fdat order by nls,kv,fdat)*100                                             as SKRQ'||nlchr||
                           '       ,1                                                     as ID'||nlchr||
                           '       ,CASE WHEN dk = 0 THEN  nls ELSE nls2 END              as NLSK'||nlchr||
                           '       ,substr(CASE WHEN dk = 0 THEN  nmk ELSE nmk2 END,1,50) as NAMK'||nlchr||
                           '       ,nd                                                  as ND'||nlchr||
                           '       ,(case when dk = 0 then -s else 0 end)*100              as SD'||nlchr||
                           '       ,(case when dk = 1 then s else 0 end)*100              as SK'||nlchr||
                           '       ,(case when dk = 0 then -sq else 0 end)*100             as SDQ'||nlchr||
                           '       ,(case when dk = 1 then sq else 0 end)*100             as SKQ'||nlchr||
                           '       ,substr(nazn,1,250)                                    as NAZN '||nlchr||
                           '       FROM    v_rptlic2'||nlchr||
                           'WHERE   NVL(ref, 0) = DECODE(''0'',''0'',ref,NVL(ref, 0))'||nlchr||
                           '        AND bis = 0 '||nlchr||
                           '        AND srt < 3'||nlchr||
                           '        and nls = ~NLS and kv = ~KV';
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

    rptlic_nls_3052(to_date(p_sFdat1,''dd-mm-yyyy''), to_date(p_sFdat2,''dd-mm-yyyy''));

  for c0 in (SELECT DISTINCT  nls    , kv                          
               FROM    v_rptlic2
        WHERE   NVL(ref, 0) = DECODE(''0'',''0'',ref,NVL(ref, 0))
                AND bis = 0 
                AND srt < 3 )
loop

           l_sqlprepare        := replace (replace (   dwh_cbirep.bind_variables(l_reports.sqlprepare,l_cbirep_q.KEY_PARAMS),
                                                   ''~NLS'',''''''''||c0.nls||'''''''' ),''~KV'',''''||c0.kv||'''' 
                                           );
                                       
           l_file_name          := replace (replace (   ''select ''||dwh_cbirep.bind_variables(l_reports.file_name,l_cbirep_q.KEY_PARAMS)||'' from dual'',
                                                   ''~NLS'',''''''''||c0.nls||'''''''' ),''~KV'',''''''''||c0.kv||'''''''' 
                                           ); 
                                      
            EXECUTE IMMEDIATE   l_file_name into l_file_name;
      
           
            dwh_cbirep.exec_report_dbf   ( p_cbirep_queries_id, 
                                           l_sqlprepare      ,
                                           l_reports.stmt            , 
                                           l_reports.encoding        ,
                                           l_file_name       ); 

end loop;



end;                          ';
    l_reports.stmt                := 'MFO     CHAR(6),'||nlchr||
                           'FN      CHAR(20),'||nlchr||
                           'VDAT    DATE,'||nlchr||
                           'KV      NUMBER(3),'||nlchr||
                           'NLS     CHAR(15),'||nlchr||
                           'OST_VX  NUMBER(19),'||nlchr||
                           'OST_IS  NUMBER(19),'||nlchr||
                           'SDE     NUMBER(19),'||nlchr||
                           'SKR     NUMBER(19),'||nlchr||
                           'SDEQ    NUMBER(19),'||nlchr||
                           'SKRQ    NUMBER(19),'||nlchr||
                           'ID      NUMBER(19),'||nlchr||
                           'NLSK    CHAR(15),'||nlchr||
                           'NAMK    CHAR(38),'||nlchr||
                           'ND      CHAR(10),'||nlchr||
                           'SD      NUMBER(17,2),'||nlchr||
                           'SK      NUMBER(17,2),'||nlchr||
                           'SDQ     NUMBER(17,2),'||nlchr||
                           'SKQ     NUMBER(17,2),'||nlchr||
                           'NAZN    CHAR(160)';
    l_reports.FILE_NAME           := '''LIC_''||~NLS||''_''||~KV||''.DBF''';
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
    '  Values (3052, ''$RM_DRU1'')';
exception when dup_val_on_index then 
  null;
end;
/

begin 
  execute immediate 
    ' Insert into BARS.DWH_REPORT_LINKS (REPORT_ID, MODULE_ID)'||
    '  Values (3052, ''$RM_WDOC'')';
exception when dup_val_on_index then 
  null;
end;
/

COMMIT;

 declare
    l_application_code varchar2(10 char) := '$RM_WDOC';
    l_application_name varchar2(300 char) := 'АРМ Операціоніста (Фронт)';
    l_application_type_id integer := user_menu_utl.APPLICATION_TYPE_WEB;
    l_function_ids number_list := number_list();
    l_function_codeoper     OPERLIST.CODEOPER%type;
    l_function_deps         OPERLIST.CODEOPER%type;
    l_application_id integer;
    l_role_resource_type_id integer := resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE);
    l_arm_resource_type_id  integer := resource_utl.get_resource_type_id(user_menu_utl.get_arm_resource_type_code(l_application_type_id));
    l_func_resource_type_id integer := resource_utl.get_resource_type_id(user_menu_utl.get_func_resource_type_code(l_application_type_id));
    l integer := 0;
    d integer := 0;
begin
     DBMS_OUTPUT.PUT_LINE(' $RM_WDOC створюємо (або оновлюємо) АРМ АРМ Операціоніста (Фронт) ');
     user_menu_utl.cor_arm(  P_ARM_CODE              => l_application_code, 
                             P_ARM_NAME              => l_application_name, 
                             P_APPLICATION_TYPE_ID   => l_application_type_id);

        -- отримуємо ідентифікатор створеного АРМу
     l_application_id := user_menu_utl.get_arm_id(l_application_code); 
	 
    DBMS_OUTPUT.PUT_LINE( chr(13)||chr(10)||' ********** Створюємо функцію Формування звітів ********** ');
          --  Створюємо функцію Формування звітів
      l := l +1;
      l_function_ids.extend(l);      
      l_function_ids(l)   :=   abs_utils.add_func(
                                                  p_name     => 'Формування звітів',
                                                  p_funcname => '/barsroot/dwh/report/index?moduleId=$RM_WDOC',
                                                  p_rolename => '' ,    
                                                  p_frontend => l_application_type_id
                                                  );
     

         

   DBMS_OUTPUT.PUT_LINE(chr(13)||chr(10)||'  Прикріпляємо ресурси функцій до даного АРМу ($RM_WDOC) - АРМ Операціоніста (Фронт)  ');
    l := l_function_ids.first;
    while (l is not null and l_function_ids(l)  is not null) loop
        resource_utl.set_resource_access_mode(l_arm_resource_type_id, l_application_id, l_func_resource_type_id, l_function_ids(l), 1);
        l := l_function_ids.next(l);
    end loop;
     
     
    DBMS_OUTPUT.PUT_LINE(' Bидані функції можливо потребують підтвердження - автоматично підтверджуємо їх ');
    for i in (select a.id
              from   adm_resource_activity a
              where  a.grantee_type_id = l_arm_resource_type_id and
                     a.resource_type_id = l_func_resource_type_id and
                     a.grantee_id = l_application_id and
                     a.resource_id in (select column_value from table(l_function_ids))  and
                     a.access_mode_id = 1 and
                     a.resolution_time is null) loop
        resource_utl.approve_resource_access(i.id, 'Автоматичне підтвердження прав на функції для АРМу');
    end loop;
     DBMS_OUTPUT.PUT_LINE(' Commit;  ');
   commit;
end;
/



	