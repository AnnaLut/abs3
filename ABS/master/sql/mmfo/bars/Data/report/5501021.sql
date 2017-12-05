prompt ===================================== 
prompt == Звіт нарахування пені (моделювання розрахунку)
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
   l_zpr.name := 'Звіт нарахування пені (моделювання розрахунку)';
   l_zpr.pkey := '\BRS\SBR\DPT\314';

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
    l_zpr.name         := 'Звіт нарахування пені (моделювання розрахунку)';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate1=''Дата з (DD.MM.YYYY) :'',:zDate2=''Дата по (DD.MM.YYYY) :'',:nd=''Реф.дог.''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select x.dat, x.nd, x.nbs, x.nls, x.kv, x.nls_ost, x.ir, x.br, x.ir_br, x.bdat, x.stp_dat, x.prc
     , round((x.nls_ost/(add_months(trunc(x.dat, ''yyyy''),12) - trunc(x.dat, ''yyyy'')))/100*x.prc,4) as prc_nar
from
(
select ac.caldt_date as dat, d.nd, a.acc as acc_nls, a.nbs, a.nls, a.kv, abs(fost(a.acc, ac.caldt_date)/100) as nls_ost
     , prc.acc, prc.ir, prc.br, getbrat(ac.caldt_date,prc.br,a.kv,1) as ir_br, prc.bdat
     , ia.stp_dat
     , case when ia.stp_dat is not NULL and nvl(ia.stp_dat,ac.caldt_date) < ac.caldt_date then 0
            else (case when prc.br is null then prc.ir else getbrat(ac.caldt_date,prc.br,a.kv,1)*nvl(prc.ir,1) end)
            end as prc
from cc_deal d, nd_acc n, accounts a, ACCM_CALENDAR ac
   , (select i.acc, i.ir, i.br, i.bdat from int_ratn i where i.id=2) prc
   , int_accn ia
where d.nd=n.nd and n.acc=a.acc
  and a.nbs in (''2203'',''2233'',''2208'',''2238'')
  and a.tip <> ''SNA''
  and ac.caldt_date between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'')
  and a.acc=prc.acc
  and prc.bdat=(select max(bdat) from int_ratn where id=2 and acc=a.acc and bdat<=ac.caldt_date)
  and ia.acc=prc.acc
  and ia.id=2
  and a.daos<=to_date(:zDate2,''dd.mm.yyyy'')
  and (a.dazs is NULL or a.dazs>=to_date(:zDate1,''dd.mm.yyyy''))
  and d.nd=:nd --205507
order by a.acc, ac.caldt_date
) x';
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
