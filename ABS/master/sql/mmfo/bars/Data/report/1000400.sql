prompt ===================================== 
prompt == Легалізація (значні суми 80000)
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
   l_zpr.name := 'Легалізація (значні суми 80000)';
   l_zpr.pkey := '\OLD\***\***\229';

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
    l_zpr.name         := 'Легалізація (значні суми 80000)';
    l_zpr.namef        := 'zyasuv';
    l_zpr.bindvars     := ':Param0=''Дата з:'',:Param1=''Дата по:''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'zyasuv.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select ''Aieoiaioe cia?i? aio?aeia?'' tip,
   ref,
   tt,
   nd,
   vdat,
   kv,
   dk,
   s,
   nam_a,
   nlsa,
   mfoa,
   nam_b,
   nlsb,
   mfob,
   nazn,
   userid,
   id_a,
   id_b 
 from oper o
 where o.vdat>=:Param0 and o.vdat<=:Param1 and
   ((substr(o.nlsa,1,4) in (''2010'',''2020'',''2030'',''2040'',''2045'',''2045'',''2050'',''2055'',''2061'',''2070'',''2071'',''2072'',''2073'',''2074'',
''2100'',''2110'',''2201'',''2210'',''2211'',
''2213'',''2214'',''2600'',''2602'',''2604'',''2605'',''2610'',''2611'',
''2620'',''2622'',''2625'',''2630'',''2640'',''2641'',''2642'',''2643'',
''2650'',''2651'',''2655'',''2625'',''2620'',''2630'',''2603'',
       ''2605'',''2210'',''2211'',''2213'',''2214'',''1600'') 
   and substr(o.nlsb,1,4)=''1001'') or
   (substr(o.nlsb,1,4) in (''2010'',''2020'',''2030'',''2040'',''2045'',''2045'',''2050'',''2055'',''2061'',''2070'',''2071'',''2072'',''2073'',''2074'',
''2100'',''2110'',''2201'',''2210'',''2211'',
''2213'',''2214'',''2600'',''2602'',''2604'',''2605'',''2610'',''2611'',
''2620'',''2622'',''2625'',''2630'',''2640'',''2641'',''2642'',''2643'',
''2650'',''2651'',''2655'',''2625'',''2620'',''2630'',''2603'',
       ''2605'',''2210'',''2211'',''2213'',''2214'',''1600'') 
   and substr(o.nlsa,1,4)=''1001'')) and
   (gl.p_icurval(o.kv,o.s/100,o.vdat))>=50000 and o.sos=5
union all
 select ''Aieoiaioe cia?i? aacaio?aeia?'' tip,
   ref,
   tt,
   nd,
   vdat,
   kv,
   dk,
   s,
   nam_a,
   nlsa,
   mfoa,
   nam_b,
   nlsb,
   mfob,
   nazn,
   userid,
   id_a,
   id_b  
 from oper o
 where o.vdat>=:Param0 and o.vdat<=:Param1 and
   (substr(o.nlsa,1,4) in (''2010'',''2020'',''2030'',''2040'',''2045'',''2045'',''2050'',''2055'',''2061'',''2070'',''2071'',''2072'',''2073'',''2074'',
''2100'',''2110'',''2201'',''2210'',''2211'',
''2213'',''2214'',''2600'',''2602'',''2604'',''2605'',''2610'',''2611'',
''2620'',''2622'',''2625'',''2630'',''2640'',''2641'',''2642'',''2643'',
''2650'',''2651'',''2655'',''2625'',''2620'',''2630'',''2603'',
       ''2605'',''2210'',''2211'',''2213'',''2214'',''1600'') or
   substr(o.nlsb,1,4) in (''2010'',''2020'',''2030'',''2040'',''2045'',''2045'',''2050'',''2055'',''2061'',''2070'',''2071'',''2072'',''2073'',''2074'',
''2100'',''2110'',''2201'',''2210'',''2211'',
''2213'',''2214'',''2600'',''2602'',''2604'',''2605'',''2610'',''2611'',
''2620'',''2622'',''2625'',''2630'',''2640'',''2641'',''2642'',''2643'',
''2650'',''2651'',''2655'',''2625'',''2620'',''2630'',''2603'',
       ''2605'',''2210'',''2211'',''2213'',''2214'',''1600'')) and
   (gl.p_icurval(o.kv,o.s/100,o.vdat))>=80000 and o.sos=5
union all
select ''Aieoiaioe aac a?ae?eooy ?aooieo'' tip,
   ref,
   tt,
   nd,
   vdat,
   kv,
   dk,
   s,
   nam_a,
   nlsa,
   mfoa,
   nam_b,
   nlsb,
   mfob,
   nazn,
   userid,
   id_a,
   id_b 
 from oper o
 where o.vdat>=:Param0 and o.vdat<=:Param1 and
   (substr(o.nlsb,1,4)=''1001'' or substr(o.nlsa,1,4)=''1001'') and
   (gl.p_icurval(o.kv,o.s/100,o.vdat))>=50000 and o.sos=5
order by 1,2';
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
