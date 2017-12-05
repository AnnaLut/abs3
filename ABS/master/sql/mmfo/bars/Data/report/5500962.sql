prompt ===================================== 
prompt == Доходи РКО
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
   l_zpr.name := 'Доходи РКО';
   l_zpr.pkey := '\BRS\SBR\DPT\187';

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
    l_zpr.name         := 'Доходи РКО';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':BRANCH=''Відділення'',:sFdat1=''Дата з (DD.MM.YYYY) :'',:sFdat2=''Дата по (DD.MM.YYYY) :'',:BUSSL=''Сегм.кл.: (пусто, 0 -всі;1-ДКБ;2-ММСБ;3-б.о.)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME|WHERE length(branch)<=22 order by 1''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select s1.RNK,s1.branch,s1.nls,s1.daos dat_open,s1.kv,s1.nms,s1.sum_kom
      ,s2.sum_ob_k
      ,case when i.acc is null then ''-'' else ''+'' end KB
      ,cw.value as BUSSL
from (
select a1.rnk,a1.branch,a1.nms,a1.nls,a1.kv,sum(o1.sq)/100 sum_kom,a1.acc,a1.daos
from opldok o1 
  inner join opldok o2 on o1.ref=o2.ref and o1.tt=o2.tt
  inner join accounts a1 on o1.acc=a1.acc
  inner join accounts a2 on o2.acc=a2.acc
  inner join customer c on a1.RNK=c.RNK
where o1.fdat between :sFdat1 and :sFdat2 
  and o2.fdat between :sFdat1 and :sFdat2 
  and ((c.custtype=3 and c.k050=''910'') or c.custtype=2)
  and a1.nbs in (''2600'',''2650'',''3570'')
  and ((a2.nbs in (''6514'') and a2.OB22 in (''01'',''02'',''04'',''05'',''06'',''24'',''28'',''35'',''36'',''37'',''38'',''40'',''42'',''44'',''46''))
    or (a2.nbs in (''6516''))
    or (a2.nbs in (''6519'') and a2.OB22 in (''02'',''03'',''06'',''08'',''12'',''13'',''20''))
    or (a2.NBS in (''6510'') and a2.OB22 in (''01'',''06'',''29'',''42'',''43'',''46'',''49'',''88'',''93'',''97'',''B1'',''B2'',''E3'')))
  and a1.branch  like ''%''||:BRANCH||''%''
group by a1.acc,a1.nls,a1.rnk,a1.branch,a1.nms,a1.kv,a1.daos ) s1 inner join
(select a1.acc,sum(o1.sq)/100 sum_ob_k
from opldok o1 
  inner join accounts a1 on o1.acc=a1.acc
where o1.fdat between :sFdat1 and :sFdat2 
  and a1.nbs in (''2600'',''2650'',''3570'')
  and a1.branch like ''%''||:BRANCH||''%''
  and o1.dk=1
group by a1.acc,a1.nls,a1.rnk,a1.branch,a1.nms) s2 on s1.acc=s2.acc
 left join barsaq.ibank_acc i on s1.acc=i.acc
 left join customerw cw on s1.rnk=cw.rnk and cw.tag=''BUSSL''
where nvl(cw.value,''0'') like (case when nvl(:BUSSL,''0'')=''0'' then ''%''
                                   when nvl(:BUSSL,''0'')=''1'' then ''ДКБ''
                                   when nvl(:BUSSL,''0'')=''2'' then ''ММСБ''
                                   when nvl(:BUSSL,''0'')=''3'' then ''0''
                                   else ''%'' end
                             )
order by s1.RNK,s1.nls';
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
