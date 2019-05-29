
prompt ===================================== 
prompt == Звіт про поточну роботу автообробника СДО
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
   l_zpr.name := 'Звіт про поточну роботу автообробника СДО';
   l_zpr.pkey := '\BRS\SBR\REP\5718';

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
    l_zpr.name         := 'Звіт про поточну роботу автообробника СДО';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:flg_auto_pay=''Автооплата (1-вкл., 0-викл.)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5718.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':flg_auto_pay=''%''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'with myoper as'||nlchr||
                           '('||nlchr||
                           'select *'||nlchr||
                           'from bars.oper  partition for (:sFdat1)  o'||nlchr||
                           'where'||nlchr||
                           '((o.tt in (''IB1'', ''IB2'', ''CL1'', ''CL2'') and (o.nlsa not like ''20%'' and o.nlsa not like ''2909%'')) or (o.tt in (''IB5'', ''CL5'') and o.nlsa not like ''2909%''))'||nlchr||
                           '   and o.sos not in (-1,5)'||nlchr||
                           '   and o.nextvisagrp <> ''!!'' '||nlchr||
                           '),'||nlchr||
                           'zap as ('||nlchr||
                           '--C2'||nlchr||
                           'select o.kf,'||nlchr||
                           '       case when o.sos<>5 and o.nextvisagrp <> ''!!'' then o.ref else null end as doc_create_not_full_visa, -- не проведено'||nlchr||
                           '       ---не візовані'||nlchr||
                           '       case when o.sos not in (-1,5) and nvl(d.vdat,trunc(sysdate)) > trunc(sysdate) and o.nextvisagrp <> ''!!'' then o.ref else null end as doc_not_visa_fdate, --майб дата валют'||nlchr||
                           '       case when o.sos >-1 and to_char(d.insertion_date,''HH24:MI'')>''19:00'' and o.nextvisagrp <> ''!!'' then o.ref else null end as doc_not_oper_time, --після СЕП'||nlchr||
                           '       case when o.sos not in (-1,5) and (not (nvl(d.vdat,trunc(sysdate)) > trunc(sysdate))) and'||nlchr||
                           '            (not (to_char(d.insertion_date,''HH24:MI'')>''19:00'')) and o.nextvisagrp <> ''!!'' then o.ref else null end as other_doc,'||nlchr||
                           '       case when o.sos >-1 and o.nextvisagrp <> ''!!'' then o.ref else null end as doc_create_not_visa, --на візуванні'||nlchr||
                           '       null as doc_double'||nlchr||
                           '       from  myoper o inner join barsaq.doc_import d on (d.ref = o.ref) '||nlchr||
                           ' where d.flg_auto_pay like :flg_auto_pay  '||nlchr||
                           '  and o.tt in (''IB1'', ''IB2'',''IB5'')'||nlchr||
                           'union all'||nlchr||
                           '--C2 ref is null завислі доки SDO '||nlchr||
                           'SELECT d.mfo_a as kf,'||nlchr||
                           '       case when d.ref is null then to_number(d.ext_ref) else null end as doc_create_not_full_visa,'||nlchr||
                           '       case when nvl(d.vdat,trunc(sysdate)) > trunc(sysdate) then to_number(d.ext_ref) else null end as doc_not_visa_fdate,'||nlchr||
                           '       case when to_char(d.insertion_date,''HH24:MI'')>''19:00''  then to_number(d.ext_ref) else null end as  doc_not_oper_time,'||nlchr||
                           '       case when (not (nvl(d.vdat,trunc(sysdate)) > trunc(sysdate))) and (not (to_char(d.insertion_date,''HH24:MI'')>''19:00'')) then to_number(d.ext_ref) else null end as other_doc,'||nlchr||
                           '       case when ref is null then to_number(d.ext_ref) else null end as doc_create_not_visa,'||nlchr||
                           '       null as doc_double'||nlchr||
                           '  FROM barsaq.doc_import d'||nlchr||
                           ' WHERE     d.REF IS NULL'||nlchr||
                           '       AND d.flg_auto_pay = 1'||nlchr||
                           '       AND d.insertion_date BETWEEN TO_DATE( :sFdat1, ''dd.mm.yyyy'')+ 0.00001 AND TO_DATE( :sFdat1, ''dd.mm.yyyy'')+ 0.99999     '||nlchr||
                           '       AND ((d.tt in (''IB1'', ''IB2'') and'||nlchr||
                           '                (d.nls_a not like ''20%'' and d.nls_a not like ''2909%'')) or'||nlchr||
                           '                (d.tt = ''IB5'' and d.nls_a not like ''2909%''))'||nlchr||
                           'union all'||nlchr||
                           '--CL'||nlchr||
                           'select o.kf, '||nlchr||
                           '       case when o.ref is not null and o.sos=5 and o.nextvisagrp = ''!!'' and t.is_payed =1 then o.ref else null end as doc_create_not_full_visa, --загальна к-ть проведених документів'||nlchr||
                           '       case when o.ref is not null and o.sos not in (-1,5) and nvl(o.vdat,trunc(sysdate)) > trunc(sysdate) and o.nextvisagrp <> ''!!'' then o.ref else null end as doc_not_visa_fdate, --майбутня дата валютування'||nlchr||
                           '       case when o.ref is not null and o.sos >-1 and to_char(o.pdat,''HH24:MI'')>''19:00'' and o.nextvisagrp <> ''!!'' then o.ref else null end as doc_not_oper_time, --не операційний час'||nlchr||
                           '       case when (o.sos not in (-1,5) and not(nvl(o.vdat,trunc(sysdate)) > trunc(sysdate)) and not(to_char(o.pdat,''HH24:MI'')>''19:00'')) and o.nextvisagrp <> ''!!'' then o.ref else null end as other_doc,'||nlchr||
                           '       case when o.ref is not null and o.sos >-1 and o.nextvisagrp <> ''!!'' and t.is_payed =0 then o.ref else null end as doc_create_not_visa, --загальна к-ть не візованих документів'||nlchr||
                           '       null as doc_double       '||nlchr||
                           'from myoper o inner join tmp_cl_payment t on (o.ref = t.ref)'||nlchr||
                           '       where'||nlchr||
                           '       t.is_auto_pay like :flg_auto_pay --1 - авто, 0 - вручну'||nlchr||
                           '       and t.type = 1 --платежі'||nlchr||
                           '       and o.tt in (''CL1'', ''CL2'',''CL5'')'||nlchr||
                           '      '||nlchr||
                           'union all'||nlchr||
                           '-- дублі С2'||nlchr||
                           'select '||nlchr||
                           '    o.kf, '||nlchr||
                           '    null as doc_create_not_full_visa,  '||nlchr||
                           '    null as doc_not_visa_fdate,   '||nlchr||
                           '    null as doc_not_oper_time,  '||nlchr||
                           '    null as other_doc,  '||nlchr||
                           '    null as doc_create_not_visa,'||nlchr||
                           '    o.ref as doc_double'||nlchr||
                           '    from myoper o '||nlchr||
                           '  where (o.nd, o.mfoa, o.mfob, o.nlsa, o.nlsb, o.s) in'||nlchr||
                           '        ('||nlchr||
                           '        select di.nd,  di.mfo_a,  di.mfo_b,  di.nls_a,  di.nls_b,  di.s '||nlchr||
                           '          from barsaq.doc_import di '||nlchr||
                           '           where'||nlchr||
                           '            di.insertion_date between to_date(:sFdat1,''dd.mm.yyyy'') + 0.00001 '||nlchr||
                           '                                  and to_date(:sFdat1,''dd.mm.yyyy'') + 0.99999'||nlchr||
                           '            and ((di.tt in (''IB1'', ''IB2'') and'||nlchr||
                           '                (di.nls_a not like ''20%'' and di.nls_a not like ''2909%'')) or'||nlchr||
                           '                (di.tt = ''IB5'' and di.nls_a not like ''2909%''))'||nlchr||
                           '        group by di.nd, di.mfo_a, di.mfo_b, di.nls_a, di.nls_b, di.s'||nlchr||
                           '        having count(*)>1'||nlchr||
                           '        )'||nlchr||
                           '    and o.tt in (''IB1'', ''IB2'',''IB5'')    '||nlchr||
                           '--дублі С2 без рефів'||nlchr||
                           'union all '||nlchr||
                           'select '||nlchr||
                           '    o.mfo_a as kf, '||nlchr||
                           '    null as doc_create_not_full_visa,  '||nlchr||
                           '    null as doc_not_visa_fdate,   '||nlchr||
                           '    null as doc_not_oper_time,  '||nlchr||
                           '    null as other_doc,  '||nlchr||
                           '    null as doc_create_not_visa,'||nlchr||
                           '    to_number(o.ext_ref) as doc_double'||nlchr||
                           '    from barsaq.doc_import o '||nlchr||
                           '  where (o.nd, o.mfo_a, o.mfo_b, o.nls_a, o.nls_b, o.s) in'||nlchr||
                           '        ('||nlchr||
                           '        select di.nd,  di.mfo_a,  di.mfo_b,  di.nls_a,  di.nls_b,  di.s '||nlchr||
                           '          from barsaq.doc_import di '||nlchr||
                           '           where'||nlchr||
                           '            di.insertion_date between to_date(:sFdat1,''dd.mm.yyyy'') + 0.00001 '||nlchr||
                           '                                  and to_date(:sFdat1,''dd.mm.yyyy'') + 0.99999'||nlchr||
                           '            and ((di.tt in (''IB1'', ''IB2'') and'||nlchr||
                           '                (di.nls_a not like ''20%'' and di.nls_a not like ''2909%'')) or'||nlchr||
                           '                (di.tt = ''IB5'' and di.nls_a not like ''2909%''))'||nlchr||
                           '        group by di.nd, di.mfo_a, di.mfo_b, di.nls_a, di.nls_b, di.s'||nlchr||
                           '        having count(*)>1'||nlchr||
                           '        )'||nlchr||
                           '    and o.tt in (''IB1'', ''IB2'',''IB5'') '||nlchr||
                           '    and o.flg_auto_pay = 1'||nlchr||
                           '    and o.ref is null'||nlchr||
                           '    and o.insertion_date between to_date(:sFdat1,''dd.mm.yyyy'') + 0.00001 '||nlchr||
                           '                             and to_date(:sFdat1,''dd.mm.yyyy'') + 0.99999'||nlchr||
                           ''||nlchr||
                           '--дублі CL'||nlchr||
                           'union all'||nlchr||
                           'select ooo.kf,'||nlchr||
                           '       null    as doc_create_not_full_visa,'||nlchr||
                           '       null    as doc_not_visa_fdate,'||nlchr||
                           '       null    as doc_not_oper_time,'||nlchr||
                           '       null    as other_doc,'||nlchr||
                           '       null    as doc_create_not_visa,'||nlchr||
                           '       ooo.ref as doc_double'||nlchr||
                           '  from myoper ooo'||nlchr||
                           ' where (ooo.kf, ooo.ND, ooo.MFOA, ooo.MFOB, ooo.NLSA, ooo.NLSB, ooo.S) in'||nlchr||
                           '       ('||nlchr||
                           '        select o.kf, o.ND, o.MFOA, o.MFOB, o.NLSA, o.NLSB, o.S'||nlchr||
                           '        from myoper o'||nlchr||
                           '        where o.tt in (''CL1'', ''CL2'',''CL5'')'||nlchr||
                           '        group by o.kf, o.ND, o.MFOA, o.MFOB, o.NLSA, o.NLSB, o.S'||nlchr||
                           '        having count(*) > 1'||nlchr||
                           '       )'||nlchr||
                           '   and ooo.tt in (''CL1'', ''CL2'',''CL5'')'||nlchr||
                           '   and exists (select 1 from tmp_cl_payment t'||nlchr||
                           '                        where   t.ref = ooo.ref'||nlchr||
                           '                            and t.is_auto_pay like :flg_auto_pay --1 - авто, 0 - вручну) '||nlchr||
                           '                            and t.type = 1) --платежі'||nlchr||
                           '       )'||nlchr||
                           'select * from zap';
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
    l_rep.description :='Звіт про поточну роботу автообробника СДО';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',19,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5718;


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