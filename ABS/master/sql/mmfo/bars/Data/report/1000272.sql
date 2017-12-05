prompt ===================================== 
prompt == Нараховані та несплачені доходи
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
   l_zpr.name := 'Нараховані та несплачені доходи';
   l_zpr.pkey := '\OLD\***\***\311';

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
    l_zpr.name         := 'Нараховані та несплачені доходи';
    l_zpr.namef        := 'deb';
    l_zpr.bindvars     := ':Param0=''За дату:''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select * from (
select '' ''||nmk Kontr,c.rnk Nomer,nls ,kv ,dapp Ost_op,nms Nazv_sch,-fost(a.acc,:Param0)/100 Ost_nom,-fostq(a.acc,:Param0)/100 Ost_eq
from accounts a,cust_acc b,customer c
where a.acc=b.acc and b.rnk=c.rnk and fost(a.acc,:Param0)<>0
and nbs in (1208,
            1218,
            1418,
            1428,
            1438,
            1448,
            1508,
            1518,
            1519,
            1528,
            1780,
            2008,
            2018,
            2028,
            2038,
            2048,
            2049,
            2058,
            2059,
            2068,
            2078,
            2108,
            2118,
            2208,
            2218,
            2219,
            2480,
            3108,
            3118,
            3208,
            3218,
            3219,
            3570,
            3578,
            3589,
            3904)
union all
select ''Загалом по '' || nmk || '' валюта ''||kv,c.rnk,'''',kv,max(dapp),'''',-sum(fost(a.acc,:Param0)/100),-sum(fostq(a.acc,:Param0)/100)
from accounts a,cust_acc b,customer c
where a.acc=b.acc and b.rnk=c.rnk and fost(a.acc,:Param0)<>0
and nbs in (1208,
            1218,
            1418,
            1428,
            1438,
            1448,
            1508,
            1518,
            1519,
            1528,
            1780,
            2008,
            2018,
            2028,
            2038,
            2048,
            2049,
            2058,
            2059,
            2068,
            2078,
            2108,
            2118,
            2208,
            2218,
            2219,
            2480,
            3108,
            3118,
            3208,
            3218,
            3219,
            3570,
            3578,
            3589,
            3904)
group by nmk,c.rnk,kv
having count(*)>1
union all
select ''Загалом валютi ''||kv,9999999999,'''',kv,max(dapp),'''',-sum(fost(a.acc,:Param0)/100),-sum(fostq(a.acc,:Param0)/100)
from accounts a,cust_acc b,customer c
where a.acc=b.acc and b.rnk=c.rnk and fost(a.acc,:Param0)<>0
and nbs in (1208,
            1218,
            1418,
            1428,
            1438,
            1448,
            1508,
            1518,
            1519,
            1528,
            1780,
            2008,
            2018,
            2028,
            2038,
            2048,
            2049,
            2058,
            2059,
            2068,
            2078,
            2108,
            2118,
            2208,
            2218,
            2219,
            2480,
            3108,
            3118,
            3208,
            3218,
            3219,
            3570,
            3578,
            3589,
            3904)
group by kv 
order by 2,1)
union all
select ''Позабалансові 9 класу'',9999999999,'''',0,bankdate,'''',0,0
from dual
union all
select * from (
select '' ''||nmk Kontr,c.rnk Nomer,nls ,kv ,dapp Ost_op,nms Nazv_sch,-fost(a.acc,:Param0)/100 Ost_nom,-fostq(a.acc,:Param0)/100 Ost_eq
from accounts a,cust_acc b,customer c
where a.acc=b.acc and b.rnk=c.rnk and fost(a.acc,:Param0)<>0
and nbs in (9600,9601,9603)
union all
select ''Загалом по '' || nmk || '' валюта ''||kv,c.rnk,'''',kv,max(dapp),'''',-sum(fost(a.acc,:Param0)/100),-sum(fostq(a.acc,:Param0)/100)
from accounts a,cust_acc b,customer c
where a.acc=b.acc and b.rnk=c.rnk and fost(a.acc,:Param0)<>0
and nbs in (9600,9601,9603)
group by nmk,c.rnk,kv
having count(*)>1
union all
select ''Загалом валютi ''||kv,9999999999,'''',kv,max(dapp),'''',-sum(fost(a.acc,:Param0)/100),-sum(fostq(a.acc,:Param0)/100)
from accounts a,cust_acc b,customer c
where a.acc=b.acc and b.rnk=c.rnk and fost(a.acc,:Param0)<>0
and nbs in (9600,9601,9603)
group by kv 
order by 2,1)';
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
