prompt ===================================== 
prompt == SBER. Среднедневные остатки
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
   l_zpr.name := 'SBER. Среднедневные остатки';
   l_zpr.pkey := '\BRS\SBM\***\809\';

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
    l_zpr.name         := 'SBER. Среднедневные остатки';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param=''Бал.рахунок''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select substr(a.branch,1,15) branch,a.nbs,a.ob22,a.kv,
          round(sum(fostq(a.acc,t_id.cdat))/(100*(to_date(:sFdat2,''dd/mm/yyyy'') - to_date(:sFdat1,''dd/mm/yyyy'')+1)),2) ost_avg
--t_id.bankdt_id,fostq_snp_day(a.acc,t_id.bankdt_id)
from accounts a,(select * from iot_calendar where cdat>=to_date(:sFdat1,''dd/mm/yyyy'') and cdat<=to_date(:sFdat2,''dd/mm/yyyy'')) t_id
where  (to_date(:sFdat2,''dd/mm/yyyy'') - to_date(:sFdat1,''dd/mm/yyyy''))<32 and
             a.nbs=:Param  and (a.dazs is null or a.dazs>=to_date(:sFdat2,''dd/mm/yyyy'')) and :Param in (2620,2630)
group by rollup(substr(a.branch,1,15),a.nbs,a.ob22,a.kv)
order by substr(a.branch,1,15),a.nbs,a.ob22,a.kv';
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
