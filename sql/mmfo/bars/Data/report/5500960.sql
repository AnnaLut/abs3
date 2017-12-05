prompt ===================================== 
prompt == Кіл-ть рах. ФО 2620(5),2630(5) в розр.ТВБВ І типу та прод.
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
   l_zpr.name := 'Кіл-ть рах. ФО 2620(5),2630(5) в розр.ТВБВ І типу та прод.';
   l_zpr.pkey := '\BRS\SBR\DPT\192';

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
    l_zpr.name         := 'Кіл-ть рах. ФО 2620(5),2630(5) в розр.ТВБВ І типу та прод.';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zdate=''Станом на (DD.MM.YYYY) :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select substr(a.branch,1,15) as branch
     , ''на дату: ''||:zdate as zdate
     , sum(case when a.nbs=''2620'' and a.kv=''980'' then 1 else 0 end) as FizPot_NV
     , sum(case when a.nbs=''2620'' and a.kv=''980'' and nvl(a.ob22,''0'') in (''08'',''09'',''11'',''12'') then 1 else 0 end) as FizPot_NV_N
     , sum(case when a.nbs=''2620'' and a.kv=''980'' and nvl(a.ob22,''0'') in (''20'') then 1 else 0 end) as Pens_20
     , sum(case when a.nbs=''2620'' and a.kv=''980'' and nvl(a.ob22,''0'') in (''21'') then 1 else 0 end) as Pens_21
     , sum(case when a.nbs=''2620'' and a.kv<>''980'' then 1 else 0 end) as FizPot_IV
     , sum(case when a.nbs=''2625'' and a.kv= ''980'' and (w.acc_pk is not NULL or b.acc_pk is not NULL) then 1 else 0 end) as Kart_NV
     , sum(case when a.nbs=''2625'' and a.kv<>''980'' and (w.acc_pk is not NULL or b.acc_pk is not NULL) then 1 else 0 end) as Kart_IV
     , sum(case when a.nbs in (''2630'') and a.kv=''980'' then 1 else 0 end) as FizSTR_NV
     , sum(case when a.nbs in (''2630'') and a.kv=''980'' and nvl(a.ob22,''0'') in (''11'',''12'',''13'',''14'',''B6'',''B7'',''B8'',''B9'') then 1 else 0 end) as FizSTR_NV_N
     , sum(case when a.nbs in (''2630'') and a.kv<>''980'' then 1 else 0 end) as FizSTR_IV 
     , sum(case when a.nbs=''2630'' and a.kv= ''980'' then 1 else 0 end) as FIZKor_NV
     , sum(case when a.nbs=''2630'' and a.kv<>''980'' then 1 else 0 end) as FIZKor_IV    
from accounts a left join w4_acc   w on a.acc=w.acc_pk
                left join bpk_acc  b on a.acc=b.acc_pk
                left join customer c on a.rnk=c.rnk
where (a.dazs is NULL or a.dazs > to_date(:zdate,''dd.mm.yyyy''))
  and a.daos <= to_date(:zdate,''dd.mm.yyyy'')
  and a.nbs in (''2620'',''2625'',''2630'') 
  and c.K050 in (''000'') and c.CUSTTYPE=3
--  and nvl(fost(a.acc,to_date(:zdate,''dd.mm.yyyy'')),0)<>0
group by substr(a.branch,1,15)
order by substr(a.branch,1,15)';
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
