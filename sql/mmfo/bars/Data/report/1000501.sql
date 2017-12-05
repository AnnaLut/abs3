prompt ===================================== 
prompt == Фінансовий моніторинг рахунків
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
   l_zpr.name := 'Фінансовий моніторинг рахунків';
   l_zpr.pkey := '\OLD\***\***\288';

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
    l_zpr.name         := 'Фінансовий моніторинг рахунків';
    l_zpr.namef        := 'fin_mon';
    l_zpr.bindvars     := ':Param0=''З дати:'',:Param1=''По дату:'',:Param2=''Рахунок:(%-всі)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'fin_mon.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select
    a.nls,
    c.rnk,
    c.nmk,
    :Param0 dat1,
    :Param1 dat2,
    sum(fkosq(a.acc,:Param0,:Param1)) kos,
    sum(fdosq(a.acc,:Param0,:Param1)) dos,
    (select sum(gl.p_icurval(kv,s,datd)) from oper where datd between :Param0 and :Param1 and ((nlsb=a.nls and substr(nlsa,1,4) = 1001 and dk=0) or (nlsa=a.nls and substr(nlsb,1,4) = 1001 and dk=1))) to1001,
    (select sum(gl.p_icurval(kv,s,datd)) from oper where datd between :Param0 and :Param1 and ((nlsa=a.nls and substr(nlsb,1,4) = 1001 and dk=0) or (nlsb=a.nls and substr(nlsa,1,4) = 1001 and dk=1))) from1001,
    sum(fostq(a.acc,:Param1)) ost,
    (select sum(gl.p_icurval(o.kv,o.s,o.datd)) from oper o,accounts a1,cust_acc ca1, customer c1 where datd between :Param0 and :Param1 and ((o.nlsa=a1.nls and o.dk=1) or (o.nlsb=a1.nls and o.dk=0)) and a1.acc=ca1.acc and a1.nbs in (2010,2020,2030,2063,2071,2072,2073,2074,2083,2203,2211,2212,2213,2220,2232,2233) and c1.rnk=ca1.rnk and c1.rnk=c.rnk) kred
 from accounts a,cust_acc ca,customer c
 where a.acc=ca.acc and a.nls like :Param2 and ca.rnk=c.rnk
group by  a.nls,
    c.rnk,
    c.nmk,
    :Param0,
    :Param1
order by c.rnk';
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
