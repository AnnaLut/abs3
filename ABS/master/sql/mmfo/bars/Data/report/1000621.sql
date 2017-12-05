prompt ===================================== 
prompt == Платіжний календар по МБК (залучення). Додаток 1.
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
   l_zpr.name := 'Платіжний календар по МБК (залучення). Додаток 1.';
   l_zpr.pkey := '\OLD\SBR\MKD\1';

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
    l_zpr.name         := 'Платіжний календар по МБК (залучення). Додаток 1.';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''На дату'',:Param=''Сорт:1-Над,2-Пов,3-Рах''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select row_number() over(order by a.kv, decode(a.nbs,''1610'', ''(1610, 1621)'', ''1621'',''(1610, 1621)'', ''1613'', ''(1613, 1623)'', ''1623'',''(1613, 1623)'') , 
                                  decode(nvl(:Param,1),1,to_char(daos,''yyyymmdd''),2,to_char(mdate,''yyyymmdd''),3,nls) ) rn,
       a.daos "Дата_надання", 
       a.mdate "Дата_повернення", 
       nvl(c.nmk,''ВСЬОГО ПО ''||a.kv||''  ''||decode(a.nbs,''1610'', ''(1610, 1621)'', ''1621'',''(1610, 1621)'', ''1613'', ''(1613, 1623)'', ''1623'',''(1613, 1623)''))  "Назва_позичальника", 
       a.kv "Валюта", 
       a.nls "Рахунок", 
       sum(a.ostc)/100  "Сума", 
       sum(a.ostq)/100 "Сума_еквівалент" 
from  accounts a, customer c
where a.mdate between to_date(:sFdat1,''dd.mm.yyyy'') and to_date(:sFdat1,''dd.mm.yyyy'')+31 and  
      a.nbs in (''1610'',''1621'',''1613'',''1623'')  and
      a.rnk = c.rnk   and
      a.ostc <> 0 
group by grouping sets 
((a.daos, a.mdate,c.nmk,a.kv, a.nls, a.ostc,a.ostq, decode(a.nbs,''1610'', ''(1610, 1621)'', ''1621'',''(1610, 1621)'', ''1613'', ''(1613, 1623)'', ''1623'',''(1613, 1623)'') ),
 (kv, decode(a.nbs,''1610'', ''(1610, 1621)'', ''1621'',''(1610, 1621)'', ''1613'', ''(1613, 1623)'', ''1623'',''(1613, 1623)''))
)     
order by kv, decode(a.nbs,''1610'', ''(1610, 1621)'', ''1621'',''(1610, 1621)'', ''1613'', ''(1613, 1623)'', ''1623'',''(1613, 1623)'') , 
         decode(nvl(:Param,1),1,to_char(daos,''yyyymmdd''),2,to_char(mdate,''yyyymmdd''),3,nls)';
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
