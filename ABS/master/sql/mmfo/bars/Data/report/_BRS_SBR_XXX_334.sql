prompt ===================================== 
prompt == Обороти по рахунках
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

  l_zpr.pkey := '\BRS\SBR\***\334';

  l_message  := 'Ключ запроса: '||l_zpr.pkey||'  '||nlchr;

  begin
     select kodz, kodr
       into l_zpr.kodz, l_zpr.kodr
       from zapros
      where pkey=l_zpr.pkey;
  exception
    when no_data_found then
      l_isnew:=1;
      select s_zapros.nextval
        into l_zpr.kodz
        from dual;
  end;

  ------------------------
  --  main query        --
  ------------------------
  l_zpr.id           := 1;
  l_zpr.name         := 'Обороти по рахунках';
  l_zpr.namef        := 'oborotu';
  l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param=''Групування по БР/номеру рахунку (0/1)'',:nbs=''Балансовий рахунок''';
  l_zpr.create_stmt  := '';
  l_zpr.rpt_template := '';
  l_zpr.form_proc    := '';
  l_zpr.default_vars := ':Param=''0''';
  l_zpr.bind_sql     := '';
  l_zpr.xml_encoding := 'CL8MSWIN1251';
  l_zpr.txt          := 'select *'||nlchr||
                        '  from ( select nvl(nbs1,''Всього:'')  "Балансовий_рахунок",'||nlchr||
                        '                kv1 as "Код_валюти",'||nlchr||
                        '                sum(od) as "Обороти_по_Дебету",'||nlchr||
                        '                sum(ok) AS "Обороти_по_Кредиту"'||nlchr||
                        '           from ( select decode(:Param,0,a.nbs,a.nls)  nbs1, a.kv kv1,'||nlchr||
                        '                         sum(gl.p_icurval(a.kv, fdos(a.acc, d.dat, d.dat), d.dat))/100 od,'||nlchr||
                        '                         sum(gl.p_icurval(a.kv, fkos(a.acc, d.dat, d.dat), d.dat))/100 ok '||nlchr||
                        '                    from accounts a'||nlchr||
                        '                       , (select to_date(:sFdat1,''dd/mm/yyyy'') + num-1  dat '||nlchr||
                        '                            from conductor '||nlchr||
                        '                           where num <= (to_date(:sFdat2,''dd/mm/yyyy'') - to_date(:sFdat1,''dd/mm/yyyy'')+1)'||nlchr||
                        '                         ) d'||nlchr||
                        '                   where nbs = :nbs '||nlchr||
                        '                   group by decode(:Param,0,a.nbs,a.nls), a.kv'||nlchr||
                        '                )'||nlchr||
                        '          GROUP BY GROUPING SETS ( (nbs1,kv1,od,ok ), () )'||nlchr||
                        '       )'||nlchr||
                        ' order by 2 NULLS FIRST ';
  l_zpr.xsl_data     := '';
  l_zpr.xsd_data     := '';

  if l_isnew = 1
  then
    insert into zapros values l_zpr;
    l_message:=l_message||'Добавлен новый кат.запрос №'||l_zpr.kodz||'.';
  else
    update zapros
       set name         = l_zpr.name,        
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
  l_rep.description :='Обороти по рахунках';
  l_rep.form        :='frm_UniReport';
  l_rep.param       :=l_zpr.kodz||',8,sFdat,sFdat2,"",TRUE,TRUE';
  l_rep.ndat        :=2;
  l_rep.mask        :='oborotu';
  l_rep.usearc      :=0;
  l_rep.idf         :=null;

  -- Фиксированный № печатного отчета
  l_rep.id          := 696;

  if l_isnew = 1
  then
    begin
       insert into reports values l_rep;
       l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
    exception
      when dup_val_on_index then
        bars_error.raise_error('REP',14, to_char(l_rep.id));
    end;
  else
    begin
       insert into reports values l_rep;
       l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
    exception
      when dup_val_on_index then
        l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' изменен.';
        update reports
           set name        = l_rep.name,
               description = l_rep.description,
               form        = l_rep.form,
               param       = l_rep.param,
               ndat        = l_rep.ndat,
               mask        = l_rep.mask,
               usearc      = l_rep.usearc,
               idf         = l_rep.idf
         where id          = l_rep.id;
    end;
  end if;

  bars_report.print_message(l_message);

end;
/

commit;
