prompt =====================================
prompt == Звіт БПК (кількість відкр/закр. в розрізі ТВБВ 1-4)
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
   l_zpr.name := 'Звіт БПК (кількість відкр/закр. в розрізі ТВБВ 1-4)';
   l_zpr.pkey := '\BRS\SBR\DPT\206';

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
    l_zpr.name         := 'Звіт БПК (кількість відкр/закр. в розрізі ТВБВ 1-4)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':zDate1=''Дата з(DD.MM.YYYY)'',:zDate2=''Дата по(DD.MM.YYYY)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5516.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select a.branch
     , ''З ''||:zDate1||'' по ''|| :zDate2 as period
     , sum(fostq(a.acc, to_date(:zDate1,''dd.mm.yyyy'')-1)/100) as S_1
     , sum(case when a.daos < to_date(:zDate1,''dd.mm.yyyy'') and (a.dazs is NULL or a.dazs >= to_date(:zDate1,''dd.mm.yyyy'')) then 1 else 0 end) as N_COUNT1
     , sum(case when a.daos between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'') then 1 else 0 end) as N_OPEN
     , sum(case when nvl(a.dazs,to_date(:zDate1,''dd.mm.yyyy'')-1) between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'') then 1 else 0 end) as N_CLOS
     , sum(case when a.dazs is NULL or a.dazs > to_date(:zDate2,''dd.mm.yyyy'') then 1 else 0 end) as N_COUNT2
     , sum(fostq_avg(a.acc, to_date(:zDate1,''dd.mm.yyyy''), to_date(:zDate2,''dd.mm.yyyy''))/100) as SD_Q
     , sum(fostq(a.acc, to_date(:zDate2,''dd.mm.yyyy''))/100) as S_2

     , sum(case when a.nbs||ob22=''262529'' then fostq(a.acc, to_date(:zDate1,''dd.mm.yyyy'')-1)/100 else 0 end) as SP_S_1
     , sum(case when a.nbs||ob22=''262529'' and a.daos < to_date(:zDate1,''dd.mm.yyyy'') and (a.dazs is NULL or a.dazs >= to_date(:zDate1,''dd.mm.yyyy'')) then 1 else 0 end) as SP_N_COUNT1
     , sum(case when a.nbs||ob22=''262529'' and a.daos between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'') then 1 else 0 end) as SP_N_OPEN
     , sum(case when a.nbs||ob22=''262529'' and nvl(a.dazs,to_date(:zDate1,''dd.mm.yyyy'')-1) between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'') then 1 else 0 end) as SP_N_CLOS
     , sum(case when a.nbs||ob22=''262529'' and (a.dazs is NULL or a.dazs > to_date(:zDate2,''dd.mm.yyyy'')) then 1 else 0 end) as SP_N_COUNT2
     , sum(case when a.nbs||ob22=''262529'' then fostq_avg(a.acc, to_date(:zDate1,''dd.mm.yyyy''), to_date(:zDate2,''dd.mm.yyyy''))/100 else 0 end) as SP_SD_Q
     , sum(case when a.nbs||ob22=''262529'' then fostq(a.acc, to_date(:zDate2,''dd.mm.yyyy''))/100 else 0 end) as SP_S_2

     , sum(case when a.nbs||ob22=''262530'' then fostq(a.acc, to_date(:zDate1,''dd.mm.yyyy'')-1)/100 else 0 end) as VP_S_1
     , sum(case when a.nbs||ob22=''262530'' and a.daos < to_date(:zDate1,''dd.mm.yyyy'') and (a.dazs is NULL or a.dazs >= to_date(:zDate1,''dd.mm.yyyy'')) then 1 else 0 end) as VP_N_COUNT1
     , sum(case when a.nbs||ob22=''262530'' and a.daos between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'') then 1 else 0 end) as VP_N_OPEN
     , sum(case when a.nbs||ob22=''262530'' and nvl(a.dazs,to_date(:zDate1,''dd.mm.yyyy'')-1) between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'') then 1 else 0 end) as VP_N_CLOS
     , sum(case when a.nbs||ob22=''262530'' and (a.dazs is NULL or a.dazs > to_date(:zDate2,''dd.mm.yyyy'')) then 1 else 0 end) as VP_N_COUNT2
     , sum(case when a.nbs||ob22=''262530'' then fostq_avg(a.acc, to_date(:zDate1,''dd.mm.yyyy''), to_date(:zDate2,''dd.mm.yyyy''))/100 else 0 end) as VP_SD_Q
     , sum(case when a.nbs||ob22=''262530'' then fostq(a.acc, to_date(:zDate2,''dd.mm.yyyy''))/100 else 0 end) as VP_S_2

     , sum(case when a.nbs||ob22 in (''262530'',''262529'') and a.daos between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'') and nvl(pa.rnk,0)<>0 then 1 else 0 end) as PP_CONT_2620_NC
     , sum(case when a.nbs||ob22 in (''262530'',''262529'') and nvl(pa.rnk,0)<>0 then 1 else 0 end) as PP_CONT_2620 
 
     , sum(case when a.nbs||ob22 in (''262524'',''262527'') then fostq(a.acc, to_date(:zDate1,''dd.mm.yyyy'')-1)/100 else 0 end) as ZK_S_1
     , sum(case when a.nbs||ob22 in (''262524'',''262527'') and a.daos < to_date(:zDate1,''dd.mm.yyyy'') and (a.dazs is NULL or a.dazs >= to_date(:zDate1,''dd.mm.yyyy'')) then 1 else 0 end) as ZK_N_COUNT1
     , sum(case when a.nbs||ob22 in (''262524'',''262527'') and a.daos between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'') then 1 else 0 end) as ZK_N_OPEN
     , sum(case when a.nbs||ob22 in (''262524'',''262527'') and nvl(a.dazs,to_date(:zDate1,''dd.mm.yyyy'')-1) between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'') then 1 else 0 end) as ZK_N_CLOS
     , sum(case when a.nbs||ob22 in (''262524'',''262527'') and (a.dazs is NULL or a.dazs > to_date(:zDate2,''dd.mm.yyyy'')) then 1 else 0 end) as ZK_N_COUNT2
     , sum(case when a.nbs||ob22 in (''262524'',''262527'') then fostq_avg(a.acc, to_date(:zDate1,''dd.mm.yyyy''), to_date(:zDate2,''dd.mm.yyyy''))/100 else 0 end) as ZK_SD_Q
     , sum(case when a.nbs||ob22 in (''262524'',''262527'') then fostq(a.acc, to_date(:zDate2,''dd.mm.yyyy''))/100 else 0 end) as ZK_S_2 
 
     , sum(case when a.nbs||ob22 in (''262531'',''262532'') then fostq(a.acc, to_date(:zDate1,''dd.mm.yyyy'')-1)/100 else 0 end) as ZB_S_1
     , sum(case when a.nbs||ob22 in (''262531'',''262532'') and a.daos < to_date(:zDate1,''dd.mm.yyyy'') and (a.dazs is NULL or a.dazs >= to_date(:zDate1,''dd.mm.yyyy'')) then 1 else 0 end) as ZB_N_COUNT1
     , sum(case when a.nbs||ob22 in (''262531'',''262532'') and a.daos between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'') then 1 else 0 end) as ZB_N_OPEN
     , sum(case when a.nbs||ob22 in (''262531'',''262532'') and nvl(a.dazs,to_date(:zDate1,''dd.mm.yyyy'')-1) between to_date(:zDate1,''dd.mm.yyyy'') and to_date(:zDate2,''dd.mm.yyyy'') then 1 else 0 end) as ZB_N_CLOS
     , sum(case when a.nbs||ob22 in (''262531'',''262532'') and (a.dazs is NULL or a.dazs > to_date(:zDate2,''dd.mm.yyyy'')) then 1 else 0 end) as ZB_N_COUNT2
     , sum(case when a.nbs||ob22 in (''262531'',''262532'') then fostq_avg(a.acc, to_date(:zDate1,''dd.mm.yyyy''), to_date(:zDate2,''dd.mm.yyyy''))/100 else 0 end) as ZB_SD_Q
     , sum(case when a.nbs||ob22 in (''262531'',''262532'') then fostq(a.acc, to_date(:zDate2,''dd.mm.yyyy''))/100 else 0 end) as ZB_S_2            
from accounts a left join ( select a20.rnk
                            from accounts a20 
                            where a20.nbs=''2620'' and a20.ob22 in (''20'', ''21'', ''23'', ''15'') and a20.daos < to_date(:zDate2,''dd.mm.yyyy'') and (a20.dazs is NULL or a20.dazs > to_date(:zDate1,''dd.mm.yyyy''))
                            group by a20.rnk
                          ) pa on a.rnk=pa.rnk  
                left join w4_acc w on a.acc=w.acc_pk            
where a.nbs in (''2625'') and a.tip<>''ODB''
  and a.daos <= to_date(:zDate2,''dd.mm.yyyy'')
  and (a.dazs is NULL or a.dazs > to_date(:zDate1,''dd.mm.yyyy''))
  and w.acc_pk is not NULL
  and upper(w.card_code) not like ''LOCAL%''
group by a.branch';
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
    l_rep.description :='Звіт БПК (кількість відкр/закр. в розрізі ТВБВ 1-4)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",FALSE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5516;


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
