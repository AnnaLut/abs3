prompt ===================================== 
prompt == Інвентаризація залишків за рахунком 2924/07
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
   l_zpr.name := 'Інвентаризація залишків за рахунком 2924/07';
   l_zpr.pkey := '\BRS\SBER\CAC\3129';

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
    l_zpr.name         := 'Інвентаризація залишків за рахунком 2924/07';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'brs_3129.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'with znls as (select acc, nls, kv, nms, fost(acc,to_date(:sFdat1,''dd/mm/yyyy''))/100 ost, branch, ob22 from accounts where tip = ''NLY'' and  nbs = ''2924''),'||nlchr||
                           '     zkar as ('||nlchr||
                           '    select a.branch, a.acc, n.ref1 ref, ok.fdat, ok.s/100 s,  od.s/100 sumsp, (ok.s-nvl(od.s,0))/100 skar, nazn, S.FIO '||nlchr||
                           '      from nlk_ref n '||nlchr||
                           '           join  v_gl a on (n.acc = a.acc and a.tip = ''NLY'' and  a.nbs = ''2924'')'||nlchr||
                           '           left join oper op on op.ref = n.ref1 '||nlchr||
                           '           left join staff$base s on OP.USERID= s.id '||nlchr||
                           '           left join opldok ok on (n.ref1 = ok.ref and ok.dk = 1 and ok.sos = 5 and ok.acc = a.acc and ok.fdat <= to_date(:sFdat1,''dd/mm/yyyy'')) '||nlchr||
                           '           left join (select o.acc, sum(o.s) s, h.ref1 as ref from opldok o, nlk_ref_hist h where h.ref2 = o.ref and h.acc = o.acc and o.dk = 0 and sos = 5 and o.fdat <= to_date(:sFdat1,''dd/mm/yyyy'') group by  o.acc, h.ref1) od on (n.ref1 = od.ref and od.acc = a.acc)'||nlchr||
                           '             ) '||nlchr||
                           'Select b.name branch, nls, kv, nms, ost,  null ref, null fdat, null s, null sumsp, null skar,   rpad(znls.branch,22,''0'')||lpad(acc,10,''0'')||''0''||''00000000'' sort, 0 col'||nlchr||
                           ' from znls , branch b   where b.branch =znls.branch and ost <> 0 '||nlchr||
                           'union all'||nlchr||
                           'Select fio branch, null nls, null kv, nazn nms, null ost, ref, fdat, s, sumsp, skar , rpad(branch,22,''0'')||lpad(acc,10,''0'')||''1''||to_char(fdat,''ddmmyyyy''), 1 col'||nlchr||
                           ' from zkar where skar <> 0'||nlchr||
                           'union all'||nlchr||
                           'Select branch, nls, kv, nms, ost,  null ref, null fdat, null s, null sumsp, null skar,   rpad(znls.branch,22,''0'')||lpad(acc,10,''0'')||''2''||''99999999'', 2 col'||nlchr||
                           ' from znls where  ost <> 0'||nlchr||
                           'Order by  11';
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
    l_rep.description :='Інвентаризація залишків за рахунком 2924/07';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",FALSE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 3129;


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
                                    
begin 
  execute immediate 
    ' insert into app_Rep  (codeapp, coderep, approve) values (''$RM_NLKW'', 3129,1)';
exception when dup_val_on_index then 
  null;
end;
/									
commit;                                     
