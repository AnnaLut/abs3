prompt =====================================
prompt == СДЗ 2620, 2622, 2625 (в розрізі ТВБВ)
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
   l_zpr.name := 'СДЗ 2620, 2622, 2625 (в розрізі ТВБВ)';
   l_zpr.pkey := '\BRS\SBR\DPT\201';

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
    l_zpr.name         := 'СДЗ 2620, 2622, 2625 (в розрізі ТВБВ)';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate1=''Дата з(DD.MM.YYYY):'',:zDate31=''Дата по(DD.MM.YYYY):''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select x.branch
     , sum(x.ost) as SD_ALL
     , sum(case when x.nbs in (''2620'', ''2622'') then x.ost else 0 end) as SD_ZAP
     , sum(case when x.nbs in (''2625'')         then x.ost else 0 end) as SD_WAY
from 
(
select a2.acc, a2.nbs, a2.nls, a2.kv, a2.branch
     , fostq_avg(a2.acc, to_date(:zDate1,''dd.mm.yyyy''), to_date(:zDate31,''dd.mm.yyyy''))/100 as OST
from accounts a2 
where substr(a2.nls,1,4) in (''2620'', ''2622'', ''2625'')
  and a2.daos <= to_date(:zDate31,''dd.mm.yyyy'')
  and (a2.dazs is NULL or a2.dazs > to_date(:zDate1,''dd.mm.yyyy''))
) x 
where nvl(x.ost,0) <> 0
group by x.branch ';
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
