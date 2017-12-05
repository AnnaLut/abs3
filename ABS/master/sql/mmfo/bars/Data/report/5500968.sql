prompt ===================================== 
prompt == Обороти (Дк-Кт), СДЗ гр.25-26 за період (ЮО)
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
   l_zpr.name := 'Обороти (Дк-Кт), СДЗ гр.25-26 за період (ЮО)';
   l_zpr.pkey := '\BRS\SBR\DPT\180';

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
    l_zpr.name         := 'Обороти (Дк-Кт), СДЗ гр.25-26 за період (ЮО)';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate1=''Дата з(DD.MM.YYYY) :'',:zDate31=''Дата по(DD.MM.YYYY) :'',:nbs=''Бал.рахунки (пусто - всі, ВВВВ,ВВВВ...- окремі):'',:kv=''Валюта (0 або пусто - всі, 1 - всі крім UAH, ККК - код вал.)
 :'',:indcode=''Код ЗКПО :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select to_char(greatest(to_date(:zDate1,''dd.mm.yyyy''),a.daos),''dd.mm.yyyy'')||''-''||to_char(least(to_date(:zDate31,''dd.mm.yyyy''),nvl(a.dazs-1,to_date(:zDate31,''dd.mm.yyyy''))),''dd.mm.yyyy'') as Period
     , a.branch
     , c.nmk, c.okpo, c.rnk
     , a.nls, a.nbs, a.kv 
     , a.daos, a.dazs
     , fdos(a.acc,to_date(:zDate1,''dd.mm.yyyy''),to_date(:zDate31,''dd.mm.yyyy''))/100 as DOS
     , fkos(a.acc,to_date(:zDate1,''dd.mm.yyyy''),to_date(:zDate31,''dd.mm.yyyy''))/100 as KOS
     , fdosn(a.kv, a.acc,to_date(:zDate1,''dd.mm.yyyy''),to_date(:zDate31,''dd.mm.yyyy''))/100 as DOS_Q
     , fkosn(a.kv, a.acc,to_date(:zDate1,''dd.mm.yyyy''),to_date(:zDate31,''dd.mm.yyyy''))/100 as KOS_Q
     , fost(a.acc, to_date(:zDate31,''dd.mm.yyyy''))/100 as OST
     , nvl(fostq(a.acc, to_date(:zDate31,''dd.mm.yyyy'')),0)/100 as OST_Q
     , nvl(round((select sum(case when fost(a2.acc,c.caldt_date)<0 then 0 else fost(a2.acc,c.caldt_date)/100 end)
      /(least(to_date(:zDate31,''dd.mm.yyyy''),nvl(a.dazs-1,to_date(:zDate31,''dd.mm.yyyy'')))-greatest(to_date(:zDate1,''dd.mm.yyyy''),a.daos)+1) as ost  --, c.caldt_date
       from ACCM_CALENDAR c, accounts a2 
       where a2.acc =a.acc 
         and c.caldt_date between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate31,''dd.mm.yyyy'')
       group by a2.acc),2),0) as SD_OST
     , nvl(round((select sum(case when fost(a2.acc,c.caldt_date)<0 then 0 else fost(a2.acc,c.caldt_date)
                                                                   *nvl((select rate_o/bsum as kf 
                                                                         from cur_rates$base 
                                                                         where kv=a2.kv and branch=substr(a2.branch,1,15)
                                                                           and vdate=c.caldt_date
                                                                         ),1)
                                                                   /100 
                 end)
      /(least(to_date(:zDate31,''dd.mm.yyyy''),nvl(a.dazs-1,to_date(:zDate31,''dd.mm.yyyy'')))-greatest(to_date(:zDate1,''dd.mm.yyyy''),a.daos)+1) as ostq  --, c.caldt_date
       from ACCM_CALENDAR c, accounts a2 
       where a2.acc =a.acc 
         and c.caldt_date between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate31,''dd.mm.yyyy'')
       group by a2.acc),2),0) as SD_OST_Q 
     , case when c.rnk in (select rnk from MV_BARSAQ_IBANK_RNK) and c.rnk in (select rnk from e_deal$base) then ''так'' else ''ні'' end as KB_INT
     , case when c.SAB is not null and c.rnk in (select rnk from e_deal$base) then ''так'' else ''ні'' end as KB_OFF    
     , ix.ir as IR_ID1, aw.value as TARIF_PCK
     , k.kod_cli, k.name_cli            
from accounts a left join customer c on a.rnk=c.rnk
                left join rnkp_kod r on r.rnk=a.rnk
                left join kod_cli k  on k.kod_cli=r.kodk
                left join (select nvl(to_char(i.ir),
                                          (select nvl(to_char(bn.rate),''код: ''||to_char(ba.br_id)||'' тип:''||to_char(ba.br_type)||'' назва: ''||ba.name) as rate
                                          from brates ba left join br_normal_edit bn on ba.br_id=bn.BR_ID
                                          where ba.br_id=i.br and bn.kv=ai.kv)
                                    ) as ir, i.acc, ai.kv 
                           from int_ratn i left join accounts ai on i.acc=ai.acc 
                           where i.id=1 and bdat=(select max(i2.bdat) 
                                                 from int_ratn i2 
                                                 where i2.id=1 and i.acc=i2.acc and i2.bdat<=to_date(:zDate31,''dd.mm.yyyy'') 
                                                 group by i2.acc)
                          ) ix on a.acc=ix.acc and a.kv=ix.kv
                left join accountsw aw on a.acc=aw.acc and aw.tag=''SHTAR''
where a.nbs in (''2512'',''2513'',''2520'',''2523'',''2526'',''2530'',''2531'',''2541'',''2542'',''2544'',''2545'',''2552'',''2553'',''2554'',''2555'',''2560';
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
