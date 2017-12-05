prompt ===================================== 
prompt == Вiдомість залишкiв по рахункам 2620,2625,2630
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
   l_zpr.name := 'Вiдомість залишкiв по рахункам 2620,2625,2630';
   l_zpr.pkey := '\SBR\BRS\DPT\402';

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
    l_zpr.name         := 'Вiдомість залишкiв по рахункам 2620,2625,2630';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'DPT_402.qrp ';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'Select a.branch, b.NAME,
 sum( decode (a.nbs,''2620'', decode (a.kv,0,a.OST,0), 0) ) S2620N,
 sum( decode (a.nbs,''2620'', decode (a.kv,1,a.OST,0), 0) ) S2620I,
 sum( decode (a.nbs,''2625'', decode (a.kv,0,a.OST,0), 0) ) S2625N,
 sum( decode (a.nbs,''2625'', decode (a.kv,1,a.OST,0), 0) ) S2625I,
 sum( decode (a.nbs,''2630'', decode (a.kv,0,a.OST,0), 0) ) S2630N,
 sum( decode (a.nbs,''2630'', decode (a.kv,1,a.OST,0), 0) ) S2630I            
from 
( select branch, nbs, decode (kv,980,0,1) KV,  
         sum(fostQ(acc, to_date(:sFdat1,''dd.mm.yyyy'') ) ) OST
  from v_gl
  where nbs in (''2620'',''2625'',''2630'') 
  group by branch, nbs, decode (kv,980,0,1) 
  ) a, BRANCH b
where a.branch=b.branch 
group by a.branch , b.NAME 
order by a.branch
   
  
  ';
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
