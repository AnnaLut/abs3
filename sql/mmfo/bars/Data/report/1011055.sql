prompt ===================================== 
prompt == GAAP Активы, резервы, гарантии, выданные гарантии
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
   l_zpr.name := 'GAAP Активы, резервы, гарантии, выданные гарантии';
   l_zpr.pkey := '\BRS\PET\CCK\20';

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
    l_zpr.name         := 'GAAP Активы, резервы, гарантии, выданные гарантии';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':dat1=''Звiт на дату 01/мм/рррр''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select to_char(o.fdat,''DD/MM/YYYY'') "Дата_отчета" ,o.nls "Лиц_счет",o.kv  "Вал_счета",o.bv "Бал_стоимость" ,o.bvq "Эквивалент_БС" , o.nls_rez "Счет_резерва",
           o.kv_rez "Вал_резерва",
           abs(o.rez) "Резерв_в_ном",
           abs(o.rezq) "Резерв_в_экв",
           o. Ir_rez "Коефициент", 
           o.nls_p  "Счет_поруч",
           o.kv_p   "Вал_поруч", 
           abs(fost(o.acc_p,to_date(:dat1,''dd-mm-yyyy'')-1)/100)  "Сумма_поруч" ,  
           abs(fostq(o.acc_p,to_date(:dat1,''dd-mm-yyyy'')-1)/100) "Экивал_поруч",
            null "Счет_9602",
            null "Вал_9602",
            null "Ост_9602",
            null "Экв_9602",
            null "Счет_гар",
            null "Вал_гар",
            null "Сумма_гар",
            null "Экивал_гар"
            from
(
select distinct r.fdat ,r.nls,r.kv ,r.bv,r.bvq, r.nls_rez ,
           r.kv kv_rez ,
           r.rez ,
           r.rezq ,
           round(r.rez*100/r.bv,2) Ir_rez, 
--           (select p.acc  from cc_accp p, accounts ap   where ap.acc=p.acc and   P.ACCS=r.acc and rownum=1 and nvl(fost(p.acc,to_date(:dat1,''dd-mm-yyyy'')-1),0)!=0 
  --         and (ap.dazs is null or ap.dazs<to_date(:dat1,''dd-mm-yyyy'')) and ap.nbs  in (''9031'')
           (select nls from accounts where acc=pa.acc_p) nls_p,
           (select kv from accounts where acc=pa.acc_p)   kv_p,
            pa.acc_p,
           --null acc_m,
            null nls_m,
            null kv_m,
            null ostf_m,
            null ostfq_m,
            null nls_g,
            null kv_g,
            null ostf_g,
            null ostfq_g,
            r.acc                 
  from nbu23_rez r, 
  (
  select k2.acc_s, min(k2.acc_p) acc_p  from (  
   select k1.acc_p, ( select  min(a2.acc)  from  cc_accp p2, accounts a2 where p2.acc=k1.acc_p and p2.accs=a2.acc and a2.nbs=k1.ord) acc_s   from 
(
select p.acc acc_p, min(sa.nbs)  --sa.acc  acc_s ,--   decode (trim(sa.tip),''SS'',1,''SP'',2,''SL'',3,''SN'',4,''SPN'',5,''SK0'',6,''SK9'',7,''CR9'',8,9) 
 ord  from cc_accp p, accounts ap, accounts sa   where ap.acc=p.acc and  P.ACCS=sa.acc  and nvl(fost(p.acc,to_date(:dat1,''dd-mm-yyyy'')-1),0)!=0 
           and (ap.dazs is null or ap.dazs<to_date(:dat1,''dd-mm-yyyy'')) and ap.nbs  in (''9031'')
--order by 1,3,2
group by p.acc
) k1
) k2
group by k2.acc_s
  ) pa 
  where r.fdat= to_date(:dat1,''dd-mm-yyyy'') --and r.rez<>0
      and substr(r.nls,1,4) not in (''9000'',''9129'')
      and  r.acc=pa.acc_s(+)
   ) o    
  union 
  select  to_char(to_date(:dat1,''dd-mm-yyyy''),''DD/MM/YYYY''),  null, null, null, null, null, 
           null, -- kv_rez
           null, -- rez
           null, -- rezq
           null, -- Ir_rez
           az.nls, -- nls_p
           az.kv, -- kv_p
           abs(fost(az.acc,to_date(:dat1,''dd-mm-yyyy'')-1)/100), -- ostf_p  
           abs(fostq(az.acc,to_date(:dat1,''dd-mm-yyyy'')-1)/100), -- ostfq_p
           null  , -- nls_m,
           null, -- kv_m,
           null , -- ostf_m,
           null, -- ostfq_m,
           null, -- nls_g,
           null, -- kv_g,
           null, -- ostf_g,
           null -- ostfq_g
     from accounts az where az.nbs in (''9031'') and (az.dazs is null or az.dazs<to_date(:dat1,''dd-mm-yyyy'')) and nvl(fost(az.acc,to_date(:dat1,''dd-mm-yyyy'')-1),0)!=0
     and az.acc not in  
       (
     select pa2.acc_p from 
      (
  select k2.acc_s, min(k2.acc_p) acc_p  from (  
   select k1.acc_p, ( select  min(a2.acc)  from  cc_accp p2, accounts a2 where p2.acc=k1.acc_p and p2.accs=a2.acc and a2.nbs=k1.ord) acc_s   from 
(
select p.acc acc_p, min(sa.nbs)  --sa.acc  acc_s ,--   decode (trim(sa.tip),''SS'',1,''SP'',2,''SL'',3,''SN'',4,''SPN'',5,''SK0'',6,''SK9'',7,''CR9'',8,9) 
 ord  from cc_accp p, accounts ap, accounts sa   where ap.acc=p.acc and  P.ACCS=sa.acc  and nvl(fost(p.acc,to_date(:dat1,''dd-mm-yyyy'')-1),0)!=0 
           and (ap.dazs is null or ap.dazs<to_date(:dat1,''dd-mm-yyyy'')) and ap.nbs  in (''9031'')
--order by 1,3,2
group by p.acc
) k1
) k2
group by k2.acc_s
  ) pa2
     )
  union 
  select  to_char(to_date(:dat1,''dd-mm-yyyy''),''dd/mm/yyyy''),  null, null, null, null, null, 
           null, -- kv_rez
           null, -- rez
           null, -- rezq
           null, -- Ir_rez
           null, -- nls_p
           null, -- kv_p
           null, -- ostf_p  
           null, -- ostfq_p
           am.nls , -- nls_m,
           am.kv, -- kv_m,
           abs(fost(am.acc,to_date(:dat1,''dd-mm-yyyy'')-1)/100), -- ostf_m,
           abs(fostq(am.acc,to_date(:dat1,''dd-mm-yyyy'')-1)/100), -- ostfq_m,
           null, -- nls_g,
           null, -- kv_g,
           null, -- ostf_g,
           null -- ostfq_g
     from accounts am where am.nbs in (''9602'',''9603'') and (am.dazs is null or am.dazs<to_date(:dat1,''dd-mm-yyyy'')) and nvl(fost(am.acc,to_date(:dat1,''dd-mm-yyyy'')-1),0)!=0
     union 
  select  to_char(to_date(:dat1,''dd-mm-yyyy''),''dd/mm/yyyy''),  null, null, null, null, null, 
           null, -- kv_rez
           null, -- rez
           null, -- rezq
           null, -- Ir_rez
           null, -- nls_p
           null, -- kv_p
           null, -- ostf_p  
           null, -- ostfq_p
           null , -- nls_m,
           null, -- kv_m,
           null, -- ostf_m,
           null, -- ostfq_m,
           ag.nls, -- nls_g,
           ag.kv, -- kv_g,
           abs(fost(ag.acc,to_date(:dat1,''dd-mm-yyyy'')-1)/100), -- ostf_g,
           abs(fostq(ag.acc,to_date(:dat1,''dd-mm-yyyy'')-1)/100) -- ostfq_g
     from accounts ag where ag.nbs in (''9000'',''9003'',''9122'') and (ag.dazs is null or ag.dazs<to_date(:dat1,''dd-mm-yyyy'')) and nvl(fost(ag.acc,to_date(:dat1,''dd-mm-yyyy'')-1),0)!=0';
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
