prompt ===================================== 
prompt == Журнал вiдкритих рахункiв (new)
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

  l_zpr.pkey := '\BRS\SBM\REP\24\02';

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
  l_zpr.name         := 'Журнал вiдкритих рахункiв (new)';
  l_zpr.namef        := '= ''VPVAL''||substr(:sFdat1,1,2)||substr(:sFdat1,4,2)||''.''||replace( substr(:BRANCH, 9),''/'',''_'')';
  l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param0=''Маска рахунку'',:BRANCH=''Відділення'',:P_SUB=''%-з підлеглими відділеннями''';
  l_zpr.create_stmt  := '';
  l_zpr.rpt_template := 'z484m02.qrp';
  l_zpr.form_proc    := 'P_ch_bind(:sFdat1,:sFdat2,:Param0,31,0)';
  l_zpr.default_vars := ':Param0=''%''';
  l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME|ORDER BY BRANCH''';
  l_zpr.xml_encoding := 'CL8MSWIN1251';
  l_zpr.txt          := ' select 
       :sFdat1                         dat1,
       :sFdat2                         dat2,          
       u.branch                        branch,
       c.nmk                           nmk,
       to_char(u.isp)                  isp, 
       c.okpo                          okpo,   
       a.ob22                          ob22, 
       u.pos                           pos, 
       u.blkd                          blkd, 
       u.blkk                          blkk,   
       to_char(u.chgdate,''DD/MM/YYYY'') CHGDATE,   
       u.nls                           nls, 
       u.nms                           nms, 
       u.kv                            kv, 
       t.lcv                           lcv,   
       u.daos                          daos, 
       u.dazs                          dazs,   
       to_char(u.chgdate,''DD/MM/YYYY hh24:mi:ss'') moddate,   
       to_char(u.chgaction)            chgact,      
       0                               vrmod,   
       decode(to_date(:sFdat1, ''dd/mm/yyyy''), 
              to_date(:sFdat2, ''dd/mm/yyyy''),0,1) period,
       u.tobo TVBV, 
       :Param0 MASKA   
  from accounts_update u, accounts a, customer c, tabval t   
 where u.acc = a.acc
   and u.chgdate between to_date(:sFdat1, ''dd/mm/yyyy'') and to_date(:sFdat2, ''dd/mm/yyyy'') + 1
   and u.chgaction = 1
   and u.rnk = c.rnk
   and u.kv  = t.kv
   and u.nls like :Param0
   and (u.branch like :BRANCH ||:P_SUB or u.tobo like :BRANCH ||:P_SUB)  
   and (u.branch like sys_context(''bars_context'',''user_branch_mask'') or
        u.tobo   like sys_context(''bars_context'',''user_branch_mask''))
order by u.chgdate, u.rnk, u.acc, u.idupd';
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
     where pkey         = l_zpr.pkey;
    l_message:=l_message||'Кат.запрос c таким ключем уже существует под №'||l_zpr.kodz||', его параметры изменены.';
  end if;

    ------------------------    
    --  report            --    
    ------------------------    
    l_rep.name        :='Empty';
    l_rep.description :='Журнал вiдкритих рахункiв (new)';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='VPVAL*.*';
    l_rep.usearc      :=0;
    
    begin
      select idf into l_repfolder from reportsf where idf = 333;
    exception
      when no_data_found then
        l_repfolder := null;
    end;

    l_rep.idf         := l_repfolder;

    -- Фиксированный № печатного отчета
    l_rep.id          := 2131;

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

    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('WCIM', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Друк звітів';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Друк звітів';
    end;


    bars_report.print_message(l_message);

end;
/

commit;
