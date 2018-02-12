prompt =====================================
prompt == Звіт з визначення кількості днів прострочення за БПК
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
   l_zpr.name := 'Звіт з визначення кількості днів прострочення за БПК';
   l_zpr.pkey := '\BRS\SBR\DPT\141';

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
    l_zpr.name         := 'Звіт з визначення кількості днів прострочення за БПК';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate1=''Дата з (DD.MM.YYYY)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select :zDate1 as ZV_DAT, bpk.pc, bpk.nd, a.nls as nls_2625, a.kv as  kv_2625, to_char(a.daos,''dd.mm.yyyy'') as date_open_2625
     , a.branch, c.rnk, c.nmk    
     , cw.value as MOB_TEL, p.teld as DOM_TEL, p.telw as WORK_TEL, p.cellphone as MOB_DOD_TEL 
     , ca.ZIP as IND, ca.DOMAIN as OBL, ca.REGION as RAION
     , (select name from ADDRESS_LOCALITY_TYPE where  id=ca.LOCALITY_TYPE) as TYPE_NP
     , ca.LOCALITY
     , (select name from ADDRESS_STREET_TYPE where  id=ca.STREET_TYPE) as TYPE_EDI
     , ca.STREET, ca.HOME, ca.HOMEPART, ca.ROOM, ca.ADDRESS 
     , to_char(bpk.dat_end,''dd.mm.yyyy'') as dat_end
     , to_char(a.dapp,''dd.mm.yyyy'') as date_last_op
     , to_char(x0.date_last_ADD_TT,''dd.mm.yyyy'') as date_last_ADD              
     , case when a2.nbs is NULL then ''2625/''||(select sb.txt from sb_ob22 sb where sb.r020||sb.ob22=a.nbs||a.ob22 and sb.d_close is NULL) 
            else (select sb.txt from sb_ob22 sb where sb.r020||sb.ob22=a2.nbs||a2.ob22 and sb.d_close is NULL) 
       end as Prod_KAT
     , a7.nls as nls_2207, a7.kv as kv_2207
     , abs(fost(a7.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100 as ost_2207 
     , case when abs(fost(a7.acc,to_date(:zDate1,''dd.mm.yyyy''))) <> 0 then
       to_date(:zDate1,''dd.mm.yyyy'') -
       nvl((select max(ca.caldt_date) as Day_pr
            from ACCM_CALENDAR ca, accounts aa
            where aa.acc=a7.acc and ca.caldt_date between aa.daos and to_date(:zDate1,''dd.mm.yyyy'')
              and abs(fost(aa.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100 - fdos(aa.acc,ca.caldt_date,to_date(:zDate1,''dd.mm.yyyy''))/100 <= 0)
           , a7.daos) + 1 else 0 end as Day_PR_2207 
     , a9.nls as nls_2209, a9.kv as kv_2209 --, nvl(s9.deb05,'''') as kod_2209
     , abs(fost(a9.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100 as ost_2209 
     , case when abs(fost(a9.acc,to_date(:zDate1,''dd.mm.yyyy''))) <> 0 then
       to_date(:zDate1,''dd.mm.yyyy'') -
       nvl((select max(ca.caldt_date) as Day_pr
            from ACCM_CALENDAR ca, accounts aa
            where aa.acc=a9.acc
              and ca.caldt_date between aa.daos and to_date(:zDate1,''dd.mm.yyyy'')
              and abs(fost(aa.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100 - fdos(aa.acc,ca.caldt_date,to_date(:zDate1,''dd.mm.yyyy''))/100 <= 0)
           , a9.daos) + 1 else 0 end as Day_PR_2209 
     , (abs(fost(a29.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100) + (abs(fost(a2.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100) as FULL_LIMIT
     , (abs(fost(a29.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100) as CUR_LIMIT
     , nvl((select 1 from w4_product_GRoups gr inner join w4_product pr on gr.code=pr.grp_code
                                               inner join w4_card ccc on pr.code=ccc.PRODUCT_CODE
                                               inner join w4_deal ddd on ccc.code=ddd.card_code where gr.code in (''PENSION'') and ddd.nd=bpk.nd and bpk.pc=''WAY4''  
        ),0) as PENS
     , '' '' as zap_txt
from (
select ''WAY4'' as pc, nd, acc_pk, acc_ovr, acc_2207, acc_2209, acc_9129, card_code, dat_end
from w4_acc 
where (dat_close is NULL or dat_close > to_date(:zDate1,''dd.mm.yyyy''))
  and (acc_2207 is not NULL or acc_2209 is not NULL)
union
select ''CONST'' as pc,nd, acc_pk, acc_ovr, acc_2207, acc_2209, acc_9129
     , (select b.name from bpk_product b where b.id=product_id) as card_code, dat_end
from bpk_acc 
where (dat_end is NULL or dat_end > to_date(:zDate1,''dd.mm.yyyy''))
  and (acc_2207 is not NULL or acc_2209 is not NULL)
) bpk left join accounts a   on bpk.acc_pk=a.acc
      left join customer c   on a.rnk=c.rnk
      left join customerw cw on (c.rnk=cw.rnk and cw.tag=''MPNO'')
      left join customer_address ca on (c.rnk=ca.rnk  and ca.type_id=1)
      left join customer_address ca2 on (c.rnk=ca2.rnk  and ca2.type_id=2)
      left join person p     on c.rnk=p.rnk
      left join accounts a2  on bpk.acc_ovr=a2.acc
      left join accounts a7  on bpk.acc_2207=a7.acc
      left join accounts a9  on bpk.acc_2209=a9.acc
      left join accounts a29 on bpk.acc_9129=a29.acc
      left join specparam_int s7 on a7.acc=s7.acc
      left join specparam_int s9 on a9.acc=s9.acc
      left join (select max(o.fdat) as date_last_ADD_TT, a0.acc 
                 from opldok o, accounts a0
                 where o.dk=1
                   and o.fdat between a0.daos and to_date(:zDate1,''dd.mm.yyyy'')
                   and o.SOS=5
                   and o.TT in (''PKS'',''PKX'',''IB5'',''R01'')
                   and o.acc=a0.acc
                   and a0.nls like ''2625%''
                   and a0.daos <=to_date(:zDate1,''dd.mm.yyyy'')
                   and (a0.dazs is NULL or a0.dazs > to_date(:zDate1,''dd.mm.yyyy''))
                 group by a0.acc  
                   ) x0 on bpk.acc_pk=x0.acc
where ((a7.dazs is NULL or a9.dazs is NULL or a7.dazs>to_date(:zDate1,''dd.mm.yyyy'') or a9.dazs>to_date(:zDate1,''dd.mm.yyyy'')) 
  and ( nvl((abs(fost(a7.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100),0)+ nvl((abs(fost(a9.acc,to_date(:zDate1,''dd.mm.yyyy'')))/100),0)  )<>0)
     or
      ( s7.deb05 is not NULL or s9.deb05 is not NULL  )
order by a.branch, bpk.pc, bpk.nd';
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
