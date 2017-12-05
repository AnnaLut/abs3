prompt ===================================== 
prompt == КП ФО (5 кат.якості, забезпечення)
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
   l_zpr.name := 'КП ФО (5 кат.якості, забезпечення)';
   l_zpr.pkey := '\BRS\SBR\DPT\209';

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
    l_zpr.name         := 'КП ФО (5 кат.якості, забезпечення)';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zdate=''Станом на (DD.MM.YYYY) :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select x1.branch, x1.nd, x1.kv, x1.rnk, x1.nmk, x1.DKAT5
     , x2.ost_s, x2.ost_sq, x2.ost_p, x2.ost_pq
     , x3.kat, x3.rez, x3.rezq
     , x4.nls, x4.kv as kv_9k, x4.s, x4.sv
from 
(
select d.branch, d.nd, c.rnk, c.nmk
     , t.txt as DKAT5, k9.kv 
from cc_deal d left join nd_txt t   on d.nd=t.nd and t.tag = ''KAT5''
               left join customer c on d.rnk=c.rnk
               left join (select a9.kv, n9.nd from accounts a9, nd_acc n9 where a9.acc=n9.acc and a9.tip=''LIM'' and (a9.dazs is NULL or a9.dazs > to_date(:zdate,''dd.mm.yyyy''))) k9 on k9.nd=d.nd
where d.vidd in (11,12,13) and d.sos<>15 and t.txt is not NULL
) x1 left join
(
select d2.nd
     , sum(nvl( case when a.nbs in (''2203'',''2232'',''2233'') then nvl(abs(fost(a.acc,to_date(:zdate,''dd.mm.yyyy'')))/100,0) else 0 end ,0)) as ost_s
     , sum(nvl( case when a.nbs in (''2203'',''2232'',''2233'') then nvl(round(abs(fost(a.acc,to_date(:zdate,''dd.mm.yyyy'')))/100
                                                                                        *nvl((select rate_o/bsum 
                                                                                              from cur_rates$base 
                                                                                              where kv=a.kv and branch=a.branch
                                                                                                 and vdate in (select max(v2.vdate) from cur_rates$base v2 
                                                                                                               where v2.kv=a.kv and v2.branch=a.branch 
                                                                                                                 and v2.vdate<=to_date(:zdate,''dd.mm.yyyy''))
                                                                                              ),1),2),0) else 0 end ,0)) as ost_sq
     , sum(nvl( case when a.nbs in (''@'') then nvl(abs(fost(a.acc,to_date(:zdate,''dd.mm.yyyy'')))/100,0) else 0 end ,0)) as ost_p
     , sum(nvl( case when a.nbs in (''@'') then nvl(round(abs(fost(a.acc,to_date(:zdate,''dd.mm.yyyy'')))/100
                                                                                        *nvl((select rate_o/bsum 
                                                                                              from cur_rates$base 
                                                                                              where kv=a.kv and branch=a.branch
                                                                                                 and vdate in (select max(v2.vdate) from cur_rates$base v2 
                                                                                                               where v2.kv=a.kv and v2.branch=a.branch 
                                                                                                                 and v2.vdate<=to_date(:zdate,''dd.mm.yyyy''))
                                                                                              ),1),2),0) else 0 end ,0)) as ost_pq
     
from accounts a, nd_acc n, cc_deal d2
where a.acc=n.acc and n.nd=d2.nd
  and a.nbs in (''2203'',''2232'',''2233'') 
  and (a.dazs is NULL or a.dazs > to_date(:zdate,''dd.mm.yyyy''))
  and d2.vidd in (11,12,13) and d2.sos<>15
  
group by d2.nd  
) x2 on x1.nd=x2.nd
left join
(
select r.nd, max(r.kat) as kat, sum(r.rez) as rez, sum(r.rezq) as rezq
from nbu23_rez r
where r.id like ''CCK%'' 
  and r.fdat=to_date(''01''||substr(:zdate,3,8),''dd.mm.yyyy'') 
  and r.DDD in (''123'',''125'') 
  and (r.DD is NULL or r.DD=''3'' or r.DD=''1'')
group by r.nd
) x3 on x1.nd=x3.nd
left join
(
select a5.nd, s5.nls, s5.kv, z5.sv/100 as sv, nvl(abs(fost(s5.acc,to_date(:zdate,''dd.mm.yyyy'')))/100,0) as s
from 
(
select d3.nd, d3.branch, max(a3.acc) as acc
from cc_deal d3, nd_acc n3, accounts a3
where d3.nd=n3.nd 
      and n3.acc=a3.acc 
      and (a3.tip like ''SS '' or a3.tip like ''SP '')
      and d3.sos <> 15 and d3.vidd in (11,12,13)
group by d3.nd, d3.b';
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
