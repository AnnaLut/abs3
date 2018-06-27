

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/report/_BRS_SBR_REP_5500998.sql ====*** 
PROMPT ===================================================================================== 
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
   l_zpr.pkey := '\BRS\SBR\REP\5500998
';

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
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '5500998.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select x1.*
     , case when (select count(acc) as N_NLS from accounts where x1.rnk=rnk and nbs in (''2625'',''2620'') and daos<=to_date(:sFdat1,''dd.mm.yyyy'') and (dazs is NULL or dazs >to_date(:sFdat1,''dd.mm.yyyy'')) group by rnk)>1 then ''так'' else ''ні'' end as RAH_PR
     , (to_date(:sFdat1,''dd.mm.yyyy'') - nvl(x1.Dat_PR_2207,to_date(:sFdat1,''dd.mm.yyyy'')+1) + 1) as Day_PR_2207
     , (to_date(:sFdat1,''dd.mm.yyyy'') - nvl(x1.Dat_PR_2209,to_date(:sFdat1,''dd.mm.yyyy'')+1) + 1) as Day_PR_2209
     , x2.Insur_sum, x2.Insur_pay, x2.Insur_sum7, x2.Insur_pay7, x2.ir,  x2.kfc, x2.d1, x2.d2
from (
select :sFdat1 as ZV_DAT, bpk.pc, bpk.nd, bpk.dat_end DAT_END_CARD, a.nls as nls_2625, a.kv as  kv_2625, to_char(a.daos,''dd.mm.yyyy'') as date_open_2625, a.lim/100 as lim, bpk.card_code
     , a.branch, c.rnk, c.nmk, c.okpo, p.bday, cww.value as M_WORK, cw.value as MOB_TEL, p.teld as DOM_TEL, p.telw as WORK_TEL, p.cellphone as MOB_DOD_TEL
     , ca.ZIP as IND, ca.DOMAIN as OBL, ca.REGION as RAION, (select name from ADDRESS_LOCALITY_TYPE where  id=ca.LOCALITY_TYPE) as TYPE_NP
     , ca.LOCALITY, (select name from ADDRESS_STREET_TYPE where  id=ca.STREET_TYPE) as TYPE_EDI, ca.STREET, ca.HOME, ca.HOMEPART, ca.ROOM, ca.ADDRESS
     , ca2.ZIP as F_IND, ca2.DOMAIN as F_OBL, ca2.REGION as F_RAION, (select name from ADDRESS_LOCALITY_TYPE where  id=ca2.LOCALITY_TYPE) as F_TYPE_NP
     , ca2.LOCALITY as F_LOCALITY, (select name from ADDRESS_STREET_TYPE where  id=ca2.STREET_TYPE) as F_TYPE_EDI, ca2.STREET as F_STREET, ca2.HOME as F_HOME, ca2.HOMEPART as F_HOMEPART, ca2.ROOM as F_ROOM
     , ca2.ADDRESS as F_ADDRESS, abs(fost(bpk.acc_ovr,to_date(:sFdat1,''dd.mm.yyyy'')))/100 as ost_2202, abs(fost(bpk.acc_2207,to_date(:sFdat1,''dd.mm.yyyy'')))/100 as ost_2207
     , abs(fost(bpk.acc_2208,to_date(:sFdat1,''dd.mm.yyyy'')))/100 as ost_2208, abs(fost(bpk.acc_2209,to_date(:sFdat1,''dd.mm.yyyy'')))/100 as ost_2209, case when abs(fost(a7.acc,to_date(:sFdat1,''dd.mm.yyyy''))) <> 0 then
       nvl((select  max(ca.caldt_date) as Day_pr from ACCM_CALENDAR ca, accounts aa where aa.acc=a7.acc and ca.caldt_date between aa.daos and to_date(:sFdat1,''dd.mm.yyyy'')
              and abs(fost(aa.acc,to_date(:sFdat1,''dd.mm.yyyy'')))/100 - fdos(aa.acc,ca.caldt_date,to_date(:sFdat1,''dd.mm.yyyy''))/100 <= 0), a7.daos) else NULL end as Dat_PR_2207
     , case when abs(fost(a9.acc,to_date(:sFdat1,''dd.mm.yyyy''))) <> 0 then
       nvl((select  max(ca.caldt_date) as Day_pr from ACCM_CALENDAR ca, accounts aa where aa.acc=a9.acc and ca.caldt_date between aa.daos and to_date(:sFdat1,''dd.mm.yyyy'')
              and abs(fost(aa.acc,to_date(:sFdat1,''dd.mm.yyyy'')))/100 - fdos(aa.acc,ca.caldt_date,to_date(:sFdat1,''dd.mm.yyyy''))/100 <= 0), a9.daos) else NULL end as Dat_PR_2209
     , (case when bpk.card_code like ''%PENS_ARS%'' then ''ARS'' when bpk.card_code like ''%PENS_SOC%'' then ''SOC'' else ''ZP'' end) as T_PENS
     , bpk.acc_ovr, nbs_ob22_bra(''2924'',''23'',substr(a.branch,1,15)) /*(select ab.nls from accounts ab where ab.nbs=''2924'' and ab.ob22=''23'' and ab.branch=substr(a.branch,1,15) and ab.kv=980)*/ as nls_2924, bp.name as ZKP
from (
select  ''WAY4'' as pc, wo.nd, wo.acc_pk, wo.acc_ovr, wo.acc_2207, wo.acc_2208, wo.acc_2209, wo.acc_9129, wo.card_code, wo.dat_end, wg.code as prodx
from w4_acc wo, w4_product wp, w4_product_groups wg, w4_card wc
where wg.code=wp.GRP_CODE and wp.code=wc.product_code and wc.CODE=wo.CARD_CODE and (dat_close is NULL or dat_close > to_date(:sFdat1,''dd.mm.yyyy''))
  and (acc_2207 is not NULL or acc_2209 is not NULL)
) bpk left join accounts a   on bpk.acc_pk=a.acc
      left join customer c   on a.rnk=c.rnk
      left join customerw cw on (c.rnk=cw.rnk and cw.tag=''MPNO'')
      left join customerw cww on (c.rnk=cww.rnk and cww.tag=''WORK'')
      left join customer_address ca on (c.rnk=ca.rnk  and ca.type_id=1)
      left join customer_address ca2 on (c.rnk=ca2.rnk  and ca2.type_id=2)
      left join person p     on c.rnk=p.rnk
      left join accounts a7  on bpk.acc_2207=a7.acc
      left join accounts a9  on bpk.acc_2209=a9.acc
      left join specparam_int s7 on bpk.acc_2207=s7.acc
      left join specparam_int s9 on bpk.acc_2209=s9.acc
      LEFT JOIN accountsw  aw  ON (a.acc = aw.acc AND aw.tag = ''PK_PRCT'')
      LEFT JOIN bpk_proect bp  ON RTRIM (LTRIM (aw.VALUE)) = RTRIM (LTRIM (TO_CHAR (bp.ID)))
where (((a7.dazs is NULL or a9.dazs is NULL or a7.dazs>to_date(:sFdat1,''dd.mm.yyyy'') or a9.dazs>to_date(:sFdat1,''dd.mm.yyyy''))
        and (nvl((abs(fost(a7.acc,to_date(:sFdat1,''dd.mm.yyyy'')))/100),0)+ nvl((abs(fost(a9.acc,to_date(:sFdat1,''dd.mm.yyyy'')))/100),0))<>0) or (s7.deb05 is not NULL or s9.deb05 is not NULL))
  and (bpk.card_code like ''%PENS%'' or bpk.card_code like ''%SAL%'' or bpk.card_code like ''%BUDG_LOYAL%'' or bpk.prodx = ''SALARY'' or bpk.prodx = ''PENSION'')
) x1 left join
(select substr(a.branch,1,15) as branch, w.nd, w.acc_pk, w.acc_ovr, nvl(i.ir,-1) as ir, a.kv
     , a.nls
     , round(fost_avg(w.acc_ovr, add_months(TO_DATE(''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))),''dd.mm.yyyy''),-1), TO_DATE (''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))), ''dd.mm.yyyy'')-1)/100,2) as OST_SD_NOM
     , ao.nls as nls_ovr, c.nmk, c.rnk, w.CARD_CODE, aw.VALUE as PK_STR
     , round(      (round(fost_avg(w.acc_ovr, (add_months(TO_DATE(''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))),''dd.mm.yyyy''),-1)), (TO_DATE (''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))), ''dd.mm.yyyy'')-1))/100,2))*(1+(((nvl(i.ir,-1))/100)/12)*5),2) as Insur_sum
     , round(round((round(fost_avg(w.acc_ovr, (add_months(TO_DATE(''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))),''dd.mm.yyyy''),-1)), (TO_DATE (''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))), ''dd.mm.yyyy'')-1))/100,2))*(1+(((nvl(i.ir,-1))/100)/12)*5),2)*(case when wg.code in (''PENSION'',''SHIDNIY'',''MOYA_KRAYINA'') and upper(w.card_code)     like ''%ARS%'' then 0.25
             when wg.code in (''PENSION'',''SHIDNIY'',''MOYA_KRAYINA'') and upper(w.card_code) not like ''%ARS%'' then 0.279
             else 0.25 end)/100,2) as Insur_pay
     , add_months(TO_DATE(''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))),''dd.mm.yyyy''),-1) as d1
     , TO_DATE(''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))),''dd.mm.yyyy'')-1 as d2
     , (case when wg.code in (''PENSION'',''SHIDNIY'',''MOYA_KRAYINA'') and upper(w.card_code)     like ''%ARS%'' then 0.25
             when wg.code in (''PENSION'',''SHIDNIY'',''MOYA_KRAYINA'') and upper(w.card_code) not like ''%ARS%'' then 0.279
             else 0.25 end) as kfc
     , round(      (round(fost_avg(w.acc_ovr, (add_months(TO_DATE(''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))),''dd.mm.yyyy''),-1)), (TO_DATE (''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))), ''dd.mm.yyyy'')-1))/100,2)
                   +nvl(round(fost_avg(w.acc_2207,(add_months(TO_DATE(''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))),''dd.mm.yyyy''),-1)), (TO_DATE (''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))), ''dd.mm.yyyy'')-1))/100,2),0))*(1+(((nvl(i.ir,-1))/100)/12)*5),2) as Insur_sum7
     , round(round((round(fost_avg(w.acc_ovr, (add_months(TO_DATE(''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))),''dd.mm.yyyy''),-1)), (TO_DATE (''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))), ''dd.mm.yyyy'')-1))/100,2)
                   +nvl(round(fost_avg(w.acc_2207,(add_months(TO_DATE(''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))),''dd.mm.yyyy''),-1)), (TO_DATE (''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))), ''dd.mm.yyyy'')-1))/100,2),0))*(1+(((nvl(i.ir,-1))/100)/12)*5),2)*(case when wg.code in (''PENSION'',''SHIDNIY'',''MOYA_KRAYINA'') and upper(w.card_code) like ''%ARS%'' then 0.25
             when wg.code in (''PENSION'',''SHIDNIY'',''MOYA_KRAYINA'') and upper(w.card_code) not like ''%ARS%'' then 0.279
             else 0.25 end)/100,2) as Insur_pay7
from w4_acc w, w4_product wp, w4_product_groups wg, w4_card wc, accounts a, int_ratn i, customer c, accounts ao, accountsw aw
where wg.code=wp.GRP_CODE and wp.code=wc.product_code
  and wc.CODE=w.CARD_CODE and wg.code in (''PENSION'',''SALARY'',''SHIDNIY'',''MOYA_KRAYINA'') and a.acc=w.acc_pk and a.acc=aw.acc(+) and aw.tag(+)=''PK_STR''
  and i.acc=w.acc_ovr and c.rnk=a.rnk and i.id=0 and w.acc_ovr=ao.acc
  and ao.daos <= TO_DATE(''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))),''dd.mm.yyyy'')-1
  and i.bdat=(select max(bdat) from int_ratn where acc=i.acc and id=0 and bdat<=TO_DATE(''01.''||to_char(EXTRACT(MONTH FROM to_date(:sFdat1,''dd.mm.yyyy'')))||''.''||to_char(EXTRACT(YEAR FROM to_date(:sFdat1,''dd.mm.yyyy''))),''dd.mm.yyyy'')-1)
  and w.acc_ovr is not NULL
) x2 on x1.acc_ovr=x2.acc_ovr';
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

    ------------------------    
    --  report            --    
    ------------------------    
                                

    l_rep.name        :='Empty';
    l_rep.description :='БПК (інформація для СК) !зміна коеф! 07.02.2017';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",FALSE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 99; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5500998;


    if l_isnew = 1 then                     
       begin                                
          insert into reports values l_rep;        
          l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
       exception when dup_val_on_index then  
           bars_error.raise_error('REP',14, to_char(l_rep.id));
       end;                                    
    else                                            
       begin                                        
          insert into reports values l_rep;         
          l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
       exception when dup_val_on_index then         
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' изменен.';
          update reports set                
             name        = l_rep.name,       
             description = l_rep.description,
             form        = l_rep.form,       
             param       = l_rep.param,      
             ndat        = l_rep.ndat,       
             mask        = l_rep.mask,       
             usearc      = l_rep.usearc,     
             idf         = l_rep.idf         
          where id=l_rep.id;                 
       end;                                  
    end if;                                  
    bars_report.print_message(l_message);   
end;                                        
/                                           

begin
insert into app_rep (CODEAPP, CODEREP, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR, ACODE)
values ('$RM_DRU1', 5500998, 1, null, null, null, null, null, null, 1, null);
exception
  when dup_val_on_index then
    null;
end;
/
                                            
commit;                                     



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/report/_BRS_SBR_REP_5500998.sql ====*** 
PROMPT ===================================================================================== 
