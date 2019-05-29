
prompt ===================================== 
prompt == Звіт про роботу автообробника СДО (за день)
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
   l_zpr.name := 'Звіт про роботу автообробника СДО (за день)';
   l_zpr.pkey := '\BRS\SBM\REP\5717';

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
    l_zpr.name         := 'Звіт про роботу автообробника СДО (за день)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:flg_auto_pay=''Автооплата (1-вкл., 0-викл.)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5717.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':flg_auto_pay=''%''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select kf,'||nlchr||
                           '         SUM (all_doc)                  AS all_doc,'||nlchr||
                           '         SUM (doc_create_full_visa)     AS doc_create_full_visa,'||nlchr||
                           '         SUM (doc_not_visa_fdate)       AS doc_not_visa_fdate,'||nlchr||
                           '         SUM (doc_not_oper_time)        AS doc_not_oper_time,'||nlchr||
                           '         SUM (other_doc)                AS other_doc,'||nlchr||
                           '         SUM (doc_create_not_visa)      AS doc_create_not_visa,'||nlchr||
                           '         SUM (doc_double)               AS doc_double'||nlchr||
                           '         from ('||nlchr||
                           'with zap as (select d.mfo_a as kf,'||nlchr||
                           '       count(*) as all_doc, --загальна'||nlchr||
                           '       count(case when d.ref is not null and o.sos=5 and o.nextvisagrp = ''!!'' then 1 else null end) as doc_create_full_visa, --проведено'||nlchr||
                           '       ---не візовані'||nlchr||
                           '       count(case when d.ref is not null and o.sos not in (-1,5) and nvl(d.vdat,trunc(sysdate)) > trunc(sysdate) and o.nextvisagrp <> ''!!'' then 1 else null end) as doc_not_visa_fdate, --майб дата валют'||nlchr||
                           '       count(case when d.ref is not null and o.sos >-1 and to_char(d.insertion_date,''HH24:MI'')>''19:00'' and o.nextvisagrp <> ''!!'' then 1 else null end) as doc_not_oper_time, --після СЕП'||nlchr||
                           '       count(case when d.ref is not null and o.sos not in (-1,5) and (not (nvl(d.vdat,trunc(sysdate)) > trunc(sysdate))) and'||nlchr||
                           '            (not (to_char(d.insertion_date,''HH24:MI'')>''19:00'')) and o.nextvisagrp <> ''!!'' then 1 else null end) as other_doc,'||nlchr||
                           '       count(case when d.ref is not null and o.sos >-1 and o.nextvisagrp <> ''!!'' then 1 else null end) as doc_create_not_visa, --на візуванні'||nlchr||
                           '       null as doc_double'||nlchr||
                           '       from barsaq.doc_import d'||nlchr||
                           '            inner join bars.oper o on (d.ref = o.ref and d.mfo_a= o.kf) '||nlchr||
                           ' where d.insertion_date between trunc(to_date(:sFdat1,''dd.mm.yyyy'')) + 0.00001 and trunc(to_date(:sFdat1,''dd.mm.yyyy'')) + 0.99999'||nlchr||
                           '   and d.flg_auto_pay like :flg_auto_pay'||nlchr||
                           '   and ((d.tt in (''IB1'', ''IB2'') and'||nlchr||
                           '       (d.nls_a not like ''20%'' and d.nls_a not like ''2909%'')) or'||nlchr||
                           '       (d.tt = ''IB5'' and d.nls_a not like ''2909%''))'||nlchr||
                           '      and d.ref is not null'||nlchr||
                           '       group by d.mfo_a'||nlchr||
                           'union all'||nlchr||
                           '----------------------'||nlchr||
                           'select d.mfo_a as kf,'||nlchr||
                           '       count(*) as all_doc, --загальна'||nlchr||
                           '       count(case when d.ref is not null and o.sos=5 and o.nextvisagrp = ''!!'' then 1 else null end) as doc_create_full_visa, --проведено'||nlchr||
                           '       ---не візовані'||nlchr||
                           '       count(case when nvl(d.vdat,trunc(sysdate)) > trunc(sysdate) then 1 else null end) as doc_not_visa_fdate, --майб дата валют'||nlchr||
                           '       count(case when to_char(d.insertion_date,''HH24:MI'')>''19:00'' then 1 else null end) as doc_not_oper_time, --після СЕП'||nlchr||
                           '       count(case when (not (nvl(d.vdat,trunc(sysdate)) > trunc(sysdate))) and (not (to_char(d.insertion_date,''HH24:MI'')>''19:00'')) then 1 else null end) as other_doc,'||nlchr||
                           '       count(case when d.ref is null and d.BOOKING_ERR_MSG is null then 1 else null end) as doc_create_not_visa, --на візуванні'||nlchr||
                           '       null as doc_double'||nlchr||
                           '       from barsaq.doc_import d'||nlchr||
                           '            left join bars.oper o on (d.ref = o.ref and d.mfo_a= o.kf) '||nlchr||
                           ' where d.insertion_date between trunc(to_date(:sFdat1,''dd.mm.yyyy'')) + 0.00001 and trunc(to_date(:sFdat1,''dd.mm.yyyy'')) + 0.99999'||nlchr||
                           '   and d.flg_auto_pay like :flg_auto_pay'||nlchr||
                           '   and ((d.tt in (''IB1'', ''IB2'') and'||nlchr||
                           '       (d.nls_a not like ''20%'' and d.nls_a not like ''2909%'')) or'||nlchr||
                           '       (d.tt = ''IB5'' and d.nls_a not like ''2909%''))'||nlchr||
                           '       and d.BOOKING_ERR_MSG is null'||nlchr||
                           '       and d.ref is null'||nlchr||
                           '       group by d.mfo_a'||nlchr||
                           'union all'||nlchr||
                           '--------------------------'||nlchr||
                           'select o.kf as kf, '||nlchr||
                           '       count(*) as all_doc, --загальна к-ть платежів'||nlchr||
                           '       count(case when o.ref is not null and o.sos=5 and o.nextvisagrp = ''!!'' and t.is_payed =1 then 1 else null end) as doc_create_full_visa, --загальна к-ть проведених документів'||nlchr||
                           '       count(case when o.ref is not null and o.sos not in (-1,5) and nvl(o.vdat,trunc(sysdate)) > trunc(sysdate) and o.nextvisagrp <> ''!!'' then 1 else null end) as doc_not_visa_fdate, --майбутня дата валютування'||nlchr||
                           '       count(case when o.ref is not null and o.sos >-1 and to_char(o.pdat,''HH24:MI'')>''19:00'' and o.nextvisagrp <> ''!!'' then 1 else null end) as doc_not_oper_time, --не операційний час'||nlchr||
                           '       count(case when (o.sos not in (-1,5) and not(nvl(o.vdat,trunc(sysdate)) > trunc(sysdate)) and not(to_char(o.pdat,''HH24:MI'')>''19:00'')) and o.nextvisagrp <> ''!!'' then 1 else null end) as other_doc,'||nlchr||
                           '       count(case when o.ref is not null and o.sos >-1 and o.nextvisagrp <> ''!!'' and t.is_payed =0 then 1 else null end) as doc_create_not_visa, --загальна к-ть не візованих документів'||nlchr||
                           '       null as doc_double       '||nlchr||
                           'from tmp_cl_payment t, oper o'||nlchr||
                           '       where'||nlchr||
                           '       t.ref= o.ref'||nlchr||
                           '       and o.pdat between trunc(to_date(:sFdat1,''dd.mm.yyyy'')) + 0.00001 and trunc(to_date(:sFdat1,''dd.mm.yyyy'')) + 0.99999'||nlchr||
                           '       and t.is_auto_pay like :flg_auto_pay --1 - авто, 0 - вручну'||nlchr||
                           '       and t.type = 1 --платежі'||nlchr||
                           '       and ((o.tt in (''CL1'', ''CL2'') and'||nlchr||
                           '         (o.nlsa not like ''20%'' and o.nlsa not like ''2909%'')) or'||nlchr||
                           '         (o.tt = ''CL5'' and o.nlsa not like ''2909%''))'||nlchr||
                           '       group by o.kf)'||nlchr||
                           '  SELECT kf,'||nlchr||
                           '         SUM (all_doc)                  AS all_doc,'||nlchr||
                           '         SUM (doc_create_full_visa)     AS doc_create_full_visa,'||nlchr||
                           '         SUM (doc_not_visa_fdate)       AS doc_not_visa_fdate,'||nlchr||
                           '         SUM (doc_not_oper_time)        AS doc_not_oper_time,'||nlchr||
                           '         SUM (other_doc)                AS other_doc,'||nlchr||
                           '         SUM (doc_create_not_visa)      AS doc_create_not_visa,'||nlchr||
                           '         SUM (doc_double)               AS doc_double'||nlchr||
                           '    FROM zap'||nlchr||
                           'GROUP BY kf'||nlchr||
                           'union all'||nlchr||
                           '-- дублі С2'||nlchr||
                           'select mfo_a as kf , null as all_doc, null as doc_create_full_visa, null as doc_not_visa_fdate, '||nlchr||
                           '       null as doc_not_oper_time, null as other_doc, null as doc_create_not_visa, sum(doc_double_count) as doc_double_count'||nlchr||
                           '       from (    '||nlchr||
                           '       select di.nd, di.mfo_a, di.mfo_b, di.nls_a, di.nls_b, di.s, trunc(di.datd), count(*) as doc_double_count from barsaq.doc_import di '||nlchr||
                           '                                          inner join bars.oper oo on (di.ref = oo.ref and di.mfo_a= oo.kf) '||nlchr||
                           '           where'||nlchr||
                           '            di.insertion_date between trunc(to_date(:sFdat1,''dd.mm.yyyy'')) + 0.00001 '||nlchr||
                           '                                  and trunc(to_date(:sFdat1,''dd.mm.yyyy'')) + 0.99999'||nlchr||
                           '            and di.ref is not null'||nlchr||
                           '            and oo.sos<>5'||nlchr||
                           '            and ((di.tt in (''IB1'', ''IB2'') and'||nlchr||
                           '                (di.nls_a not like ''20%'' and di.nls_a not like ''2909%'')) or'||nlchr||
                           '                (di.tt = ''IB5'' and di.nls_a not like ''2909%''))'||nlchr||
                           '            group by di.nd, di.mfo_a, di.mfo_b, di.nls_a, di.nls_b, di.s, trunc(di.datd) having count(*)>1 )'||nlchr||
                           '  group by  mfo_a, doc_double_count  '||nlchr||
                           ' ----------------------'||nlchr||
                           ' union all'||nlchr||
                           ' select mfo_a as kf , null as all_doc, null as doc_create_full_visa, null as doc_not_visa_fdate, '||nlchr||
                           '       null as doc_not_oper_time, null as other_doc, null as doc_create_not_visa, sum(doc_double_count) as doc_double_count'||nlchr||
                           '       from (    '||nlchr||
                           '       select di.nd, di.mfo_a, di.mfo_b, di.nls_a, di.nls_b, di.s, trunc(di.datd), count(*) as doc_double_count from barsaq.doc_import di '||nlchr||
                           '           where'||nlchr||
                           '            di.ref is null and '||nlchr||
                           '            di.insertion_date between trunc(to_date(:sFdat1,''dd.mm.yyyy'')) + 0.00001 '||nlchr||
                           '                                  and trunc(to_date(:sFdat1,''dd.mm.yyyy'')) + 0.99999'||nlchr||
                           '            and ((di.tt in (''IB1'', ''IB2'') and'||nlchr||
                           '                (di.nls_a not like ''20%'' and di.nls_a not like ''2909%'')) or'||nlchr||
                           '                (di.tt = ''IB5'' and di.nls_a not like ''2909%''))'||nlchr||
                           '            group by di.nd, di.mfo_a, di.mfo_b, di.nls_a, di.nls_b, di.s, trunc(di.datd) having count(*)>1 )'||nlchr||
                           '  group by  mfo_a, doc_double_count  '||nlchr||
                           ' ------------------------'||nlchr||
                           '--дублі CL'||nlchr||
                           'union all'||nlchr||
                           ' select kf, null as all_doc, null as doc_create_full_visa, null as doc_not_visa_fdate, '||nlchr||
                           '              null as doc_not_oper_time, null as other_doc, null as doc_create_not_visa, sum(doc_double_count) as doc_double_count'||nlchr||
                           '               from '||nlchr||
                           '        (select o.kf, o.ND, o.MFOA, o.MFOB, o.NLSA, o.NLSB, o.S, count(*) as doc_double_count'||nlchr||
                           '                  from oper o, tmp_cl_payment t'||nlchr||
                           '         where     t.ref = o.ref'||nlchr||
                           '               and o.sos<>5'||nlchr||
                           '               and o.pdat between trunc (to_date ( :sFdat1, ''dd.mm.yyyy'')) + 0.00001'||nlchr||
                           '                              and trunc (to_date ( :sFdat1, ''dd.mm.yyyy'')) + 0.99999'||nlchr||
                           '               and t.type = 1                                                --платежі'||nlchr||
                           '               and (   (    o.tt in (''CL1'', ''CL2'')'||nlchr||
                           '                        and (o.nlsa not like ''20%'' and o.nlsa not like ''2909%''))'||nlchr||
                           '                    or (o.tt = ''CL5'' and o.nlsa not like ''2909%''))  '||nlchr||
                           '               group by o.kf, o.ND, o.MFOA, o.MFOB, o.NLSA, o.NLSB, o.S having count(*)>1    '||nlchr||
                           '              )  '||nlchr||
                           '   group by kf, doc_double_count                     '||nlchr||
                           ')'||nlchr||
                           'group by kf';
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
    l_rep.description :='Звіт про роботу автообробника СДО (за день)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',19,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5717;


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
