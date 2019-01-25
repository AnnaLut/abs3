

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_6008.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Ф601 Частина 4 Інформація про боржника  - ЮО
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
   l_zpr.name := 'Ф601 Частина 4 Інформація про боржника  - ЮО';
   l_zpr.pkey := '\BRS\SBM\REP\6008';

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
    l_zpr.name         := 'Ф601 Частина 4 Інформація про боржника  - ЮО';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''Останній сформований звіт в період з'',:sFdat2=''По''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep6008.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select '||nlchr||
                           'pu.rnk rnk,'||nlchr||
                           'pu.NAMEUR NAMEUR,'||nlchr||
                           'pu.CODEDRPOU CODEDRPOU,'||nlchr||
                           'pu.ISREZ ISREZ,'||nlchr||
                           'pu.COUNTRYCODNEREZ COUNTRYCODNEREZ,'||nlchr||
                           'pu.REGISTRYDAY || '' '' || pu.NUMBERREGISTRY as REGISTR,'||nlchr||
                           'pu.K110 K110,'||nlchr||
                           'pu.EC_YEAR EC_YEAR,'||nlchr||
                           'pu.ISPARTNER ISPARTNER,'||nlchr||
                           'pu.ISCONTROLLER ISCONTROLLER,'||nlchr||
                           'uo.SALES uSALES,'||nlchr||
                           'uo.EBIT uEBIT,'||nlchr||
                           'uo.EBITDA uEBITDA,'||nlchr||
                           'uo.TOTALDEBT uTOTALDEBT,'||nlchr||
                           'gu.WHOIS guWHOIS,'||nlchr||
                           'gu.NAMEURGR guNAMEURGR,'||nlchr||
                           'gu.CODEDRPOUGR guCODEDRPOUGR,'||nlchr||
                           'pru.NAMEURPR pruNAMEURPR,'||nlchr||
                           'pru.CODEDRPOUPR pruCODEDRPOUPR, '||nlchr||
                           'uos.SALESGR uosSALES,'||nlchr||
                           'uos.EBITGR uosEBIT,'||nlchr||
                           'uos.EBITDAGR uosEBITDA,'||nlchr||
                           'uos.TOTALDEBTGR uosTOTALDEBT,'||nlchr||
                           'uos.CLASSGR uosCLASSGR,'||nlchr||
                           'FINU.SALES FINUSALES,'||nlchr||
                           'FINU.EBIT FINUEBIT,'||nlchr||
                           'FINU.EBITDA FINUEBITDA,'||nlchr||
                           'FINU.TOTALDEBT FINUTOTALDEBT,'||nlchr||
                           'pu.ISAUDIT puISAUDIT,'||nlchr||
                           'pu.K060 puK060,'||nlchr||
                           'pu.ISKR ISKR,'||nlchr||
                           'f_dat_lit(:sFdat1) STR_DAT1,'||nlchr||
                           'f_dat_lit(:sFdat2) STR_DAT2,'||nlchr||
                           'sys_context(''bars_context'',''user_branch'') branch,'||nlchr||
                           'b.name branchname'||nlchr||
                           'from'||nlchr||
                           'branch b,'||nlchr||
                           '(select * from nbu_gateway.CORE_PERSON_UO pu where pu.REQUEST_ID in ('||nlchr||
                           '  (select max(ID) from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=6'||nlchr||
                           '       and dat.KF=(trim( both ''/'' from sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >=:sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <=:sFdat2))) pu,'||nlchr||
                           '(select * from nbu_gateway.CORE_PARTNERS_UO pru where pru.REQUEST_ID in ('||nlchr||
                           '  (select max(ID) from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=10'||nlchr||
                           '       and dat.KF=(trim( both ''/'' from sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >=:sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <=:sFdat2))) pru,'||nlchr||
                           '(select * from nbu_gateway.CORE_FINPERFORMANCEPR_UO FINU where FINU.REQUEST_ID in ('||nlchr||
                           '  (select max(ID) from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=11'||nlchr||
                           '       and dat.KF=(trim( both ''/'' from sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2))) FINU,'||nlchr||
                           '(select * from nbu_gateway.core_finperformance_uo uo where uo.REQUEST_ID in ('||nlchr||
                           '  (select max(ID) from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=7'||nlchr||
                           '       and dat.KF=(trim( both ''/'' from sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2))) uo,'||nlchr||
                           '(select * from nbu_gateway.CORE_FINPERFORMANCEGR_UO uos where uos.REQUEST_ID in ('||nlchr||
                           '  (select max(ID) from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=9'||nlchr||
                           '      and dat.KF=(trim( both ''/'' from sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2))) uos, '||nlchr||
                           '(select * from nbu_gateway.CORE_GROUPUR_UO gu where gu.REQUEST_ID in ('||nlchr||
                           '  (select max(ID) from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=8'||nlchr||
                           '       and dat.KF=(trim( both ''/'' from sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2))) gu'||nlchr||
                           'where'||nlchr||
                           'b.branch = sys_context(''bars_context'',''user_branch'')'||nlchr||
                           'and pu.rnk=pru.rnk(+)'||nlchr||
                           'and pu.rnk=FINU.rnk(+)'||nlchr||
                           'and pu.rnk=uo.rnk(+)'||nlchr||
                           'and pu.rnk=uos.rnk(+)'||nlchr||
                           'and pu.rnk=gu.rnk(+)';
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
    l_rep.description :='Ф601 Частина 4 Інформація про боржника  - ЮО';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 99; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 6008;


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
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     

exec umu.add_report2arm(6008,'$RM_DRU1');
exec umu.add_report2arm(6008,'$RM_F601');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_6008.sql =========*** End 
PROMPT ===================================================================================== 
