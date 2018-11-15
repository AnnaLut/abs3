prompt ===================================== 
prompt == ЗДК: ТВБВ: Реєстр операцій (новий) (3)
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
   l_zpr.name := 'ЗДК: ТВБВ: Реєстр операцій (новий) (3)';
   l_zpr.pkey := '\BRS\SBM\REP\1331';

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
    l_zpr.name         := 'ЗДК: ТВБВ: Реєстр операцій (новий) (3)';
    l_zpr.namef        := '=''ZD3_4''||substr(:sFdat1,1,2)||substr(:sFdat1,4,2)||''.''||user_id';
    l_zpr.bindvars     := ':sFdat1='''',:SHIFT=''№ зміни''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'sbm_zk4.qrp';
    l_zpr.form_proc    := 'bars_cash.make_report_data3( to_date(:sFdat1), :SHIFT, 0,0, ''RO'')';
    l_zpr.default_vars := ':SHIFT=''1''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select  flg, :SHIFT shift,  to_number(substr(nls,1,1)) nlstype,
             nls, a.kv, t.name kvname, nms, ostf, sdb,  skr,  sdbq,  skrq, 
             sq,   obdb, obkr, ost,  tt, ttname, '''' fio, doccnt, 
            to_char(stime,''hh24:mi'') stime,  to_char(etime,''hh24:mi'') etime  
 from  (
        select 0 flg,  substr(nls,1,1) nls, t.kv,  '''' nms,   0 ostf,   t.tt,  tts.name ttname,  ''''  fio,
               sum(  decode(optype, 0, t.s, 0))  sdb,    sum(  decode(optype, 1, t.s, 0)) skr, 
               sum(  decode(optype, 0, t.sq, 0))  sdbq,    sum(  decode(optype, 1, t.sq, 0)) skrq, 
               sum(t.sq) sq,
               0 obdb, 0 obkr, 0 ost, 
               stime, etime, count(*) doccnt                   
          from tmp_cashpayed t,    tts 
         where datatype = ''0''   and t.tt = tts.tt
         group by substr(nls,1,1), t.kv, t.tt, tts.name, stime, etime
         union all
        select 0 flg,  ''2''  nls,  t.kv,  '''' nms,  0 ostf,  t.tt, tts.name  ttname,  ''''  fio,
               sum(  decode(optype, 0, t.s, 0))  sdb,   sum(  decode(optype, 1, t.s, 0))  skr, 
               sum(  decode(optype, 0, t.sq, 0))  sdbq,    sum(  decode(optype, 1, t.sq, 0)) skrq, 
               sum(t.sq) sq,
               0 obdb, 0 obkr, 0 ost, stime, etime, count(DISTINCT  ref) doccnt
          from tmp_cashpayed t,  tts
          where datatype = ''1'' and t.tt = tts.tt
          group by t.kv, t.tt, tts.name, stime, etime
          union all       
         select 1 flg, nls, kv, nms, ostf, '''' tt,  '''' ttname, '''' fio, 
                0 sdb, 0 skr, 0 sdbq, 0 skrq, 0 sq, obdb, obkr, ost, stime, etime, 0
          from tmp_cashpayed 
         where datatype = ''2''
      ) a, tabval t
where a.kv = t.kv
order by substr(nls,1,1),  fio,   flg, kv,   tt , obdb,  nls';
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
    l_rep.description :='ЗДК: ТВБВ: Реєстр операцій (новий) (3)';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,TRUE';
    l_rep.ndat        :=1;
    l_rep.mask        :='ZD3_4*.*';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 1331;


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

   umu.add_report2arm(  p_report_id => 1331,
                        p_arm_code  => '$RM_WDOC',
                        p_approve   => 1);

   umu.add_report2arm(  p_report_id => 1331,
                        p_arm_code  => '$RM_WCAS',
                        p_approve   => 1);




end;                                        
/                                           
                                            
commit;                                     
