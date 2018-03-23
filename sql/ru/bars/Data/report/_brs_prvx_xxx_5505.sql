prompt ===================================== 
prompt == Звіт по депозитам за якими здійснено поповнення в результаті чого залишки потрапляють 
prompt == під дію програми лояльності по всьому ДЕПОЗИТНОМУ ПОРТФЕЛЮ за дату / за період
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
   l_zpr.name := 'Звіт по депозитам за якими здійснено поповнення';
   l_zpr.pkey := '\brs\prvx\xxx\5505';

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
    l_zpr.name         := 'Звіт по депозитам за якими здійснено поповнення';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''Планова дата виплати (DD.MM.YYYY)'',:sFdat2=''Банківська дата (DD.MM.YYYY)'',:BRANCH=''Вiддiлення(%-всі)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5505.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select * from (select /*+ ORDERED INDEX(a) INDEX(i)*/
         a.branch,
         d.deposit_id,
         d.nd,
         d.datz,
         d.rnk,
         i.id,
         i.s SUM,
         a.acc,
         a.nls,
         a.kv,
         a.nbs,
         substr(a.nms, 1, 38) nms,
         t.lcv,
         a.daos,
         a.ostc,
         nvl(i.tt, ''%%1'') tt,
         ''DPT'' DPT
          from dpt_deposit d, accounts a, int_accn i, tabval t, dpt_vidd v
         where d.acc = a.acc
           and d.acc = i.acc
           and i.id = 1
           and a.kv = t.kv
           and d.vidd = v.vidd
           and d.branch like :BRANCH||''%''
          -- and (p_dptid = 0 or p_dptid = d.deposit_id)
           and ((i.acr_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat > i.acr_dat))
           and dpt.get_intpaydate(to_date(:sFdat2,''dd.mm.yyyy''),
                                  d.dat_begin,
                                  d.dat_end,
                                  d.freq,
                                  decode(v.amr_metr, 0, 0, 1),
                                  decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                  1) = to_date(:sFdat1,''dd.mm.yyyy'') 
           union all
           select /*+ ORDERED INDEX(a) INDEX(i)*/
         ''Всього по рах. 2630:'',
         null,
         null,
         null,
         null,
         null,
         sum(i.s) SUM,
         null,
         null,
         a.kv,
         a.nbs,
         null,
         null,
         null,
         sum(a.ostc)/100 ostc,
         null,
         ''DPT'' DPT
          from dpt_deposit d, accounts a, int_accn i, tabval t, dpt_vidd v
         where d.acc = a.acc
           and d.acc = i.acc
           and i.id = 1
           and a.kv = t.kv
           and d.vidd = v.vidd
           and d.branch like :BRANCH||''%''
          -- and (p_dptid = 0 or p_dptid = d.deposit_id)
           and a.nbs =''2630''
           and ((i.acr_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat > i.acr_dat))
           and dpt.get_intpaydate(to_date(:sFdat2,''dd.mm.yyyy''),
                                  d.dat_begin,
                                  d.dat_end,
                                  d.freq,
                                  decode(v.amr_metr, 0, 0, 1),
                                  decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                  1) = to_date(:sFdat1,''dd.mm.yyyy'') group by a.kv, a.nbs
          union all
           select /*+ ORDERED INDEX(a) INDEX(i)*/
         ''Всього по рах. 2635:'',
         null,
         null,
         null,
         null,
         null,
         sum(i.s) SUM,
         null,
         null,
         a.kv,
         a.nbs,
         null,
         null,
         null,
         sum(a.ostc)/100 ostc,
         null,
         ''DPT'' DPT
          from dpt_deposit d, accounts a, int_accn i, tabval t, dpt_vidd v
         where d.acc = a.acc
           and d.acc = i.acc
           and i.id = 1
           and a.kv = t.kv
           and d.vidd = v.vidd
           and d.branch like :BRANCH||''%''
          -- and (p_dptid = 0 or p_dptid = d.deposit_id)
           and a.nbs =''2635''
           and ((i.acr_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat > i.acr_dat))
           and dpt.get_intpaydate(to_date(:sFdat2,''dd.mm.yyyy''),
                                  d.dat_begin,
                                  d.dat_end,
                                  d.freq,
                                  decode(v.amr_metr, 0, 0, 1),
                                  decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                  1) = to_date(:sFdat1,''dd.mm.yyyy'') group by a.kv, a.nbs
          union all
           select /*+ ORDERED INDEX(a) INDEX(i)*/
         ''Всього кількість рахунків'',
         null,
         null,
         null,
         null,
         null,
         sum(i.s) SUM,
         null,
         to_char(count(a.nls)) nls,
         a.kv,
         null,
         null,
         null,
         null,
         sum(a.ostc)/100 ostc,
         null,
         ''DPT'' DPT
          from dpt_deposit d, accounts a, int_accn i, tabval t, dpt_vidd v
         where d.acc = a.acc
           and d.acc = i.acc
           and i.id = 1
           and a.kv = t.kv
           and d.vidd = v.vidd
           and d.branch like :BRANCH||''%''
          -- and (p_dptid = 0 or p_dptid = d.deposit_id)
           and ((i.acr_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat is null) or
               (i.acr_dat < to_date(:sFdat1,''dd.mm.yyyy'')-1 and i.stp_dat > i.acr_dat))
           and dpt.get_intpaydate(to_date(:sFdat2,''dd.mm.yyyy''),
                                  d.dat_begin,
                                  d.dat_end,
                                  d.freq,
                                  decode(v.amr_metr, 0, 0, 1),
                                  decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                  1) = to_date(:sFdat1,''dd.mm.yyyy'') group by a.kv) order by branch, kv ';
    l_zpr.xsl_data     := '';
    l_zpr.xsd_data     := '';

    if l_isnew = 1 then           
       insert into zapros values l_zpr;  
       l_message:=l_message||'Добавлен новый кат.запрос №'||l_zpr.kodz||'.'; 
    else                           
       update zapros set name         = l_zpr.name,        
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
    l_rep.description :='Звіт по депозитам за якими здійснено поповнення';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",FALSE,FALSE';
    l_rep.ndat        :=0;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 160;
    exception when no_data_found then
        l_repfolder := null;
    end;
    l_rep.idf := l_repfolder;

    -- Фиксированный № печатного отчета
    l_rep.id          := 5505;


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
               ('DRU1', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Друк звітів';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Друк звітів';
    end;

    begin
      Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('WDPT', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Вкладних операцій';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Вкладних операцій';
    end;

    bars_report.print_message(l_message);
end;
/

commit;
