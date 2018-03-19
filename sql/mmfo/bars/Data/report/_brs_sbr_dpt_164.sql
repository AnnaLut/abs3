prompt =====================================
prompt == БПК рахунки,  контроль зарах. 35 та 90 днів
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
   l_zpr.name := 'БПК рахунки,  контроль зарах. 35 та 90 днів';
   l_zpr.pkey := '\BRS\SBR\DPT\164';

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
    l_zpr.name         := 'БПК рахунки,  контроль зарах. 35 та 90 днів';
    l_zpr.namef        := '';  
    l_zpr.bindvars     := ':BRANCH=''Відділення '',:zdate=''Звітна дата (DD.MM.YYYY) '',:Nbpk=''Вкл. нац. карту? (1-так / 0,пусто - ні) ''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5520.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := ' select x.branch, x.nls, x.kv
     , to_char(x.daos,''dd.mm.yyyy'') as daos
     , x.card_code, x.grp_prod, x.rnk, x.nmk, x.okpo, x.bday, x.v
     , x.mtel, x.dtel
     , x.lim_bpk
     , case when nvl(z2.SZ2,0) <> 0 then ''так'' else ''ні'' end as z_35
     , case when nvl(z3.SZ2,0) <> 0 then ''так'' else ''ні'' end as z_90
     , x.zp_id, x.zp_okpo, x.zp_name
     , x.id as zp_id
--     , (select nvl(trim(okpo),'')||''-''||nvl(trim(name),'') from bpk_proect where TRIM(TO_CHAR(ID))=TRIM(x.id)) as zp_name
from (
select a.acc, a.branch, a.nls, a.kv, a.daos
     , w.card_code, wg.name as grp_prod
     , c.rnk, c.nmk, c.okpo, cw.value as mtel, p.TELD as dtel
     , aw.value as id
     , bp.id as zp_id, bp.okpo as zp_okpo, bp.name as zp_name
     , p.BDAY, case when p.bday is NULL then NULL else trunc((sysdate-p.bday)/(365.25)+0.001) end as v
     , case when (nvl(abs(fost(w.acc_ovr,to_date(:zdate,''dd.mm.yyyy''))),0)+nvl(abs(fost(w.acc_9129,to_date(:zdate,''dd.mm.yyyy''))),0)) > 0 then ''так'' else ''ні'' end as Lim_BPK
from accounts a left join w4_acc w   on a.acc=w.acc_pk and a.kf = w.kf
                left join customer c on a.rnk=c.rnk
                left join customerw cw on c.rnk=cw.rnk and trim(cw.tag)=''MPNO''
                left join person p   on c.rnk=p.rnk
                left join w4_card wc on wc.CODE=w.CARD_CODE and wc.kf = w.kf
                left join w4_product wp on wp.code=wc.product_code and wp.kf = wc.kf
                left join w4_product_groups wg on wg.code=wp.GRP_CODE
                LEFT JOIN accountsw aw ON (a.acc = aw.acc AND trim(aw.tag) = ''PK_PRCT'')
                LEFT JOIN bpk_proect bp ON TRIM(aw.VALUE) = TRIM(TO_CHAR (bp.ID))
where a.nbs = ''2625'' 
  and (a.dazs is NULL or a.dazs>to_date(:zdate,''dd.mm.yyyy''))
  and a.daos <= to_date(:zdate,''dd.mm.yyyy'')
  and w.dat_close is NULL
  and c.k050=''000'' and c.CUSTTYPE=3
  and w.acc_pk is not NULL  
  and instr(to_number(replace(a.branch, ''/'', '''')), case when to_number(replace('':BRANCH'', ''/'', '''')) is NULL or length(ltrim(rtrim(replace('':BRANCH'', ''/'', ''''))))=0 then to_number(replace(a.branch, ''/'', '''')) else to_number(replace('':BRANCH'', ''/'', '''')) end) > 0           
  and w.card_code not like (case when nvl(:Nbpk,''0'')<>''0'' then ''0'' else ''LOC%'' end)
--  and instr((select min(bb.obl) from branch bb where bb.branch=a.branch and bb.date_closed is NULL), case when :KO is NULL then (select min(bb.obl) from branch bb where bb.branch=a.branch and bb.date_closed is NULL) else :KO end)>0  
--  and instr(upper(w.card_code), upper(nvl(:PROD,w.card_code)))>0
) x 
left join   
( select a2.acc
        , round(sum(nvl(o2.s,0))/100,2) as SZ2
   from accounts a2, opldok o2
   where a2.nbs = ''2625''
     and (a2.dazs is NULL or a2.dazs > to_date(:zdate,''dd.mm.yyyy''))  
     and a2.daos <= to_date(:zdate,''dd.mm.yyyy'') 
     and o2.acc=a2.acc
     AND o2.dk = 1
     AND o2.fdat >= TO_DATE (:zdate, ''dd.mm.yyyy'')-35+1
     AND o2.fdat <= TO_DATE (:zdate, ''dd.mm.yyyy'')
     AND o2.tt not in (''OW1'',''OW2'',''OWK'')
--     and instr((select min(bb.obl) from branch bb where bb.branch=a2.branch and bb.date_closed is NULL), case when :KO is NULL then (select min(bb.obl) from branch bb where bb.branch=a2.branch and bb.date_closed is NULL) else :KO end)>0
   group by a2.acc
 ) z2 on x.acc=z2.acc
left join   
( select a2.acc
        , round(sum(nvl(o2.s,0))/100,2) as SZ2
   from accounts a2, opldok o2
   where a2.nbs = ''2625''
     and (a2.dazs is NULL or a2.dazs > to_date(:zdate,''dd.mm.yyyy''))  
     and a2.daos <= to_date(:zdate,''dd.mm.yyyy'') 
     and o2.acc=a2.acc
     AND o2.dk = 1
     AND o2.fdat >= TO_DATE (:zdate, ''dd.mm.yyyy'')-90+1
     AND o2.fdat <= TO_DATE (:zdate, ''dd.mm.yyyy'')
     AND o2.tt not in (''OW1'',''OW2'',''OWK'')
--     and instr((select min(bb.obl) from branch bb where bb.branch=a2.branch and bb.date_closed is NULL), case when :KO is NULL then (select min(bb.obl) from branch bb where bb.branch=a2.branch and bb.date_closed is NULL) else :KO end)>0
   group by a2.acc
 ) z3 on x.acc=z3.acc';
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
    l_rep.description :='БПК рахунки,  контроль зарах. 35 та 90 днів';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",FALSE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5520;


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

    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('$RM_NBUR', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Звітність (новий)';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Звітність (новий)';
    end;

    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('$RM_DRU1', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Друк звітів';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Друк звітів';
    end;

    bars_report.print_message(l_message);
end;
/

commit;
  