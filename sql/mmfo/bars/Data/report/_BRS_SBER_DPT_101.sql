prompt ===================================== 
prompt == Виписка з рахунку в нац.валюті (%% та податки)
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
   l_zpr.name := 'Виписка з рахунку в нац.валюті (%% та податки)';
   l_zpr.pkey := '\BRS\SBER\DPT\101';

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
    l_zpr.name         := 'Виписка з рахунку в нац.валюті (%% та податки)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param0=''№ вкладу''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'DPT_5611.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select  d.deposit_id, d.nd, v.vidd, v.type_name, t.kv, t.lcv, t.name,'||nlchr||
                           '            c.rnk, c.nmk,'||nlchr||
                           '            :sFdat1 dat1,'||nlchr||
                           '            :sFdat2 dat2,'||nlchr||
                           '            a.nls NLSP,   '||nlchr||
                           '                ap.nls,      '||nlchr||
                           '                 sum(  case when o.tt =''%%1'' and dk = 1 then o.s'||nlchr||
                           '                  else 0 end)/100 nar,'||nlchr||
                           '                 sum(  case when o.tt =''%%1'' and dk = 1 then o.sq'||nlchr||
                           '                 else 0 end)/100 narq,'||nlchr||
                           '                 sum(  case when o.tt =''%15'' and dk = 0 then o.s'||nlchr||
                           '                          else 0 end)/100 tax,'||nlchr||
                           '                 sum(  case when o.tt =''%15'' and dk = 0 then o.sq'||nlchr||
                           '                 else 0 end)/100 taxq,        '||nlchr||
                           '                 sum(  case when o.tt =''MIL'' and dk = 0 then o.s'||nlchr||
                           '                          else 0 end)/100 mil,'||nlchr||
                           '                 sum(  case when o.tt =''MIL'' and dk = 0 then o.sq'||nlchr||
                           '                 else 0 end)/100 milq,        '||nlchr||
                           '            sum(  case when o.tt =''%%1'' and dk = 1 then o.s'||nlchr||
                           '                else 0 end)/100 -'||nlchr||
                           '            sum(  case when o.tt =''%15'' and dk = 0 then o.s'||nlchr||
                           '                else 0 end)/100 -'||nlchr||
                           '            sum(  case when o.tt =''MIL'' and dk = 0 then o.s'||nlchr||
                           '                else 0 end)/100 pay,'||nlchr||
                           '            (gl.p_icurval(t.kv,'||nlchr||
                           '                       sum(  case when o.tt =''%%1'' and dk = 1 then o.s'||nlchr||
                           '                           else 0 end) -'||nlchr||
                           '                       sum(  case when o.tt =''%15'' and dk = 0 then o.s'||nlchr||
                           '                           else 0 end) -'||nlchr||
                           '                       sum(  case when o.tt =''MIL'' and dk = 0 then o.s'||nlchr||
                           '                           else 0 end),'||nlchr||
                           '                      :sFdat2))/100 payq,'||nlchr||
                           '            sum(  case when o.tt =''%%1'' and dk = 1 then o.sq'||nlchr||
                           '                else 0 end)/100 -'||nlchr||
                           '            sum(  case when o.tt =''%15'' and dk = 0 then o.sq'||nlchr||
                           '                else 0 end)/100 -'||nlchr||
                           '            sum(  case when o.tt =''MIL'' and dk = 0 then o.sq'||nlchr||
                           '                else 0 end)/100 payq1,'||nlchr||
                           '                fost(a.acc, bankdate)/100 ost'||nlchr||
                           '         from dpt_deposit_clos d,'||nlchr||
                           '                accounts        a,'||nlchr||
                           '                int_accn        i,'||nlchr||
                           '                accounts        ap,'||nlchr||
                           '                dpt_vidd        v,'||nlchr||
                           '                customer        c,'||nlchr||
                           '                tabval          t,'||nlchr||
                           '                opldok          o, saldoa s           '||nlchr||
                           '          where i.acra = s.acc'||nlchr||
                           '            and s.acc = o.acc '||nlchr||
                           '            and s.fdat = o.fdat'||nlchr||
                           '            and A.ACC =i.acra'||nlchr||
                           '            and AP.ACC = i.acc'||nlchr||
                           '            and s.fdat between :sFdat1 and :sFdat2'||nlchr||
                           '            and o.fdat between :sFdat1 and :sFdat2'||nlchr||
                           '            and d.acc    = i.acc'||nlchr||
                           '            and i.id     = 1'||nlchr||
                           '            and d.kv     = t.kv'||nlchr||
                           '            and d.vidd   = v.vidd'||nlchr||
                           '            and o.tt in (''%%1'',''%15'', ''MIL'')           '||nlchr||
                           '            and d.rnk    = c.rnk           '||nlchr||
                           '            and d.action_id = 0           '||nlchr||
                           '            and d.deposit_id = :Param0'||nlchr||
                           '            group by d.deposit_id, d.nd, v.vidd, v.type_name, t.kv, t.lcv, t.name, a.nls,ap.nls,c.rnk, c.nmk, d.kv, a.acc';
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
    l_rep.description :='Виписка з рахунку в нац.валюті (%% та податки)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 99; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5611;


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
