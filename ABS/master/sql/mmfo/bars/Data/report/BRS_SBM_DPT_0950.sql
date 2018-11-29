

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_DPT_0950.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Вклади які пролонгуються протягом наступних банківських днів
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
   l_zpr.name := 'Вклади які пролонгуються протягом наступних банківських днів';
   l_zpr.pkey := '\BRS\SBM\DPT\0950';

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
    l_zpr.name         := 'Вклади які пролонгуються протягом наступних банківських днів';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':Param0=''Кількість банківських днів''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'DPT_EXP2.QRP';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=3';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT D.ND, D.DAT_END, (FOST(D.ACC, D.DAT_END)/100 + FOST(I.ACRA, D.DAT_END)/100) AS BALANCE, D.KV,
       C.NMK, P.TELD, substr(f_custw(C.RNK, ''MPNO ''),1,254) as TELW
  FROM DPT_DEPOSIT D,
       INT_ACCN I,
       CUSTOMER C,
       PERSON P
 WHERE ( D.VIDD IN ( SELECT VIDD FROM DPT_VIDD WHERE FL_DUBL = 2 ) OR 
         D.DEPOSIT_ID NOT IN (SELECT DPTID FROM DPT_EXTREFUSALS WHERE REQ_STATE = 1 ) )
   AND DAT_END BETWEEN DAT_NEXT_U(BANKDATE, 1) AND DAT_NEXT_U(BANKDATE, :Param0) 
   AND D.BRANCH LIKE SYS_CONTEXT(''BARS_CONTEXT'',''USER_BRANCH_MASK'') 
   AND D.RNK = C.RNK
   AND D.RNK = P.RNK(+)
   AND D.ACC = I.ACC
   AND I.ID  = 1
 ORDER BY D.DAT_END, D.KV';
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
    l_rep.description :='Вклади які пролонгуються протягом наступних банківських днів';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=0;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 160; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 1008;


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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_DPT_0950.sql =========*** End 
PROMPT ===================================================================================== 
