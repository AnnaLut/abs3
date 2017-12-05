prompt ===================================== 
prompt == Платіжний календ. по кредитах. Додаток 6.
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
   l_zpr.name := 'Платіжний календ. по кредитах. Додаток 6.';
   l_zpr.pkey := '\OLD\SBR\MKD\5';

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
    l_zpr.name         := 'Платіжний календ. по кредитах. Додаток 6.';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':DAT1=''На дату'',:Param=''Сорт:1-Над,2-Пов,3-Рах''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select  row_number() over(order by kv2,nbs2,decode(nvl(:Param,1),1,to_char(daos,''yyyymmdd''),2,to_char(mdate,''yyyymmdd''),3,nls) ) rn,
        daos "Дата_надання",
        mdate "Дата_повернення", 
        (case when substr(nbs2,5,1)=''-'' then null else kv2 end) "Валюта",
        (case when substr(nbs2,5,1)=''-'' then ''Разом (''||kv2||'')''||substr(nbs2,1,4) else nbs2 end) "Бал_рахунок",
        nls "Рахунок" ,nmk "Назва_позичальника",ostc "Сума",ostq "Сума_еквівалент"     
from
(
   select daos,
          mdate,
          kv kv2,
          decode (mdate,null,nbs||''-'',nbs) nbs2,
          nmk,nls,sum(ostc)ostc ,sum(ostq)ostq 
      from
   (    
    select nvl((select min(fdat) from saldoa where (dos!=0 or kos!=0) and acc=a.acc and fdat<to_date(:DAT1,''dd.mm.yyyy'')),a.daos) daos,
           mdate, kv, nls,nbs,  nmk,
           fost_h(a.acc,to_date(:DAT1,''dd.mm.yyyy'')) ostc,
           gl.P_ICURVAL(kv,fost_h(a.acc,to_date(:DAT1,''dd.mm.yyyy'')),to_date(:DAT1,''dd.mm.yyyy'')) ostq
      from accounts a,customer r
     where a.nbs in (2010,2020,2030,2063,2071,2083,
                     2103,2113,2123,2133,
                     2203,2211,2212,2213,2215,2220,2232,2233,2600,2605,
                     2620,2625,2650,2655)
           and (a.dazs is null or a.dazs>=to_date(:DAT1,''dd.mm.yyyy'') )
           and a.mdate<to_date(:DAT1,''dd.mm.yyyy'')+32 and a.mdate>=to_date(:DAT1,''dd.mm.yyyy'')
           and a.rnk=r.rnk
      )   
      where ostc <0  
    group by grouping sets ( (kv,nbs,daos,mdate,nmk,nls),
    (KV,nbs) )        
)  
order by kv2,nbs2,decode(nvl(:Param,1),1,to_char(daos,''yyyymmdd''),2,to_char(mdate,''yyyymmdd''),3,nls)';
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
