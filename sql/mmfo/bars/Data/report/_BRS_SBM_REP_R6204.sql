prompt =====================================
prompt == Звiт про куп/прод вал та результат
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
   l_zpr.name := 'Звiт про куп/прод вал та результат';
   l_zpr.pkey := '\BRS\SBM\REP\R6204';

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
    l_zpr.name         := 'Звiт про куп/прод вал та результат';
    l_zpr.namef        := '=';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'r6204.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select to_date(:sFdat1, ''dd.mm.yyyy'') B, to_date(:sFdat2, ''dd.mm.yyyy'') E, b.name, b.branch,  z.kv,  z.kolp, z.prod/100 PROD, z.vyru/100 VYRU, (z.vyru-gl.p_icurval(z.kv, z.prod, to_date(:sFdat2, ''dd.mm.yyyy'')) )/100 p6204, 
                                         z.kolk, z.kupl/100 KUPL, z.zatr/100 ZATR, (gl.p_icurval(z.kv, z.kupl, to_date(:sFdat2, ''dd.mm.yyyy''))-z.zatr )/100 k6204, 
                                         z.vyru - z.zatr + gl.p_icurval(z.kv, z.kupl-z.prod, to_date(:sFdat2, ''dd.mm.yyyy''))/100          s6204, 
                                         (z.kolp+z.kolk) KOL,   (z.kupl-z.prod)/100 VAL,   (z.vyru-z.zatr)/100    GRN
from
(
select a.KV,   p.BRANCH,
       Sum(DECODE(o.dk,1,1,0)) KOLK, Sum(DECODE(o.dk,1,decode(p.kv,980,p.S2,p.S),0)) KUPL, Sum(DECODE(o.dk,1,decode(p.kv,980,p.S,p.S2),0) ) ZATR,
       Sum(DECODE(o.dk,0,1,0)) KOLP, Sum(DECODE(o.dk,0,decode(p.kv,980,p.S2,p.S),0)) PROD, Sum(DECODE(o.dk,0,decode(p.kv,980,p.S,p.S2),0) ) VYRU
from saldoa s, opldok o ,
    (select x.acc, x.kv from vp_list v, accounts x where v.acc3800 = x.acc and x.ob22=''10'') a,
    (select ref, dk, kv, s, kv2, s2, branch  from oper where kv <> kv2 and 980 in (kv, kv2) and ( nlsa like ''10%'' or nlsb like ''10%'') ) p
where s.acc= a.acc and s.fdat >= to_date(:sFdat1,''dd.mm.yyyy'') and s.fdat <= to_date(:sFdat2, ''dd.mm.yyyy'') and s.fdat = o.fdat and s.acc= o.acc and p.ref = o.ref
group by a.KV,   p.BRANCH
) z, branch b
where z.branch = b.branch';
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
    l_rep.description :='Звiт про куп/прод вал та результат';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='*.*';
    l_rep.usearc      :=0;
    begin
        select idf into l_repfolder from reportsf where idf = 70;
    exception when no_data_found then
        l_repfolder := null;
    end;
    l_rep.idf := l_repfolder;

    -- Фиксированный № печатного отчета
    l_rep.id          := 6204;


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