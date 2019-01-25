

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_6011.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Ф601 Част.7 Інформація щодо забезпечення за КО з боржником-ЮО
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
   l_zpr.name := 'Ф601 Част.7 Інформація щодо забезпечення за КО з боржником-ЮО';
   l_zpr.pkey := '\BRS\SBM\REP\6011';

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
    l_zpr.name         := 'Ф601 Част.7 Інформація щодо забезпечення за КО з боржником-ЮО';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''Останній сформований звіт в період з'',:sFdat2=''По'',:B=''Відділення''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep6011.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := ':B=''OUR_BRANCH|BRANCH|NAME|WHERE length(branch)<16 and length(branch)>7 ORDER BY BRANCH ''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select'||nlchr||
                           '  P.NUMBERPLEDGE NUMBERPLEDGE,'||nlchr||
                           '  c.NUMDOG PLEDGE_CODE,'||nlchr||
                           '  P.PLEDGEDAY PLEDGEDAY,'||nlchr||
                           '  P.S031 S031,'||nlchr||
                           '  P.R030 R030,'||nlchr||
                           '  P.SUMPLEDGE SUMPLEDGE,'||nlchr||
                           '  P.PRICEPLEDGE PRICEPLEDGE,'||nlchr||
                           '  P.LASTPLEDGEDAY LASTPLEDGEDAY,'||nlchr||
                           '  P.CODREALTY CODREALTY,'||nlchr||
                           '  P.ZIPREALTY ZIPREALTY,'||nlchr||
                           '  P.SQUAREREALTY SQUAREREALTY,'||nlchr||
                           '  P.REAL6INCOME REAL6INCOME,'||nlchr||
                           '  P.NOREAL6INCOME NOREAL6INCOME,'||nlchr||
                           '  P.FLAGINSURANCEPLEDGE FLAGINSURANCEPLEDGE,'||nlchr||
                           '  P.SUMBAIL,'||nlchr||
                           '  P.SUMGUARANTEE SUMGUARANTEE,'||nlchr||
                           '  c.FLAGINSURANCE scredit,'||nlchr||
                           '  f_dat_lit(:sFdat1) STR_DAT1,'||nlchr||
                           '  f_dat_lit(:sFdat2) STR_DAT2,'||nlchr||
                           '  :B branch'||nlchr||
                           'from'||nlchr||
                           'branch b,'||nlchr||
                           '(select * from  nbu_gateway.NBU_CORE_DATA_REQUEST dat where ID ='||nlchr||
                           '      (select max(ID) from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=14 '||nlchr||
                           '       and ((RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')) = :B)'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >=:sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <=:sFdat2)) dat,'||nlchr||
                           '(select * from  nbu_gateway.CORE_PERSON_UO pu where REQUEST_ID ='||nlchr||
                           '      (select max(ID) from nbu_gateway.NBU_CORE_DATA_REQUEST dat '||nlchr||
                           '       where DATA_TYPE_ID=6'||nlchr||
                           '       and ((RPAD(LPAD(dat.KF, 7, ''/''), 8, ''/'')) = :B)'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) >= :sFdat1'||nlchr||
                           '       and trunc(CAST(dat.REPORTING_time AS DATE)) <= :sFdat2)) pu,'||nlchr||
                           'nbu_gateway.CORE_PLEDGE_DEP p,'||nlchr||
                           'nbu_gateway.CORE_CREDIT c'||nlchr||
                           'where'||nlchr||
                           'b.branch = substr(bars_report.get_branch(:B,0),1, 24 )'||nlchr||
                           '   and dat.id=p.REQUEST_ID'||nlchr||
                           '   and p.rnk=pu.rnk'||nlchr||
                           '   and P.RNK=c.RNK(+)';
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
    l_rep.description :='Ф601 Част.7 Інформація щодо забезпечення за КО з боржником-ЮО';
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
    l_rep.id          := 6011;


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

exec umu.add_report2arm(6011,'$RM_DRU1');
exec umu.add_report2arm(6011,'$RM_F601');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_6011.sql =========*** End 
PROMPT ===================================================================================== 
