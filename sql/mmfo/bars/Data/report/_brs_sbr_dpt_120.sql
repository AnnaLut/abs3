prompt =====================================
prompt == Звіт про дату зміни ліміту кредиту по БПК
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
   l_zpr.name := 'Звіт про дату зміни ліміту кредиту по БПК';
   l_zpr.pkey := '\BRS\SBR\DPT\120';

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
    l_zpr.name         := 'Звіт про дату зміни ліміту кредиту по БПК';
    l_zpr.namef        := 'my.txt';
    l_zpr.bindvars     := ':zDate1=''Дата з (DD.MM.YYYY)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select a.branch,c.NMK,c.okpo,c.rnk,w.CARD_CODE,wc.product_code,wp.grp_code, to_char(a.lim/100) lim_grn,to_char(u.chg_lim,''dd/mm/yyyy''),to_char(b.DAOS,''dd/mm/yyyy'')
from (select * from accounts where nbs =2625 and dazs is null and lim > 0) a 
   inner join w4_acc w on a.acc=w.acc_pk
   inner join w4_card wc on w.card_code=wc.code
   inner join w4_product wp on wc.PRODUCT_CODE=wp.CODE
   inner join customer c on a.rnk=c.rnk 
   inner join (select acc,daos from accounts where nbs =9129 and dazs is null) b on b.acc=w.acc_9129
   inner join 
(SELECT a.acc,  max(a.chgdate) chg_lim
  FROM accounts_update a, accounts_update b
 WHERE  a.acc = b.acc
   AND (   a.LIM <> b.LIM
        OR a.LIM IS NULL AND b.LIM IS NOT NULL
        OR a.LIM IS NOT NULL AND b.LIM IS NULL
       )
   AND a.idupd =
          (SELECT MIN (idupd)
             FROM accounts_update
            WHERE acc = b.acc
              AND idupd > b.idupd
              AND (   LIM <> b.LIM
                   OR LIM IS NULL AND b.LIM IS NOT NULL
                   OR LIM IS NOT NULL AND b.LIM IS NULL
                  ))
   AND b.idupd =
          (SELECT MAX (idupd)
             FROM accounts_update
            WHERE acc = a.acc
              AND idupd < a.idupd
              AND (   LIM <> a.LIM
                   OR LIM IS NULL AND a.LIM IS NOT NULL
                   OR LIM IS NOT NULL AND a.LIM IS NULL
                  ))
 GROUP BY a.acc ) u on a.acc=u.acc
ORDER BY a.BRANCH,c.RNK';
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
