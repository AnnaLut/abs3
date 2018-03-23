prompt ===================================== 
prompt == Звіт про суми ненарахованих та невиплачених вкладів та відсотків  
prompt == депозитів ФО по всьому ДЕПОЗИТНОМУ ПОРТФЕЛЮ за дату / за період 
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
   l_zpr.name := 'Звіт про суми ненарахованих та невиплачених вкладів та відсотків';
   l_zpr.pkey := '\brs\prvx\xxx\5504';

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
    l_zpr.name         := 'Звіт про суми ненарахованих та невиплачених вкладів та відсотків';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''Дата виплати (DD.MM.YYYY)'',:sFdat2=''Банківська дата (DD.MM.YYYY)'',:BRANCH=''Вiддiлення(%-всі)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5504.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select d.branch, d.rnk, d.nd, a.nls, a.nbs, (a.ostc/100) ostc, d.deposit_id, d.kv,
                   dpt.get_intpaydate(:sFdat2,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) plandate,
                   v.comproc,
                   v.limit
              from dpt_deposit d, dpt_vidd v, accounts a
             where d.vidd = v.vidd
               and d.acc = a.acc
               and d.kv = a.kv
               and d.branch like :BRANCH||''%''
              -- and p_dptid = 0 -- депозитный портфель
               and d.mfo_p is not null
               and d.nls_p is not null
               and dpt.get_intpaydate(:sFdat2,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) between :sFdat1 and :sFdat2
              union all
select ''Всього по рах. 2638:'', null, null, null, a.nbs, sum(a.ostc)/100 ostc, null, d.kv,
                   null,
                   null,
                   null
              from dpt_deposit d, dpt_vidd v, accounts a
             where d.vidd = v.vidd
               and d.acc = a.acc
               and d.kv = a.kv
               and d.branch like :BRANCH||''%''
              -- and p_dptid = 0 -- депозитный портфель
               and d.mfo_p is not null
               and d.nls_p is not null
               and a.nbs = ''2638''
               and dpt.get_intpaydate(:sFdat2,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) between :sFdat1 and :sFdat2 group by d.kv, a.nbs
                union all
select ''Всього неперераховано на рах. 2630'', null, null, null, a.nbs, sum(a.ostc)/100 ostc, null, d.kv,
                   null,
                   null,
                   null
              from dpt_deposit d, dpt_vidd v, accounts a
             where d.vidd = v.vidd
               and d.acc = a.acc
               and d.kv = a.kv
               and d.branch like :BRANCH||''%''
              -- and p_dptid = 0 -- депозитный портфель
               and d.mfo_p is not null
               and d.nls_p is not null
               and a.nbs = ''2630''
               and dpt.get_intpaydate(:sFdat2,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) between :sFdat1 and :sFdat2 group by d.kv, a.nbs
               union all
select ''Всього неперераховано на рах. 2635:'', null, null, null, a.nbs, sum(a.ostc)/100 ostc, null, d.kv,
                   null,
                   null,
                   null
              from dpt_deposit d, dpt_vidd v, accounts a
             where d.vidd = v.vidd
               and d.acc = a.acc
               and d.kv = a.kv
               and d.branch like :BRANCH||''%''
              -- and p_dptid = 0 -- депозитный портфель
               and d.mfo_p is not null
               and d.nls_p is not null
               and a.nbs = ''2635''
               and dpt.get_intpaydate(:sFdat2,
                                      d.dat_begin,
                                      d.dat_end,
                                      d.freq,
                                      decode(v.amr_metr, 0, 0, 1),
                                      decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                                      1) between :sFdat1 and :sFdat2 group by d.kv, a.nbs';
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
    l_rep.description :='Звіт про суми ненарахованих та невиплачених вкладів та відсотків';
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
    l_rep.id          := 5504;


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
