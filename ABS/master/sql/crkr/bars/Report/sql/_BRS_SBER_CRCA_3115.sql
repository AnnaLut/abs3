prompt ===================================== 
prompt == Актуалізація планові суми виплат 
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
   l_zpr.name := 'Актуалізація планові суми виплат';
   l_zpr.pkey := '\BRS\SBER\CRCA\3115';

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
    l_zpr.name         := 'Актуалізація планові суми виплат';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:p_mfo=''МФО (%-всі)'',:p_gr=''В розрізі (0-мфо 1-бранчів)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'brs_3115.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':p_mfo=''%'',:p_gr=''1''';
    l_zpr.bind_sql     := ':p_mfo=''BANKS_RU|MFO|NAME|ORDER BY RU''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'WITH ZAP AS (
                Select r.ru,
                       r.name,
                       o.branch,
                       B.NAME NAMEB,
                       O.DATE_VAL_REG,
                       COUNT(O.RNK) KOL,
                       SUM(O.AMOUNT/100) AMOUNT
                  from COMPEN_PAYMENTS_REGISTRY o, branch b, banks_ru r
                 where o.date_val_reg between to_date(:sFdat1) and to_date(:sFdat2)+0.999
                   and o.branch = b.branch
                   AND O.TYPE_ID = 1
                   and O.STATE_ID = 0
                   and O.MFO_CLIENT like :p_mfo
                   and O.MFO_CLIENT = r.mfo
                gROUP BY r.ru, r.name, o.branch, B.NAME, O.DATE_VAL_REG 
             )
SELECT ru, name, branch, nameb, DATE_VAL_REG, kol, amount, ''1'' ord 
  FROM ZAP
 where :p_gr = 1  
Union all
SELECT ru, name, null branch, null nameb,DATE_VAL_REG, sum(kol)kol, sum(amount)amount, ''0'' ord 
  FROM ZAP
Group by ru, name, DATE_VAL_REG    
order by 1,7,3';
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
    l_rep.description :='Актуалізація планові суми виплат';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 0; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 3115;


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
   