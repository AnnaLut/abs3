prompt ===================================== 
prompt == Перелік договорів в АРМ ВК
prompt ===================================== 

set serveroutput on
set feed off       
declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_zpr       zapros%rowtype;    
   l_zprr      zapros%rowtype;    
   l_rep       reports%rowtype;   
   l_repfolder number;            
   l_isnew     smallint:=0;       
   l_isnewr    smallint:=0;       
   l_message   varchar2(1000);    

begin     
   l_zpr.name := 'Перелік договорів в АРМ ВК';
   l_zpr.pkey := '\BRS\SBR\REP\3060';

   l_message  := 'Ключ запроса: '||l_zpr.pkey||'  '||nlchr;

   begin                                                   
      select kodz, kodr into l_zpr.kodz, l_zpr.kodr        
      from zapros where pkey=l_zpr.pkey;                   
   exception when no_data_found then                       
      l_isnew:=1;                                          
      select s_zapros.nextval into l_zpr.kodz from dual;   
      if (0>0) then                  
         select s_zapros.nextval into l_zpr.kodr from dual;
         l_zprr.kodz:=l_zpr.kodr;           
      end if;                               
   end;                                     
                                            

    ------------------------    
    --  main query        --    
    ------------------------    
                                
    l_zpr.id           := 1;
    l_zpr.name         := 'Перелік договорів в АРМ ВК';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''''Дата з,:sFdat2=''Дата по'',:Param1=''МФО (%-Всі)'',:Param2=''Тип (%-Всі)'',:Param3=''Валюта (%-Всі)'',:Param4=''Статус (%-Всі)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_3060.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param1=''Поточне'',:Param2=''%'',:Param3=''%'',:Param4=''%''';
    l_zpr.bind_sql     := ':Param1=''BRANCH|BRANCH|NAME|WHERE length(branch)<=8 and  length(branch) >1 ORDER BY branch'',:Param2=''CIM_CONTRACT_TYPES|CONTR_TYPE_ID|CONTR_TYPE_NAME'',:Param3=''TABVAL|KV|NAME'',:Param4=''CIM_CONTRACT_STATUSES|STATUS_ID|STATUS_NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'WITH zap'||nlchr||
                           '     AS (SELECT t.*,'||nlchr||
                           '                :Param1 Param1,'||nlchr||
                           '                :sFdat1 sFdat1,'||nlchr||
                           '                :sFdat2 sFdat2,'||nlchr||
                           '                DECODE ( :Param2, ''%'', NULL, :Param2) Param2,'||nlchr||
                           '                :Param3 Param3,'||nlchr||
                           '                DECODE ( :Param4, ''%'', NULL, :Param4) Param4'||nlchr||
                           '           FROM TABLE (bars.cim_reports.get_contracts_list ('||nlchr||
                           '                          p_mfo          => :Param1,'||nlchr||
                           '                          p_date_from    => :sFdat1,'||nlchr||
                           '                          p_date_to      => :sFdat2,'||nlchr||
                           '                          p_contr_type   => :Param2,'||nlchr||
                           '                          p_kv           => :Param3,'||nlchr||
                           '                          p_status       => :Param4)) t)'||nlchr||
                           'SELECT z.*,'||nlchr||
                           '       NVL (T.CONTR_TYPE_NAME, ''Всі'') CONTR_TYPE_NAME,'||nlchr||
                           '       NVL (S.STATUS_NAME, ''Всі'') STATUS_NAME,'||nlchr||
                           '       DECODE (Param3, ''%'', ''Всі'', Param3) Param3,'||nlchr||
                           '       DECODE (Param1, ''%'', ''Всі'', Param1) Param1'||nlchr||
                           '  FROM zap z'||nlchr||
                           '       LEFT JOIN cim_contract_types t'||nlchr||
                           '          ON (TO_NUMBER (z.param2) = t.CONTR_TYPE_ID)'||nlchr||
                           '       LEFT JOIN cim_contract_statuses s'||nlchr||
                           '          ON (TO_NUMBER (z.param4) = S.STATUS_ID)';
    l_zpr.xsl_data     := '';
    l_zpr.xsd_data     := '';

    if l_isnew = 1 then           
       insert into zapros values l_zpr;  
       l_message:=l_message||'Добавлен новый кат.запрос №'||l_zpr.kodz||'.'; 
    else                           
       update zapros set name         = l_zpr.name,        
                         namef        = l_zpr.namef,       
                         bindvars     = l_zpr.bindvars,    
                         create_stmt  = l_zpr.create_stmt, 
                         rpt_template = l_zpr.rpt_template,
                         form_proc    = l_zpr.form_proc,   
                         default_vars = l_zpr.default_vars,
                         bind_sql     = l_zpr.bind_sql,    
                         xml_encoding = l_zpr.xml_encoding,
                         txt          = l_zpr.txt,         
                         xsl_data     = l_zpr.xsl_data,    
                         xsd_data     = l_zpr.xsd_data     
       where pkey=l_zpr.pkey;                              
       l_message:=l_message||'Кат.запрос c таким ключем уже существует под №'||l_zpr.kodz||', его параметры изменены.'; 
                                                           
    end if;                                                

    ------------------------    
    --  report            --    
    ------------------------    
                                

    l_rep.name        :='Empty';
    l_rep.description :='Перелік договорів в АРМ ВК';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 70; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 3060;


    if l_isnew = 1 then                     
       begin                                
          insert into reports values l_rep;        
          l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
       exception when dup_val_on_index then  
           bars_error.raise_error('REP',14, to_char(l_rep.id));
       end;                                    
    else                                            
       begin                                        
          insert into reports values l_rep;         
          l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
       exception when dup_val_on_index then         
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' изменен.';
          update reports set                
             name        = l_rep.name,       
             description = l_rep.description,
             form        = l_rep.form,       
             param       = l_rep.param,      
             ndat        = l_rep.ndat,       
             mask        = l_rep.mask,       
             usearc      = l_rep.usearc,     
             idf         = l_rep.idf         
          where id=l_rep.id;                 
       end;                                  
    end if;  
	 begin
    Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('$RM_WCIM', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в "АРМ Валютний контроль"';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в "АРМ Валютний контроль"';
    end;	
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     
