prompt ===================================== 
prompt == БПК ЗПР (за період відкриття 2625) наявні продукти
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
   l_zpr.name := 'БПК ЗПР (за період відкриття 2625) наявні продукти';
   l_zpr.pkey := '\BRS\SBR\DPT\286';

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
    l_zpr.name         := 'БПК ЗПР (за період відкриття 2625) наявні продукти';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zdate1=''Дата з(DD.MM.YYYY) :'',:zdate2=''Дата по(DD.MM.YYYY) :'',:BRANCH=''Відділення: (пусто -всі) '',:OKPO=''ЄДРПОУ ЗП: (пусто -всі) ''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select x1.branch, x1.ZP_ID, x1.ZP_NAME, x1.ZP_OKPO, x1.nls, x1.kv, x1.daos, x1.rnk, x1.nmk, x1.okpo, x1.v, x1.sex, x1.grp_prod  --, x2.doz
     , nvl(x2.N_PREM,0) as N_PREM, nvl(x2.N_PENS,0) as N_PENS, nvl(x2.N_SOCL,0) as N_SOCL
     , nvl(x3.N_KOTL,0) as N_KOTL, nvl(x3.N_ENRG,0) as N_ENRG, nvl(x3.N_IPOT,0) as N_IPOT, nvl(x3.N_AVTO,0) as N_AVTO, nvl(x3.N_DEPO,0) as N_DEPO, nvl(x3.N_KRLN,0) as N_KRLN
     , case when nvl(z2.SZ2,0) <> 0 then ''так'' else ''ні'' end as z_30
     , case when nvl(z3.SZ2,0) <> 0 then ''так'' else ''ні'' end as z_90
from (
select a.acc
     , a.branch
     , bp.id as ZP_ID, bp.name as ZP_NAME, bp.okpo as ZP_OKPO
     , a.nls, a.kv, a.daos
     , c.rnk, c.nmk, c.okpo
     , case when p.bday is NULL then NULL else trunc((sysdate-p.bday)/(365.25)+0.001) end as v
     , decode(p.sex,0,''невідома'',1,''чоловіча'',2,''жіноча'') as sex
     , wg.name as grp_prod
from accounts a left join w4_acc w   on a.acc=w.acc_pk
                left join customer c on a.rnk=c.rnk
                left join person p   on c.rnk=p.rnk
                left join w4_card wc on wc.CODE=w.CARD_CODE
                left join w4_product wp on wp.code=wc.product_code
                left join w4_product_groups wg on wg.code=wp.GRP_CODE
                LEFT JOIN accountsw  aw  ON (a.acc = aw.acc AND aw.tag = ''PK_PRCT'')
                LEFT JOIN bpk_proect bp  ON RTRIM (LTRIM (aw.VALUE)) = RTRIM (LTRIM (TO_CHAR (bp.ID)))
                
where a.nbs=''2625'' 
  and (a.dazs is NULL or a.dazs>nvl(to_date(:zdate1,''dd.mm.yyyy''),sysdate))
  and a.daos between nvl(to_date(:zdate1,''dd.mm.yyyy''),sysdate) and nvl(to_date(:zdate2,''dd.mm.yyyy''),sysdate)
  and c.k050=''000'' and c.CUSTTYPE=3
  and w.acc_pk is not NULL
  and bp.OKPO is not NULL 
  and instr(a.branch, case when :BRANCH is NULL or length(ltrim(rtrim(:BRANCH)))=0 then a.branch else :BRANCH end) > 0 
  and instr(bp.okpo, case when :OKPO is NULL or length(ltrim(rtrim(:OKPO)))=0 then bp.okpo else :OKPO end) > 0
) x1 left join
(
select ak.rnk
     , sum(case when wgk.code=''PREMIUM'' then 1 else 0 end) N_PREM
     , sum(case when wgk.code=''PENSION'' then 1 else 0 end) N_PENS
     , sum(case when wgk.code=''SOCIAL''  then 1 else 0 end) N_SOCL
from accounts ak left join w4_acc wk   on ak.acc=wk.acc_pk
                 left join w4_card wck on wck.CODE=wk.CARD_CODE
                 left join w4_product wpk on wpk.code=wck.product_code
                 left join w4_product_groups wgk on wgk.code=wpk.GRP_CODE
where ak.nbs=''2625'' 
  and (ak.dazs is NULL or ak.dazs>nvl(to_date(:zdate1,''dd.mm.yyyy''),sysdate))
  and ak.daos <= nvl(to_date(:zdate2,''dd.mm.yyyy''),sysdate)
  and wk.acc_pk is not NULL
group by ak.rnk  
) x2 on x1.rnk=x2.rnk
left join 
(
select an.rnk
     , sum(case when an.nbs||an.ob22 in (''220373'',''220347'') then 1 else 0 end) N_KOTL
     , sum(case when an.nbs||an.ob22 in (''220374'',''220348'') then 1 else 0 end) N_ENRG
     , sum(case when an.nbs||an.ob22 in (''220308'',''223301'',''223302'',''223303'',''223304'',''223305'',''223306''
                                        ,''223307'',''223308'',''223309'',''223310'',''223311'',''223312'',''223313''
                                        ,''223314'',''223315'',''223316'',''223317'',''223318'',''223319'',''223320'') then 1 else 0 end) N_IPOT
     , sum(case when an.nbs||an.ob22 in (''220361'',''220362'',''220363'',''220366''
                                        ,''220368'',''220369'',''220309'',''220313'',''220314'',''220326''
                                        ,''220331'',''220334'',''220335'',''220351'') then 1 else 0 end) N_AVTO
     , sum(case when an.nbs in (''2630'') then 1 else 0 end) N_DEPO 
     , sum(case when an.nbs in (''9129'') then 1 else 0 end) N_KRLN                                   
from accounts an 
where (an.nbs||an.ob22 in (''220373'',''220347'',''220374'',''220348'',''220308'',''223301'',''223302'',''223303'',''223304'',''223305'',
                          ''223306'',''223307'',''223308'',''223309'',''223310'',''223311'',''223312'',''223313'',''223314'',''223315'',
                          ''223316'',''223317'',''223318'',''223319'',''223320'',''';
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
