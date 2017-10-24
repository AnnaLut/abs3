prompt ===================================== 
prompt == Виписки ГРН, вiддiл., маска рахунку (сорт.по сумi)(en)
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
   l_zpr.name := 'Виписки ГРН, вiддiл., маска рахунку (сорт.по сумi)(en)';
   l_zpr.pkey := '\BRS\SBM\***\6264';

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
    l_zpr.name         := 'Виписки ГРН, вiддiл., маска рахунку (сорт.по сумi)(en)';
    l_zpr.namef        := '= ''VPGRN''||substr(:sFdat1,1,2)||substr(:sFdat1,4,2)||''.''||user_id';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param0=''Маска рахунку (%-всi)'',:OB22=''OБ22(%-всі)'',:BRANCH=''Вiддiлення'',:DEP=''Вкл. пiдлеглих (1-вкл.)'',:INFORM=''Вкл. iнф.повiдомл.(1-вкл.)'',:ISP=''Виконавці (%-всi)'',:NODOCS=''Вкл. без оборотiв (1-вкл.)'',:SRT=''Сортувати по''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_6264.frx';
    l_zpr.form_proc    := 'bars_rptlic.lic_grnb_ob(to_date(:sFdat1), to_date(:sFdat2) , :Param0,  :ISP,  bars_report.get_branch(:BRANCH,:DEP), :INFORM,:OB22 )';
    l_zpr.default_vars := ':Param0=''%'',:BRANCH=''Поточне'',:DEP=''1'',:INFORM=''0'',:ISP=''%'',:NODOCS=''0'',:SRT=''сумi'',:OB22=''%''';
    l_zpr.bind_sql     := '::BRANCH=''V_BRANCH_OWN|BRANCH|NAME'',:ISP=''V_REPCHOOSE_ISP|ID|DESCRIPT|ORDER BY SRT'',:SRT=''V_REPCHOOSE_SORT|ID|DESCRIPT|ORDER BY SRT''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select   '''' fio, '||nlchr||
'       srt,  '||nlchr||
'       v.dksrt,'||nlchr||
'       v.vobsrt,'||nlchr||
'       case when v.okpo=''20077720'' then ''NAFTOGAZ OF UKRAINE'' else  f_translate_kmu(v.nmk) end okpo,'||nlchr||
'       v.okpo,    '||nlchr||
'       v.acc,            '||nlchr||
'       v.nls,            '||nlchr||
'       v.kv,           '||nlchr||
'       ''UAH'' lcv,            '||nlchr||
'       to_char(v.fdat)fdat,           '||nlchr||
'       to_char(v.dapp)dapp,           '||nlchr||
'       v.ostf,           '||nlchr||
'       v.ostf ostfq,           '||nlchr||
'       f_translate_kmu(v.nms),     '||nlchr||
'       v.s,      '||nlchr||
'       v.sq,     '||nlchr||
'       (v.doss)*-1 doss,   '||nlchr||
'       v.koss,   '||nlchr||
'       (v.doss)*-1 dossq,  '||nlchr||
'       v.koss kossq,  '||nlchr||
'       nd,     '||nlchr||
'       mfo2,  '||nlchr||
'       nb2,       '||nlchr||
'       nls2   ,   '||nlchr||
'       nmk2 ,  '||nlchr||
'       okpo2,   '||nlchr||
'       nazn,   '||nlchr||
'       sysdate,'||nlchr||
'       to_char(:sFdat1) d1,'||nlchr||
'       to_char(:sFdat2) d2,  ( SELECT val  FROM params WHERE par=''MFO'' ) mfo,case when mf.val=''300465'' then ''JSC "Oschadbank" 300465'' when  mf.val=''320478'' then '' JSB "UKRGAZBANK" 320478'' else  f_translate_kmu(nm.val)  end ourbank '||nlchr||
'from   ( SELECT val  FROM params WHERE par=''MFO'' ) mf,(SELECT val  FROM params WHERE par=''NAME'')nm,v_rptlic v'||nlchr||
'where   nvl(v.ref, 0)  =  decode(:NODOCS, ''0'',  v.ref,   nvl(v.ref, 0) )  '||nlchr||
'order by '||nlchr||
'         decode(:SRT, ''рахунку'', substr(nls,1,4)||substr(nls,6),  okpo2 ),'||nlchr||
'         nls, kv, srt, dksrt, vobsrt, sign(s),'||nlchr||
'         decode(:SRT, ''датi'',    to_char(fdat, ''yyymmdd''), '||nlchr||
'                                   ''сумi'',    to_char(abs(s), ''000000000000000.00''),'||nlchr||
'                                                 to_char(fdat, ''yyymmdd'')'||nlchr||
'                        ),'||nlchr||
'         ref, bis,  fdat';

    l_zpr.xsl_data     := '';
    l_zpr.xsd_data     := '';

    if l_isnew = 1 then           
       insert into zapros values l_zpr;  
       l_message:=l_message||'Добавлен новый кат.запрос №'||l_zpr.kodz||'.'; 
    else                           
       update zapros set name         = l_zpr.name,        
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
    l_rep.description :='Виписки ГРН, вiддiл., маска рахунку (сорт.по сумi)(en)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='VPGRN*.*';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 210; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 6264;


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
/
begin
  insert into app_rep (codeapp, coderep, approve)
  values ('$RM_WDOC', 6264, 1);
exception when dup_val_on_index then null;
end;
/                     
commit;                
/


