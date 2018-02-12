prompt =====================================
prompt == Доходи ММСБ (зарах. 6кл.)
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
   l_zpr.name := 'Доходи ММСБ (зарах. 6кл.)';
   l_zpr.pkey := '\BRS\SBR\DPT\306';

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
    l_zpr.name         := 'Доходи ММСБ (зарах. 6кл.)';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':sDate1=''Дата з (DD.MM.YYYY)'',:sDate31=''Дата по (DD.MM.YYYY)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'DPT_306.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select to_date(:sDate1,''dd.mm.yyyy'') as D1, to_date(:sDate31,''dd.mm.yyyy'') as D2
     , a2.kv, a2.nls, sum(abs(o1.s/100)) as s
     , a1.nbs as nbs_6, a1.ob22 as ob22_6, a1.kv as kv_6, a1.branch
     , c.rnk, c.nmk, c.okpo, '''' as storno
from opldok o1, accounts a1, opldok o2, accounts a2, customer c 
where o1.acc=a1.acc and substr(a1.nbs,1,1)=''6'' 
  and o1.fdat between to_date(:sDate1,''dd.mm.yyyy'') and to_date(:sDate31,''dd.mm.yyyy'') 
  and o1.sos=5
  and o1.dk=1
  and o1.ref=o2.ref
  and o2.acc=a2.acc and substr(a2.nbs,1,2) in (''20'', ''26'', ''35'',''36'', ''37'') 
  and o2.dk=0
  and o2.fdat between to_date(:sDate1,''dd.mm.yyyy'') and to_date(:sDate31,''dd.mm.yyyy'')
  and c.rnk=a2.rnk
  and c.K050<>''000'' 
  and o1.TT=o2.TT
group by c.rnk, a2.kv, a2.nls, a1.nbs, a1.ob22, a1.kv, c.nmk, c.okpo, a1.branch
union all
select to_date(:sDate1,''dd.mm.yyyy'') as D1, to_date(:sDate31,''dd.mm.yyyy'') as D2
     , a2.kv, a2.nls, sum(abs(o1.s/100))*(-1) as s
     , a1.nbs as nbs_6, a1.ob22 as ob22_6, a1.kv as kv_6, a1.branch
     , c.rnk, c.nmk, c.okpo, ''s'' as storno
from opldok o1, accounts a1, opldok o2, accounts a2, customer c 
where o1.acc=a1.acc and substr(a1.nbs,1,1)=''6'' 
  and o1.fdat between to_date(:sDate1,''dd.mm.yyyy'') and to_date(:sDate31,''dd.mm.yyyy'') 
  and o1.sos=5
  and o1.dk=0
  and o1.ref=o2.ref
  and o2.acc=a2.acc and substr(a2.nbs,1,2) in (''20'', ''26'', ''35'',''36'', ''37'') 
  and o2.dk=1
  and o2.fdat between to_date(:sDate1,''dd.mm.yyyy'') and to_date(:sDate31,''dd.mm.yyyy'')
  and c.rnk=a2.rnk
  and c.K050<>''000'' 
  and o1.TT=o2.TT
group by c.rnk, a2.kv, a2.nls, a1.nbs, a1.ob22, a1.kv, c.nmk, c.okpo, a1.branch';
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
    l_rep.description :='Доходи ММСБ (зарах. 6кл.)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='*.*';
    l_rep.usearc      :=0;
    begin
        select idf into l_repfolder from reportsf where idf = 160;
    exception when no_data_found then
        l_repfolder := null;
    end;
    l_rep.idf := l_repfolder;

    -- Фиксированный № печатного отчета
    l_rep.id          := 5507;


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
               ('$RM_MANY', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Формування резервного фонду';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Формування резервного фонду';
    end;

    bars_report.print_message(l_message);
end;
/

commit;
