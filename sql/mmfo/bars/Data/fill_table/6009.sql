

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_6009.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Ф601 Част.5 Інформація щодо власників істотної участі боржника-ЮО
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
   l_zpr.name := 'Ф601 Част.5 Інформація щодо власників істотної участі боржника-ЮО';
   l_zpr.pkey := '\BRS\SBM\REP\6009';

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
    l_zpr.name         := 'Ф601 Част.5 Інформація щодо власників істотної участі боржника-ЮО';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''Останній сформований звіт в період з'',:sFdat2=''По''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep6009.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select '||nlchr||
                           ' f.LASTNAME || '' '' || f.FIRSTNAME || '' '' || f.MIDDLENAME as fio,'||nlchr||
                           ' f.INN INN,'||nlchr||
                           ' f.COUNTRYCOD COUNTRYCOD,'||nlchr||
                           ' f.ISREZ ISREZ,'||nlchr||
                           ' f.COUNTRYCOD COUNTRYCOD,'||nlchr||
                           ' f.PERCENT fPERCENT,'||nlchr||
                           ' f.STREETADDRESS || '' '' || f.HOUSENO as ADDRESS,'||nlchr||
                           ' uu.CODEDRPOUOJ CODEDRPOUOJ,    '||nlchr||
                           ' uu.REGISTRYDAYOJ || '' '' ||  uu.NUMBERREGISTRYOJ as REGISTRYOJ,'||nlchr||
                           ' uu.ISREZOJ ISREZOJ,'||nlchr||
                           ' uu.COUNTRYCODOJ COUNTRYCODOJ,'||nlchr||
                           ' uu.PERCENTOJ PERCENTOJ,'||nlchr||
                           ' uu.NAMEOJ NAMEOJ,'||nlchr||
                           ' f_dat_lit(:sFdat1) STR_DAT1,'||nlchr||
                           ' f_dat_lit(:sFdat2) STR_DAT2,'||nlchr||
                           ' sys_context(''bars_context'',''user_branch'') branch,'||nlchr||
                           ' b.name branchname '||nlchr||
                           'from '||nlchr||
                           '(select * from nbu_gateway.CORE_OWNERPP_UO f where f.REQUEST_ID in ( (select max(ID) from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where '||nlchr||
                           '       DATA_TYPE_ID =12'||nlchr||
                           '       and dat.KF=(trim( both ''/'' from sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2))) f,'||nlchr||
                           '(select * from nbu_gateway.CORE_OWNERJUR_UO uu where uu.REQUEST_ID in ( (select max(ID) from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where '||nlchr||
                           '       DATA_TYPE_ID =13'||nlchr||
                           '       and dat.KF=(trim( both ''/'' from sys_context(''bars_context'',''user_branch'')))'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2))) uu,'||nlchr||
                           ' branch b'||nlchr||
                           'where'||nlchr||
                           ' b.branch = sys_context(''bars_context'',''user_branch'')'||nlchr||
                           ' and f.rnk=uu.rnkb';
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
    l_rep.description :='Ф601 Част.5 Інформація щодо власників істотної участі боржника-ЮО';
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
    l_rep.id          := 6009;


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

exec umu.add_report2arm(6009,'$RM_DRU1');
exec umu.add_report2arm(6009,'$RM_F601');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_6009.sql =========*** End 
PROMPT ===================================================================================== 
