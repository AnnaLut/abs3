prompt ===================================== 
prompt == Сегментація (ЮО)
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
   l_zpr.name := 'Сегментація (ЮО)';
   l_zpr.pkey := '\BRS\SBR\DPT\184';

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
    l_zpr.name         := 'Сегментація (ЮО)';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':nbs=''Бал.рахунки (пусто - всі, ВВВВ,ВВВВ...- окремі):'',:kv=''Валюта (0 або пусто - всі, 1 - всі крім UAH, ККК - код вал.)
 :'',:indcode=''Код ЗКПО :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select a.branch, c.nmk, c.rnk, a.nls, a.kv, a.nbs, a.daos
     , w1.value as CHS_DOH
     , w2.value as OBS_VYR
     , w3.value as RIZIK
     , w4.value as NEXT_ID_DATE
     , x1.mfo as MFO_1, (select b.nb from banks$base b where b.mfo=x1.mfo) as bname_1
     , x2.mfo as MFO_2, (select b.nb from banks$base b where b.mfo=x2.mfo) as bname_2
     , x3.mfo as MFO_3, (select b.nb from banks$base b where b.mfo=x3.mfo) as bname_3
     , x4.mfo as MFO_4, (select b.nb from banks$base b where b.mfo=x4.mfo) as bname_4
     , x5.mfo as MFO_5, (select b.nb from banks$base b where b.mfo=x5.mfo) as bname_5
     , x6.mfo as MFO_6, (select b.nb from banks$base b where b.mfo=x6.mfo) as bname_6
from accounts a left join customer c on a.rnk=c.rnk
                left join customerw w1 on w1.rnk=c.rnk and w1.tag=''FSDRY''
                left join customerw w2 on w2.rnk=c.rnk and w2.tag=''FSOVR''
                left join customerw w3 on w3.rnk=c.rnk and w3.tag=''RIZIK''
                left join customerw w4 on w4.rnk=c.rnk and w4.tag=''IDDPL''
                left join (select cs.rnk, cs.mfo, row_number() OVER (PARTITION BY cs.rnk ORDER BY cs.mfo) as nn from (select rnk, mfo from corps_acc  group by rnk, mfo) cs ) x1 on c.rnk=x1.rnk and x1.nn=1
                left join (select cs.rnk, cs.mfo, row_number() OVER (PARTITION BY cs.rnk ORDER BY cs.mfo) as nn from (select rnk, mfo from corps_acc  group by rnk, mfo) cs ) x2 on c.rnk=x2.rnk and x2.nn=2
                left join (select cs.rnk, cs.mfo, row_number() OVER (PARTITION BY cs.rnk ORDER BY cs.mfo) as nn from (select rnk, mfo from corps_acc  group by rnk, mfo) cs ) x3 on c.rnk=x3.rnk and x3.nn=3
                left join (select cs.rnk, cs.mfo, row_number() OVER (PARTITION BY cs.rnk ORDER BY cs.mfo) as nn from (select rnk, mfo from corps_acc  group by rnk, mfo) cs ) x4 on c.rnk=x4.rnk and x4.nn=4
                left join (select cs.rnk, cs.mfo, row_number() OVER (PARTITION BY cs.rnk ORDER BY cs.mfo) as nn from (select rnk, mfo from corps_acc  group by rnk, mfo) cs ) x5 on c.rnk=x5.rnk and x5.nn=5
                left join (select cs.rnk, cs.mfo, row_number() OVER (PARTITION BY cs.rnk ORDER BY cs.mfo) as nn from (select rnk, mfo from corps_acc  group by rnk, mfo) cs ) x6 on c.rnk=x6.rnk and x6.nn=6
where a.nbs in (''2909'',''2512'',''2513'',''2520'',''2523'',''2526'',''2530'',''2531'',''2541'',''2542'',''2544'',''2545'',''2552'',''2553'',''2554'',''2555'',''2560'',''2561'',''2562'',''2565'',''2570'',''2571'',''2572'',''2600'',''2601'',''2602'',''2603'',''2604'',''2605'',''2606'',''2610'',''2640'',''2641'',''2642'',''2643'',''2650'',''2651'',''2655'')
  and replace((case when :nbs is NULL then a.nbs else :nbs end),a.nbs,''XXXX'') like ''%XXXX%''
  and (a.dazs is NULL or a.dazs > sysdate)
  and a.daos <= sysdate
  and a.daos<>nvl(a.dazs,a.daos+1)
  and a.kv in (case when nvl(to_number(:kv),0)=0 then a.kv
                    when nvl(to_number(:kv),0)=1 then (select kv 
                                                       from tabval$global 
                                                       where kv<>980 and kv=a.kv and d_close is NULL  
                                                       group by kv) 
                     else to_number(:kv)  end)
  and nvl(:indcode,''1'') in (select case when nvl(:indcode,1)=''1'' then ''1'' else c.okpo end from customer c where c.rnk=a.rnk)
  and c.k050<>''000'' and c.okpo<>''09322277''
order by a.rnk, a.acc';
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
