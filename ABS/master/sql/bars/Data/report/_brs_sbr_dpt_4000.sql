prompt =====================================
prompt == Звіт на дату по ф.190 по всіх групах ( успішно сформовані платежі / не сформовані)
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
   l_zpr.name := 'Звіт на дату по ф.190 по всіх групах';
   l_zpr.pkey := '\BRS\SBR\DPT\4000';

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
    l_zpr.name         := 'Звіт на дату по ф.190 по всіх групах';
    l_zpr.namef        := '';
    l_zpr.bindvars     := '';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'DPT4000.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select      sde.TT, 
	sde.kva, 
	c.okpo, 
	sde.nlsa, 
	sde.mfob, 
	sde.okpo as okpo1, 
	sde.nlsb, 
	sto_all.fsumFunction(sde.fsum, sde.kva, sde.kvb, sde.nlsa, sde.nlsb, sde.tt) as fsum_c, 
	sde.nazn, 
	case when sda.ref is not null then 1 else 0 end as form
	from sto_det sde
	join sto_dat sda on sde.idd = sda.idd
	join sto_lst lst on sde.ids = lst.ids
	join customer c on lst.rnk = c.rnk
	where sda.dat = case when (to_date(sysdate, ''dd.mm.yy'') > gl.bd) then to_date(sysdate, ''dd.mm.yy'') else gl.bd end';
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
    l_rep.description :='Звіт на дату по ф.190 по всіх групах';
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
    l_rep.id          := 14000;


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
               ('WEBP', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Регулярні платежі';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Регулярні платежі';
    end;

    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('STO1', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Регулярні платежі';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Регулярні платежі';
    end;

    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('!STO', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Регулярні платежі';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Регулярні платежі';
    end;

    bars_report.print_message(l_message);
end;
/

commit;
