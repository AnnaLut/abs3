prompt ===================================== 
prompt == Контроль операцій переоформлення Депозитів
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
   l_zpr.name := 'Контроль операцій переоформлення Депозитів';
   l_zpr.pkey := '\BRS\SBR\DPT\301';

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
    l_zpr.name         := 'Контроль операцій переоформлення Депозитів';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':sFdat1=''Дата з (DD.MM.YYYY) :'',:sFdat2=''Дата по (DD.MM.YYYY) :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select q1.rnk,q1.nls as nls_old,q1.kv as kv_old,q2.nls as nls_new,q2.kv as kv_new
from (
Select D1.DEPOSIT_ID,D1.RNK,d1.kv,d1.limit,a2.acc,O1.DK,O1.FDAT,O1.SQ,a1.nls
from dpt_deposit d1 inner join dpt_payments d3 on D1.DEPOSIT_ID=d3.dpt_id
                    inner join accounts a1 on D1.ACC=A1.ACC and a1.nbs in (''2630'')
                    inner join opldok o1 on D3.REF=O1.REF and D1.LIMIT=O1.SQ and o1.tt like ''D%''
                    inner join accounts a2 on a2.acc=O1.ACC and a2.nbs in (''1002'')
where D1.DATZ between :sFdat1 and :sFdat2
   and D1.DEPOSIT_ID not in (select dpt_id d2 from dpt_depositw d2 where D2.TAG=''NCASH'' and D2.VALUE=''1'')) q1 inner join     
  (select O1.*,a1.nls,a1.rnk,A1.KV,a1.branch
   from opldok o1 inner join accounts a1 on o1.acc=a1.acc  and a1.nbs  in (''2630'') and o1.tt like ''D%''
  
  ) q2 on q1.fdat=q2.fdat and  q1.sq=q2.sq and Q2.DK=0 and q1.rnk=q2.rnk';
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
