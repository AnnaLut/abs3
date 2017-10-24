prompt ===================================== 
prompt == БПК рахунки, контроль зарах. 35 та 90 днів.
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
   l_zpr.name := 'БПК рахунки, контроль зарах. 35 та 90 днів.';
   l_zpr.pkey := '\BRS\SBR\REP\5715';

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
    l_zpr.name         := 'БПК рахунки, контроль зарах. 35 та 90 днів.';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':BRANCH=''Відділення: '',:zdate=''Звітна дата (DD.MM.YYYY): '',:Nbpk=''Вкл. нац. карту? (1-так / 0,пусто - ні): '',:KO=''Київ/Обл (26/09): '',:PROD=''Card_Code (SAL,PENS,SOC...)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5715.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := 'BRANCH=''V_BRANCH_OWN|BRANCH|NAME|WHERE DATE_CLOSED IS NULL order by BRANCH''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select x.branch, x.nls, x.kv'||nlchr||
                           '     , to_char(x.daos,''dd.mm.yyyy'') as daos'||nlchr||
                           '     , x.card_code, x.grp_prod, x.rnk, x.nmk, x.okpo, x.bday, x.v'||nlchr||
                           '     , x.mtel, x.dtel'||nlchr||
                           '     , x.lim_bpk'||nlchr||
                           '     , case when nvl(z2.SZ2,0) <> 0 then ''так'' else ''ні'' end as z_35'||nlchr||
                           '     , case when nvl(z3.SZ2,0) <> 0 then ''так'' else ''ні'' end as z_90'||nlchr||
                           '--     , x.zp_id, x.zp_okpo, x.zp_name'||nlchr||
                           '     , x.id as zp_id'||nlchr||
                           '     , (select nvl(trim(okpo),'''')||''-''||nvl(trim(name),'''') from bpk_proect where TRIM(TO_CHAR(ID))=TRIM(x.id)) as zp_name'||nlchr||
                           'from ('||nlchr||
                           'select a.acc, a.branch, a.nls, a.kv, a.daos'||nlchr||
                           '     , w.card_code, wg.name as grp_prod'||nlchr||
                           '     , c.rnk, c.nmk, c.okpo, cw.value as mtel, p.TELD as dtel'||nlchr||
                           '     , aw.value as id'||nlchr||
                           '--     , bp.id as zp_id, bp.okpo as zp_okpo, bp.name as zp_name'||nlchr||
                           '     , p.BDAY, case when p.bday is NULL then NULL else trunc((sysdate-p.bday)/(365.25)+0.001) end as v'||nlchr||
                           '     , case when (nvl(abs(fost(w.acc_ovr,to_date(:zdate,''dd.mm.yyyy''))),0)+nvl(abs(fost(w.acc_9129,to_date(:zdate,''dd.mm.yyyy''))),0)) > 0 then ''так'' else ''ні'' end as Lim_BPK'||nlchr||
                           'from accounts a left join w4_acc w   on a.acc=w.acc_pk'||nlchr||
                           '                left join customer c on a.rnk=c.rnk'||nlchr||
                           '                left join customerw cw on c.rnk=cw.rnk and trim(cw.tag)=''MPNO'''||nlchr||
                           '                left join person p   on c.rnk=p.rnk'||nlchr||
                           '                left join w4_card wc on wc.CODE=w.CARD_CODE'||nlchr||
                           '                left join w4_product wp on wp.code=wc.product_code'||nlchr||
                           '                left join w4_product_groups wg on wg.code=wp.GRP_CODE'||nlchr||
                           '                LEFT JOIN accountsw aw ON (a.acc = aw.acc AND trim(aw.tag) = ''PK_PRCT'')'||nlchr||
                           '--                LEFT JOIN bpk_proect bp ON TRIM(aw.VALUE) = TRIM(TO_CHAR (bp.ID))'||nlchr||
                           'where substr(a.nls,1,4)=''2625'' '||nlchr||
                           '  and (a.dazs is NULL or a.dazs>to_date(:zdate,''dd.mm.yyyy''))'||nlchr||
                           '  and a.daos <= to_date(:zdate,''dd.mm.yyyy'')'||nlchr||
                           '  and w.dat_close is NULL'||nlchr||
                           '  and c.k050=''000'' and c.CUSTTYPE=3'||nlchr||
                           '  and w.acc_pk is not NULL  '||nlchr||
                           '  and instr(a.branch, case when :BRANCH is NULL or length(ltrim(rtrim(:BRANCH)))=0 then a.branch else :BRANCH end) > 0           '||nlchr||
                           '  and w.card_code not like (case when nvl(:Nbpk,''0'')<>''0'' then ''0'' else ''LOC%'' end)'||nlchr||
                           '  and instr((select min(bb.obl) from branch bb where bb.branch=a.branch and bb.date_closed is NULL), case when :KO is NULL then (select min(bb.obl) from branch bb where bb.branch=a.branch and bb.date_closed is NULL) else :KO end)>0  '||nlchr||
                           '  and instr(upper(w.card_code), upper(nvl(:PROD,w.card_code)))>0'||nlchr||
                           ') x '||nlchr||
                           'left join   '||nlchr||
                           '( select a2.acc'||nlchr||
                           '        , round(sum(nvl(o2.s,0))/100,2) as SZ2'||nlchr||
                           '   from accounts a2, opldok o2'||nlchr||
                           '   where a2.nbs in (''2625'')'||nlchr||
                           '     and (a2.dazs is NULL or a2.dazs > to_date(:zdate,''dd.mm.yyyy''))  '||nlchr||
                           '     and a2.daos <= to_date(:zdate,''dd.mm.yyyy'') '||nlchr||
                           '     and o2.acc=a2.acc'||nlchr||
                           '     AND o2.dk = 1'||nlchr||
                           '     AND o2.fdat >= TO_DATE (:zdate, ''dd.mm.yyyy'')-35+1'||nlchr||
                           '     AND o2.fdat <= TO_DATE (:zdate, ''dd.mm.yyyy'')'||nlchr||
                           '     AND o2.tt not in (''OW1'',''OW2'',''OWK'')'||nlchr||
                           '--     and instr((select min(bb.obl) from branch bb where bb.branch=a2.branch and bb.date_closed is NULL), case when :KO is NULL then (select min(bb.obl) from branch bb where bb.branch=a2.branch and bb.date_closed is NULL) else :KO end)>0'||nlchr||
                           '   group by a2.acc'||nlchr||
                           ' ) z2 on x.acc=z2.acc'||nlchr||
                           'left join   '||nlchr||
                           '( select a2.acc'||nlchr||
                           '        , round(sum(nvl(o2.s,0))/100,2) as SZ2'||nlchr||
                           '   from accounts a2, opldok o2'||nlchr||
                           '   where a2.nbs in (''2625'')'||nlchr||
                           '     and (a2.dazs is NULL or a2.dazs > to_date(:zdate,''dd.mm.yyyy''))  '||nlchr||
                           '     and a2.daos <= to_date(:zdate,''dd.mm.yyyy'') '||nlchr||
                           '     and o2.acc=a2.acc'||nlchr||
                           '     AND o2.dk = 1'||nlchr||
                           '     AND o2.fdat >= TO_DATE (:zdate, ''dd.mm.yyyy'')-90+1'||nlchr||
                           '     AND o2.fdat <= TO_DATE (:zdate, ''dd.mm.yyyy'')'||nlchr||
                           '     AND o2.tt not in (''OW1'',''OW2'',''OWK'')'||nlchr||
                           '--     and instr((select min(bb.obl) from branch bb where bb.branch=a2.branch and bb.date_closed is NULL), case when :KO is NULL then (select min(bb.obl) from branch bb where bb.branch=a2.branch and bb.date_closed is NULL) else :KO end)>0'||nlchr||
                           '   group by a2.acc'||nlchr||
                           ' ) z3 on x.acc=z3.acc   ';
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
    l_rep.description :='БПК рахунки, контроль зарах. 35 та 90 днів.';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=0;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 99; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5715;


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
                                            
commit;                                     
