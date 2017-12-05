prompt ===================================== 
prompt == Перерах. коштів на власні рах. в інш. Банки (ЮО)_Без_2603
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
   l_zpr.name := 'Перерах. коштів на власні рах. в інш. Банки (ЮО)_Без_2603';
   l_zpr.pkey := '\BRS\SBR\DPT\183';

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
    l_zpr.name         := 'Перерах. коштів на власні рах. в інш. Банки (ЮО)_Без_2603';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate1=''Дата з(DD.MM.YYYY) :'',:zDate2=''Дата по(DD.MM.YYYY) :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select ''з ''||:zDate1||'' по ''||:zDate2 as Period
     , a.branch, a.nls, a.kv
     , o.ref, o.pdat, o.odat, o.dk, o.s/100 as sum_op, o.kv as kv_op, o.nazn
     , o.nam_a, o.nlsa, o.id_a, o.mfoa, (select b.nb from banks$base b where b.mfo=o.mfoa) as bank_a  
     , o.nam_b, o.nlsb, o.id_b, o.mfob, (select b.nb from banks$base b where b.mfo=o.mfob) as bank_b
     , o.branch as branch_op
     , c.nmk, c.okpo, c.rnk   
from opldok op, oper o, accounts a, customer c
where a.rnk=c.rnk and op.ref=o.ref and a.acc=op.acc 
  and op.dk=0
  and op.sos=5
  and op.fdat between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'')
  and a.nbs in (''2512'',''2513'',''2520'',''2523'',''2526'',''2530'',''2531'',''2541'',''2542'',''2544'',''2545'',''2552'',''2553'',''2554'',''2555'',''2560'',''2561'',''2562'',''2565'',''2570'',''2571'',''2572'',''2600'',''2601'',''2602'',''2604'',''2605'',''2606'',''2610'',''2640'',''2641'',''2642'',''2643'',''2650'',''2651'',''2655'')
  and ((o.dk=1 and o.mfoa=''322669'' and mfob<>''322669'' and substr(o.nlsb,1,1)<>''3'') or (o.dk=0 and o.mfob=''322669'' and mfoa<>''322669'' and substr(o.nlsa,1,1)<>''3'')) 
  and o.id_a=o.id_b';
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
