prompt ===================================== 
prompt == Перерах. коштів на сплату енергоощад. товарів КП ФО
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
   l_zpr.name := 'Перерах. коштів на сплату енергоощад. товарів КП ФО';
   l_zpr.pkey := '\BRS\SBR\DPT\190';

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
    l_zpr.name         := 'Перерах. коштів на сплату енергоощад. товарів КП ФО';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate1=''Дата з(DD.MM.YYYY) :'',:zDate2=''Дата по(DD.MM.YYYY) :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select a.branch, x.cc_id as N_dog_KP, x.sdate as DAT_DOG_KP
     , a.nbs||a.ob22 as prod 
     , o.ref, o.tt, o.fdat, p.kv, o.dk, o.s/100 as s, p.nazn, p.id_a, p.nam_a, p.mfoa, p.nlsa, p.id_b, p.nam_b, p.mfob, p.nlsb
from oper p, opldok o, accounts a, (select n.acc, d.cc_id, d.sdate from cc_deal d, nd_acc n where d.nd=n.nd and d.vidd in (11,12,13)) x  
where p.ref=o.ref 
  and a.acc=o.acc
  and a.acc=x.acc
  and a.nbs||a.ob22 in (''220346'', ''220347'', ''220348'', ''220372'', ''220373'', ''220374'')
  and o.fdat>=to_date(:zDate1,''dd.mm.yyyy'') and o.fdat<=to_date(:zDate2,''dd.mm.yyyy'') 
  and o.dk=0
  and o.sos=5
--  and x.cc_id in (''1443'',''1685'',''1905'',''2929'')
  and substr(p.nlsb,1,4) not in  (''3739'',''2203'')
order by o.fdat, a.branch, x.cc_id';
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
