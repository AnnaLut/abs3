prompt ===================================== 
prompt == Платіжний календ. по строковим МБК по валютах. Додаток 3.
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
   l_zpr.name := 'Платіжний календ. по строковим МБК по валютах. Додаток 3.';
   l_zpr.pkey := '\OLD\SBR\MKD\4';

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
    l_zpr.name         := 'Платіжний календ. по строковим МБК по валютах. Додаток 3.';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':dat_=''На дату''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select nvl(to_char(kv),''РАЗОМ'') "ВАЛЮТА" 
       ,to_number(decode(kv,null,null, sum(decode(nbs,''1513'', ostc, ''1524'',ostc, 0))/100)) "Розміщення"
       ,sum(decode(nbs,''1513'', ostq, ''1524'',ostq, 0))/100 "Розміщення_екв"
       ,to_number(decode(kv,null,null, sum(decode(nbs,''1613'', ostc, ''1623'',ostc, 0))/100)) "Залучення"
       ,sum(decode(nbs,''1613'', ostq, ''1623'',ostq, 0))/100 "Залучення_екв"      
from accounts a
where mdate between to_date(:dat_,''dd.mm.yyyy'') and to_date(:dat_,''dd.mm.yyyy'')+31 and
      nbs in (''1513'',''1524'',''1613'',''1623'') and
      a.ostc <> 0 
group by
grouping sets
( (kv),
  ()
)1000624';
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
