prompt ===================================== 
prompt == Рах-ки НЕ привязані до портфеля ЦП
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
   l_zpr.name := 'Рах-ки НЕ привязані до портфеля ЦП';
   l_zpr.pkey := '\BRS\***\CPR\8';

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
    l_zpr.name         := 'Рах-ки НЕ привязані до портфеля ЦП';
    l_zpr.namef        := '';
    l_zpr.bindvars     := '';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'CP_NOPF.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select acc,nls,nbs,kv,nms,daos,dapp,dazs, accc,isp, rnk, ostc, trcn, mdate, ob22, branch, kf, 0 cons 
from accounts a
where substr(a.nls,1,4) in 
(''3002'',''3003'',''3005'',''3006'',''3007'',''3008'',
''3010'',''3011'',''3012'',''3013'',''3014'',''3016'',''3017'',''3018'',
''3102'',''3103'',''3105'',''3106'',''3107'',''3108'',
''3110'',''3111'',''3112'',''3113'',''3114'',''3115'',''3116'',''3118'',
''3120'',''3122'',''3123'',''3125'',''3128'',
''3202'',''3203'',''3205'',''3208'',
''3210'',''3211'',''3212'',''3213'',''3214'',''3216'',''3218'',''3219'',
''1400'',''1401'',''1402'',''1403'',''1404'',''1405'',''1406'',''1407'',''1408'',
''1410'',''1411'',''1412'',''1413'',''1414'',''1415'',''1416'',''1418'',''1419'',
''1420'',''1421'',''1422'',''1423'',''1424'',''1426'',''1428'',''1429'',
''1430'',''1435'',''1436'',''1437'',''1438'',
''1440'',''1446'',''1447'',''1448''
)   
and dazs is null and nbs is null
and acc not in (select acc from cp_deal
                 union all select accd from cp_deal where accd is not null
                 union all select accp from cp_deal where accp is not null
                 union all select accr from cp_deal where accr is not null
                 union all select accr2 from cp_deal where accr2 is not null
                 union all select accs from cp_deal where accs is not null                                 
                 )     
 union all               
select acc,nls,nbs,kv,nms,daos,dapp,dazs, accc,isp, rnk, ostc, trcn ,mdate, ob22, branch, kf, 1 
from accounts a
where a.nbs in 
(''3002'',''3003'',''3005'',''3006'',''3007'',''3008'',
''3010'',''3011'',''3012'',''3013'',''3014'',''3016'',''3017'',''3018'',
''3102'',''3103'',''3105'',''3106'',''3107'',''3108'',
''3110'',''3111'',''3112'',''3113'',''3114'',''3115'',''3116'',''3118'',
''3120'',''3122'',''3123'',''3125'',''3128'',
''3202'',''3203'',''3205'',''3208'',
''3210'',''3211'',''3212'',''3213'',''3214'',''3216''''3218'',''3219'',
''1400'',''1401'',''1402'',''1403'',''1404'',''1405'',''1406'',''1407'',''1408'',
''1410'',''1411'',''1412'',''1413'',''1414'',''1415'',''1416'',''1418'',''1419'',
''1420'',''1421'',''1422'',''1423'',''1424'',''1426'',''1428'',''1429'',
''1430'',''1435'',''1436'',''1437'',''1438'',
''1440'',''1446'',''1447'',''1448''
)    
and dazs is null and nbs is not null                           
and a.nls not in (select nlsa from cp_accc 
                union all select nlsd from cp_accc where nlsd is not null
                union all select nlsp from cp_accc  where nlsp is not null
                union all select nlsr from cp_accc  where nlsr is not null
                union all select nlsr2 from cp_accc where nlsr2 is not null
                union all select nlss from cp_accc  where nlss is not null   
                )   
order by nls';
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
