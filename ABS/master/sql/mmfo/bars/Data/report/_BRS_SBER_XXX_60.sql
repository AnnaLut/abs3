prompt ===================================== 
prompt == Остатки на ГРН счетах (AHISTORY.DBF)
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
   l_zpr.name := 'Остатки на ГРН счетах (AHISTORY.DBF)';

   l_zpr.pkey := '\BRS\SBER\***\60';

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
    l_zpr.name         := 'Остатки на ГРН счетах (AHISTORY.DBF)';
    l_zpr.namef        := '=''AHISTORY.DBF''';
    l_zpr.bindvars     := '';
    l_zpr.create_stmt  := 'PERIOD DATE, NLS NUMBER(14), KV NUMBER(3),'||nlchr||
                           ''||nlchr||
                           ''||nlchr||
                           ''||nlchr||
                           ''||nlchr||
                           ''||nlchr||
                           'INFOTYPE NUMBER(1), STATEID NUMBER(3),'||nlchr||
                           ''||nlchr||
                           ''||nlchr||
                           ''||nlchr||
                           ''||nlchr||
                           ''||nlchr||
                           'BALANS NUMBER(16,2), DEBIT NUMBER(16,2), KREDIT  NUMBER(16,2)';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT '||nlchr||
                           '  BANKDATE PERIOD, TO_NUMBER(NLS) NLS, kv, '||nlchr||
                           '  2 INFOTYPE, GET_STATEID(SYSDATE,1) STATEID,'||nlchr||
                           '  OST/100 BALANS, DOS/100 DEBIT, KOS/100 KREDIT '||nlchr||
                           'FROM '||nlchr||
                           '  SAL '||nlchr||
                           'WHERE '||nlchr||
                           '  FDAT=BANKDATE AND NBS IN (''1200'', ''3901'') '||nlchr||
                           '                AND (OST<>0 OR DOS<>0 OR KOS<>0) '||nlchr||
                           'ORDER BY SUBSTR(NLS,1,4) || SUBSTR(NLS,6,9)';
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
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     
