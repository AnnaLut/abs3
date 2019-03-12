

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_20331.sql =========*** Run
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == ЗДК: ТВБВ: Реєстр операцій (новий)
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
   l_zpr.name := 'ЗДК: ТВБВ: Реєстр операцій (новий)';
   l_zpr.pkey := '\BRS\SBM\REP\20331';

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
    l_zpr.name         := 'ЗДК: ТВБВ: Реєстр операцій (новий)';
    l_zpr.namef        := '=''ZD3_4''||substr(:sFdat1,1,2)||substr(:sFdat1,4,2)||''.''||user_id';
    l_zpr.bindvars     := ':sFdat1='''',:SHIFT=''№ зміни''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep20331.frx';
    l_zpr.form_proc    := 'bars_cash.make_report_data( to_date(:sFdat1), :SHIFT, 0,0, ''RO'')';
    l_zpr.default_vars := ':SHIFT=''1''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select  flg, :SHIFT shift,  to_number(substr(nls,1,1)) nlstype,'||nlchr||
                           '             nls, a.kv, t.name kvname, nms, ostf, sdb,  skr,  sdbq,  skrq, '||nlchr||
                           '             sq,   obdb, obkr, ost,  tt, ttname, '''' fio, doccnt, '||nlchr||
                           '            to_char(stime,''hh24:mi'') stime,  to_char(etime,''hh24:mi'') etime, f_dat_lit(:sFdat1) STR_DAT1,'||nlchr||
                           '           sys_context(''bars_context'',''user_branch'') branch,  b.name branchname'||nlchr||
                           ' from  ('||nlchr||
                           '        select 0 flg,  substr(nls,1,1) nls, t.kv,  '''' nms,   0 ostf,   t.tt,  tts.name ttname,  ''''  fio,'||nlchr||
                           '               sum(  decode(optype, 0, t.s, 0))  sdb,    sum(  decode(optype, 1, t.s, 0)) skr, '||nlchr||
                           '               sum(  decode(optype, 0, t.sq, 0))  sdbq,    sum(  decode(optype, 1, t.sq, 0)) skrq, '||nlchr||
                           '               sum(t.sq) sq,'||nlchr||
                           '               0 obdb, 0 obkr, 0 ost, '||nlchr||
                           '               stime, etime, count(*) doccnt                   '||nlchr||
                           '          from tmp_cashpayed t,    tts '||nlchr||
                           '         where datatype = ''0''   and t.tt = tts.tt'||nlchr||
                           '         group by substr(nls,1,1), t.kv, t.tt, tts.name, stime, etime'||nlchr||
                           '         union all'||nlchr||
                           '        select 0 flg,  ''2''  nls,  t.kv,  '''' nms,  0 ostf,  t.tt, tts.name  ttname,  ''''  fio,'||nlchr||
                           '               sum(  decode(optype, 0, t.s, 0))  sdb,   sum(  decode(optype, 1, t.s, 0))  skr, '||nlchr||
                           '               sum(  decode(optype, 0, t.sq, 0))  sdbq,    sum(  decode(optype, 1, t.sq, 0)) skrq, '||nlchr||
                           '               sum(t.sq) sq,'||nlchr||
                           '               0 obdb, 0 obkr, 0 ost, stime, etime, count(*) doccnt'||nlchr||
                           '          from tmp_cashpayed t,  tts'||nlchr||
                           '          where datatype = ''1'' and t.tt = tts.tt'||nlchr||
                           '          group by t.kv, t.tt, tts.name, stime, etime'||nlchr||
                           '          union all       '||nlchr||
                           '         select 1 flg, nls, kv, nms, ostf, '''' tt,  '''' ttname, '''' fio, '||nlchr||
                           '                0 sdb, 0 skr, 0 sdbq, 0 skrq, 0 sq, obdb, obkr, ost, stime, etime, 0'||nlchr||
                           '          from tmp_cashpayed'||nlchr||
                           '         where datatype = ''2'''||nlchr||
                           '      ) a, tabval t, branch b'||nlchr||
                           'where a.kv = t.kv and b.branch = sys_context(''bars_context'',''user_branch'')'||nlchr||
                           'order by substr(nls,1,1),  fio,   flg, kv,   tt , obdb,  nls';
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
    l_rep.description :='ЗДК: ТВБВ: Реєстр операцій (новий)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,TRUE';
    l_rep.ndat        :=1;
    l_rep.mask        :='ZD3_4*.*';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 82; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 20331;


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

exec umu.add_report2arm(20331,'$RM_BVBB');
exec umu.add_report2arm(20331,'$RM_BUHG');
exec umu.add_report2arm(20331,'$RM_WDOC');
exec umu.add_report2arm(20331,'$RM_DRU1');
exec umu.add_report2arm(20331,'$RM_MAIN');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_20331.sql =========*** End
PROMPT ===================================================================================== 
