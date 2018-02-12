prompt ===================================== 
prompt == БПК (інформація для СК) !зміна коеф! 07.02.2017
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
   l_zpr.name := 'БПК (інформація для СК) !зміна коеф! 07.02.2017';
   l_zpr.pkey := '\BRS\SBR\DPT\260';

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
    l_zpr.name         := 'БПК (інформація для СК) !зміна коеф! 07.02.2017';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate1=''Дата з(DD.MM.YYYY) :''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select x1.*'||nlchr||
                           '     , case'||nlchr||
                           '          when (select count(acc) as N_NLS from accounts'||nlchr||
                           '                 where x1.rnk=rnk'||nlchr||
                           '                  and nbs in (''2625'',''2620'')'||nlchr||
                           '                  and daos<=to_date(:zDate1,''dd.mm.yyyy'')'||nlchr||
                           '                  and (dazs is NULL or dazs >to_date(:zDate1,''dd.mm.yyyy''))'||nlchr||
                           '                 group by rnk)>1'||nlchr||
                           '          then ''так'''||nlchr||
                           '          else ''ні'''||nlchr||
                           '       end as RAH_PR'||nlchr||
                           '     , (to_date(:zDate1,''dd.mm.yyyy'') - nvl(x1.Dat_PR_2207,to_date(:zDate1,''dd.mm.yyyy'')+1) + 1) as Day_PR_2207'||nlchr||
                           '     , (to_date(:zDate1,''dd.mm.yyyy'') - nvl(x1.Dat_PR_2209,to_date(:zDate1,''dd.mm.yyyy'')+1) + 1) as Day_PR_2209'||nlchr||
                           '     , x2.Insur_sum, x2.Insur_pay, x2.Insur_sum7, x2.Insur_pay7, x2.ir,  x2.kfc, x2.d1, x2.d2'||nlchr||
                           'from ('||nlchr||
                           'select :zDate1 as ZV_DAT'||nlchr||
                           '     , bpk.pc     , bpk.nd     , bpk.dat_end as DAT_END_CARD'||nlchr||
                           '     , a.nls as nls_2625'||nlchr||
                           '     , a.kv as  kv_2625'||nlchr||
                           '     , to_char(a.daos,''dd.mm.yyyy'') as date_open_2625'||nlchr||
                           '     , a.lim/100 as lim'||nlchr||
                           '     , bpk.card_code     , a.branch     , c.rnk     , c.nmk     , c.okpo     , p.bday'||nlchr||
                           '     , cww.value as M_WORK'||nlchr||
                           '     , cw.value as MOB_TEL'||nlchr||
                           '     , p.teld as DOM_TEL'||nlchr||
                           '     , p.telw as WORK_TEL'||nlchr||
                           '     , p.cellphone as MOB_DOD_TEL'||nlchr||
                           '     , ca.ZIP as IND'||nlchr||
                           '     , ca.DOMAIN as OBL'||nlchr||
                           '     , ca.REGION as RAION'||nlchr||
                           '     , (select name from ADDRESS_LOCALITY_TYPE where  id=ca.LOCALITY_TYPE) as TYPE_NP'||nlchr||
                           '     , ca.LOCALITY'||nlchr||
                           '     , (select name from ADDRESS_STREET_TYPE where  id=ca.STREET_TYPE) as TYPE_EDI'||nlchr||
                           '     , ca.STREET     , ca.HOME     , ca.HOMEPART     , ca.ROOM     , ca.ADDRESS'||nlchr||
                           '     , ca2.ZIP as F_IND'||nlchr||
                           '     , ca2.DOMAIN as F_OBL'||nlchr||
                           '     , ca2.REGION as F_RAION'||nlchr||
                           '     , (select name from ADDRESS_LOCALITY_TYPE where  id=ca2.LOCALITY_TYPE) as F_TYPE_NP'||nlchr||
                           '     , ca2.LOCALITY as F_LOCALITY'||nlchr||
                           '     , (select name from ADDRESS_STREET_TYPE where  id=ca2.STREET_TYPE) as F_TYPE_EDI'||nlchr||
                           '     , ca2.STREET as F_STREET, ca2.HOME as F_HOME, ca2.HOMEPART as F_HOMEPART, ca2.ROOM as F_ROOM'||nlchr||
                           '     , ca2.ADDRESS as F_ADDRESS'||nlchr||
                           '     , abs(fost(bpk.acc_ovr,to_date(:zDate1,''dd.mm.yyyy'')))/100 as ost_2202'||nlchr||
                           '     , abs(fost(bpk.acc_2207,to_date(:zDate1,''dd.mm.yyyy'')))/100 as ost_2207'||nlchr||
                           '     , abs(fost(bpk.acc_2208,to_date(:zDate1,''dd.mm.yyyy'')))/100 as ost_2208'||nlchr||
                           '     , abs(fost(bpk.acc_2209,to_date(:zDate1,''dd.mm.yyyy'')))/100 as ost_2209'||nlchr||
                           '     , case'||nlchr||
                           '         when abs(fost(a7.acc,to_date(:zDate1,''dd.mm.yyyy''))) <> 0 then'||nlchr||
                           '            nvl((select  max(ca.caldt_date) as Day_pr'||nlchr||
                           '                 from ACCM_CALENDAR ca, accounts aa'||nlchr||
                           '                 where aa.acc=a7.acc'||nlchr||
                           '                   and ca.caldt_date between aa.daos and to_date(:zDate1,''dd.mm.yyyy'')'||nlchr||
                           '                   and abs(fost(aa.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100 - fdos(aa.acc,ca.caldt_date,to_date(:zDate1,''dd.mm.yyyy''))/100 <= 0), a7.daos)'||nlchr||
                           '         else NULL'||nlchr||
                           '       end as Dat_PR_2207'||nlchr||
                           '     , case'||nlchr||
                           '         when abs(fost(a9.acc,to_date(:zDate1,''dd.mm.yyyy''))) <> 0 then'||nlchr||
                           '            nvl((select  max(ca.caldt_date) as Day_pr'||nlchr||
                           '                 from ACCM_CALENDAR ca, accounts aa'||nlchr||
                           '                 where aa.acc=a9.acc'||nlchr||
                           '                 and ca.caldt_date between aa.daos and to_date(:zDate1,''dd.mm.yyyy'')'||nlchr||
                           '                 and abs(fost(aa.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100 - fdos(aa.acc,ca.caldt_date,to_date(:zDate1,''dd.mm.yyyy''))/100 <= 0), a9.daos)'||nlchr||
                           '         else NULL'||nlchr||
                           '       end as Dat_PR_2209'||nlchr||
                           '     , (case'||nlchr||
                           '          when bpk.card_code like ''%PENS_ARS%'' then ''ARS'''||nlchr||
                           '          when bpk.card_code like ''%PENS_SOC%'' then ''SOC'''||nlchr||
                           '          else ''ZP'''||nlchr||
                           '        end) as T_PENS'||nlchr||
                           '     , bpk.acc_ovr, bars.nbs_ob22_bra(''2924'',''23'',substr(a.branch,1,15))  as nls_2924 --(select ab.nls from accounts ab where ab.nbs=''2924'' and ab.ob22=''23'' and ab.branch=substr(a.branch,1,15) and ab.kv=980) as nls_2924'||nlchr||
                           '     , bp.name as ZKP'||nlchr||
                           'from ('||nlchr||
                           'select  ''WAY4'' as pc, wo.nd, wo.acc_pk, wo.acc_ovr, wo.acc_2207, wo.acc_2208, wo.acc_2209, wo.acc_9129, wo.card_code, wo.dat_end, wg.code as prodx'||nlchr||
                           'from w4_acc wo, w4_product wp, w4_product_groups wg, w4_card wc'||nlchr||
                           'where wg.code=wp.GRP_CODE and wp.code=wc.product_code and wc.CODE=wo.CARD_CODE and (dat_close is NULL or dat_close > to_date(:zDate1,''dd.mm.yyyy''))'||nlchr||
                           '  and (acc_2207 is not NULL or acc_2209 is not NULL)'||nlchr||
                           ') bpk left join accounts a   on bpk.acc_pk=a.acc'||nlchr||
                           '      left join customer c   on a.rnk=c.rnk'||nlchr||
                           '      left join customerw cw on (c.rnk=cw.rnk and cw.tag=''MPNO'')'||nlchr||
                           '      left join customerw cww on (c.rnk=cww.rnk and cww.tag=''WORK'')'||nlchr||
                           '      left join customer_address ca on (c.rnk=ca.rnk  and ca.type_id=1)'||nlchr||
                           '      left join customer_address ca2 on (c.rnk=ca2.rnk  and ca2.type_id=2)'||nlchr||
                           '      left join person p     on c.rnk=p.rnk'||nlchr||
                           '      left join accounts a7  on bpk.acc_2207=a7.acc'||nlchr||
                           '      left join accounts a9  on bpk.acc_2209=a9.acc'||nlchr||
                           '      left join specparam_int s7 on bpk.acc_2207=s7.acc'||nlchr||
                           '      left join specparam_int s9 on bpk.acc_2209=s9.acc'||nlchr||
                           '      LEFT JOIN accountsw  aw  ON (a.acc = aw.acc AND aw.tag = ''PK_PRCT'')'||nlchr||
                           '      LEFT JOIN bpk_proect bp  ON TRIM (aw.VALUE) = TRIM (TO_CHAR (bp.ID))'||nlchr||
                           'where (((a7.dazs is NULL or a9.dazs is NULL or a7.dazs>to_date(:zDate1,''dd.mm.yyyy'') or a9.dazs>to_date(:zDate1,''dd.mm.yyyy''))'||nlchr||
                           '        and (nvl((abs(fost(a7.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100),0)+ nvl((abs(fost(a9.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100),0))<>0) or (s7.deb05 is not NULL or s9.deb05 is not NULL))'||nlchr||
                           '  and (bpk.card_code like ''%PENS%'' or bpk.card_code like ''%SAL%'' or bpk.card_code like ''%BUDG_LOYAL%'' or bpk.prodx = ''SALARY'' or bpk.prodx = ''PENSION'')'||nlchr||
                           ') x1 left join'||nlchr||
                           '(select substr(a.branch,1,15) as branch, w.nd, w.acc_pk, w.acc_ovr, nvl(i.ir,-1) as ir, a.kv'||nlchr||
                           '     , a.nls'||nlchr||
                           '     , round(fost_avg(w.acc_ovr, add_months(trunc(to_date(:zDate1,''dd.mm.yyyy'')),-1), trunc(to_date(:zDate1,''dd.mm.yyyy''))-1)/100,2) as OST_SD_NOM'||nlchr||
                           '     , ao.nls as nls_ovr, c.nmk, c.rnk, w.CARD_CODE, aw.VALUE as PK_STR'||nlchr||
                           '     , round(      (round(fost_avg(w.acc_ovr, (add_months(trunc(to_date(:zDate1,''dd.mm.yyyy'')),-1)), trunc(to_date(:zDate1,''dd.mm.yyyy'')))/100,2))*(1+(((nvl(i.ir,-1))/100)/12)*5),2) as Insur_sum'||nlchr||
                           '     , round(round((round(fost_avg(w.acc_ovr, (add_months(trunc(to_date(:zDate1,''dd.mm.yyyy'')),-1)), trunc(to_date(:zDate1,''dd.mm.yyyy'')))/100,2))*(1+(((nvl(i.ir,-1))/100)/12)*5),2)*'||nlchr||
                           '       (case'||nlchr||
                           '          when wg.code in (''PENSION'',''SHIDNIY'',''MOYA_KRAYINA'') and upper(w.card_code)     like ''%ARS%'' then 0.25'||nlchr||
                           '          when wg.code in (''PENSION'',''SHIDNIY'',''MOYA_KRAYINA'') and upper(w.card_code) not like ''%ARS%'' then 0.279'||nlchr||
                           '          else 0.25'||nlchr||
                           '        end)/100,2) as Insur_pay'||nlchr||
                           '     , add_months(trunc(to_date(:zDate1,''dd.mm.yyyy'')),-1) as d1'||nlchr||
                           '     , trunc(to_date(:zDate1,''dd.mm.yyyy''))-1 as d2'||nlchr||
                           '     , (case'||nlchr||
                           '             when wg.code in (''PENSION'',''SHIDNIY'',''MOYA_KRAYINA'') and upper(w.card_code)     like ''%ARS%'' then 0.25'||nlchr||
                           '             when wg.code in (''PENSION'',''SHIDNIY'',''MOYA_KRAYINA'') and upper(w.card_code) not like ''%ARS%'' then 0.279'||nlchr||
                           '             else 0.25'||nlchr||
                           '        end) as kfc'||nlchr||
                           '     , round(      (round(fost_avg(w.acc_ovr, add_months(trunc(to_date(:zDate1,''dd.mm.yyyy'')),-1),trunc(to_date(:zDate1,''dd.mm.yyyy''))-1)/100,2)'||nlchr||
                           '               +nvl(round(fost_avg(w.acc_2207,add_months(trunc(to_date(:zDate1,''dd.mm.yyyy'')),-1),trunc(to_date(:zDate1,''dd.mm.yyyy''))-1)/100,2),0))*(1+(((nvl(i.ir,-1))/100)/12)*5),2) as Insur_sum7'||nlchr||
                           '     , round(round((round(fost_avg(w.acc_ovr, add_months(trunc(to_date(:zDate1,''dd.mm.yyyy'')),-1),trunc(to_date(:zDate1,''dd.mm.yyyy''))-1)/100,2)'||nlchr||
                           '               +nvl(round(fost_avg(w.acc_2207,add_months(trunc(to_date(:zDate1,''dd.mm.yyyy'')),-1),trunc(to_date(:zDate1,''dd.mm.yyyy''))-1)/100,2),0))*(1+(((nvl(i.ir,-1))/100)/12)*5),2)*'||nlchr||
                           '                   (case'||nlchr||
                           '                       when wg.code in (''PENSION'',''SHIDNIY'',''MOYA_KRAYINA'') and upper(w.card_code)     like ''%ARS%'' then 0.25'||nlchr||
                           '                       when wg.code in (''PENSION'',''SHIDNIY'',''MOYA_KRAYINA'') and upper(w.card_code) not like ''%ARS%'' then 0.279'||nlchr||
                           '                       else 0.25'||nlchr||
                           '                    end)/100,2) as Insur_pay7'||nlchr||
                           'from w4_acc w, w4_product wp, w4_product_groups wg, w4_card wc, accounts a, int_ratn i, customer c, accounts ao, accountsw aw'||nlchr||
                           'where wg.code=wp.GRP_CODE and wp.code=wc.product_code'||nlchr||
                           '  and wc.CODE=w.CARD_CODE and wg.code in (''PENSION'',''SALARY'',''SHIDNIY'',''MOYA_KRAYINA'') and a.acc=w.acc_pk and a.acc=aw.acc(+) and aw.tag(+)=''PK_STR'''||nlchr||
                           '  and i.acc=w.acc_ovr and c.rnk=a.rnk and i.id=0 and w.acc_ovr=ao.acc'||nlchr||
                           '  and ao.daos <= trunc(to_date(:zDate1,''dd.mm.yyyy''))-1'||nlchr||
                           '  and i.bdat=(select max(bdat) from int_ratn where acc=i.acc and id=0 and bdat<=trunc(to_date(:zDate1,''dd.mm.yyyy''))-1)'||nlchr||
                           '  and w.acc_ovr is not NULL'||nlchr||
                           ') x2 on x1.acc_ovr=x2.acc_ovr';
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

