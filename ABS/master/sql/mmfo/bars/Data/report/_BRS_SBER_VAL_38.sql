

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_VAL_38.sql =========*** Run *
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == ВУ:Звiт про купівлю/продаж готівкової валюти
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
   l_zpr.name := 'ВУ:Звiт про купівлю/продаж готівкової валюти';
   l_zpr.pkey := '\BRS\SBER\VAL\38';

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
    l_zpr.name         := 'ВУ:Звiт про купівлю/продаж готівкової валюти';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:BRANCH=''Вiддiлення (%-всi)'',:FL=''1-Розгорнуто''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'VU_38.qrp';
    l_zpr.form_proc    := 'p_val_283(to_date(:sFdat1,''dd-mm-yyyy''),to_date(:sFdat2,''dd-mm-yyyy''),:BRANCH)';
    l_zpr.default_vars := ':FL=''0''';
    l_zpr.bind_sql     := ':BRANCH=''OUR_BRANCH|BRANCH|NAME|WHERE length(branch)>=7 order by 1''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT :sFdat1 DAT1, :sFdat2 DAT2, :FL FL,:BRANCH BRA, '||nlchr||
                           '             x.KV KV, x.LCV LCV, x.NAME NAME, '||nlchr||
                           '             x.BRANCH BRANCH, x.nameb NAMEB,'||nlchr||
                           '             substr(x.branch,1,15) BRANCH2,'||nlchr||
                           '             x.KUPL_VAL KUPL_VAL, x.ZATR_GRN ZATR_GRN, x.PROD_VAL PROD_VAL, '||nlchr||
                           '             x.VYRU_GRN VYRU_GRN, to_number(x.KURS_KUPL) KURS_KUPL, to_number(x.KURS_PROD) KURS_PROD,'||nlchr||
                           '             x.KUPL_VAL*to_number(x.KURS_KUPL) EQ_KUPL,  x.PROD_VAL*to_number(x.KURS_PROD) EQ_PROD'||nlchr||
                           'FROM valuta_283 x'||nlchr||
                           'ORDER BY x.KV, substr(x.branch,1,15), x.BRANCH ';
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
    l_rep.description :='ВУ:Звiт про купівлю/продаж готівкової валюти';
    l_rep.form        :='frm_UniReport';
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
    l_rep.id          := 283;


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



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_VAL_38.sql =========*** End *
PROMPT ===================================================================================== 
