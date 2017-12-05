prompt ===================================== 
prompt == Залишки гр.26 за кредитними договорами з простроченням
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
   l_zpr.name := 'Залишки гр.26 за кредитними договорами з простроченням';
   l_zpr.pkey := '\BRS\SBR\DPT\324';

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
    l_zpr.name         := 'Залишки гр.26 за кредитними договорами з простроченням';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := '';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select to_char(sysdate,''dd.mm.yyyy hh24:mi:ss'') as date_time, x.*, c.nmk, c.okpo, a.nls, a.kv, a.ostc/100 as ost_VKL
from (
select d.branch, d.nd, d.rnk, sum(abs(a.ostc))/100 as sum_pr
from cc_deal d, nd_acc n, accounts a
where d.nd=n.nd and a.acc=n.acc
  and d.sos<>15
  and d.vidd in (11,12,13)
  and a.nbs in (''2206'',''2233'',''2208'',''2238'',''3578'') 
  and a.ostc<>0
  and a.dazs is NULL
group by d.branch, d.nd, d.rnk 
) x left join accounts a on a.rnk=x.rnk and a.nbs in (''2620'',''2630'',''2625'') and a.dazs is NULL 
    left join customer c on c.rnk=x.rnk and c.date_off is NULL
order by x.rnk';
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
