prompt ===================================== 
prompt == Звіт по не нарахованим та не перерахованим відсоткам
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
   l_zpr.name := 'Звіт по не нарахованим відсоткам';
   l_zpr.pkey := '\BRS\SBR\DPT\6444';

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
    l_zpr.name         := 'Звіт по не нарахованим відсоткам';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_6444.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          :=  'with t as ( select'||nlchr||
                           '                   dat_next_u(:sFdat1, -1) + 1 dt '||nlchr||
                           '              from dual),'||nlchr||
                           '     job_log as ( select djl.dpt_id, djl.errmsg '||nlchr||
                           '                  from dpt_jobs_log djl,'||nlchr||
                           '                       dpt_jobs_jrnl djj'||nlchr||
                           '                  where djj.job_id = 275'||nlchr||
                           '                    and djj.bank_date = :sFdat1'||nlchr||
                           '                    and djj.kf =  sys_context(''bars_context'',''user_mfo'')'||nlchr||
                           '                    and djl.run_id = djj.run_id'||nlchr||
                           '                    and djl.status = -1) '||nlchr||
                           'select tt.* ,'||nlchr||
                           'case when tt.op = 1 then'||nlchr||
                           'tt.br_value + tt.ir'||nlchr||
                           'when tt.op = 2 then'||nlchr||
                           'tt.br_value - tt.ir'||nlchr||
                           'when tt.op = 3 then'||nlchr||
                           'tt.br_value * tt.ir'||nlchr||
                           'when tt.op = 4 then'||nlchr||
                           'tt.br_value / decode(nvl(tt.ir,1),0,1,nvl(tt.ir,1))'||nlchr||
                           'else tt.br_value + tt.ir end total_rate_value,'||nlchr||
                           'to_char(tt.acr_dat + 1,''DD.MM.YYYY'')||'' - ''||to_char(tt.plan_dat, ''DD.MM.YYYY'') period,'||nlchr||
                           'jl.errmsg'||nlchr||
                           'from '||nlchr||
                           '(select  '||nlchr||
                           '         v.vidd,'||nlchr||
                           '         v.type_name,'||nlchr||
                           '         v.kv,'||nlchr||
                           '         d.dat_begin,'||nlchr||
                           '         d.dat_end,'||nlchr||
                           '         ir.br,'||nlchr||
                           '         nvl ((SELECT rate FROM br_normal bn'||nlchr||
                           '         WHERE br_id= ir.br AND kv = a.kv AND'||nlchr||
                           '         bdate = (SELECT MAX(bdate) FROM br_normal'||nlchr||
                           '         WHERE bdate<= :sFdat1 AND br_id= bn.br_id AND kv= bn.kv)), 0) br_value,'||nlchr||
                           '         ir.ir,'||nlchr||
                           '         ir.op,'||nlchr||
                           '         fost(a.acc, dat_next_u(add_months(trunc(to_date (:sFdat1,''dd.mm.yyyy''), ''MM''), -1), -1)) ost_last_mdate,'||nlchr||
                           '         d.deposit_id,'||nlchr||
                           '         a.nls       acc_name,'||nlchr||
                           '         aint.nls    intacc_name,'||nlchr||
                           '         d.rnk,'||nlchr||
                           '         i.acr_dat,'||nlchr||
                           '         i.stp_dat,'||nlchr||
                           '         d.branch,'||nlchr||
                           '         b.name branch_name,'||nlchr||
                           '         dpt.get_intpaydate(:sFdat1,'||nlchr||
                           '         d.dat_begin,'||nlchr||
                           '         d.dat_end,'||nlchr||
                           '         d.freq,'||nlchr||
                           '         decode(v.amr_metr, 0, 0, 1),'||nlchr||
                           '         decode(nvl(d.cnt_dubl, 0), 0, 0, 1),'||nlchr||
                           '         1) plan_dat'||nlchr||
                           'from dpt_deposit d'||nlchr||
                           '      ,accounts a'||nlchr||
                           '      ,dpt_vidd v'||nlchr||
                           '      ,int_accn i'||nlchr||
                           '      ,int_ratn ir'||nlchr||
                           '      ,accounts aint'||nlchr||
                           '      ,branch b'||nlchr||
                           'where 1 = 1  '||nlchr||
                           '  and a.kf = sys_context(''bars_context'',''user_mfo'')'||nlchr||
                           '  and a.acc = d.acc'||nlchr||
                           '  and v.vidd = d.vidd'||nlchr||
                           '  and i.acc = a.acc'||nlchr||
						   '  and a.nbs = ''2630'''||nlchr||
                           '  and i.id = 1'||nlchr||
                           '  and aint.acc = i.acra'||nlchr||
                           '  and b.branch = d.branch'||nlchr||
                           '  and ir.acc = a.acc'||nlchr||
                           '  and ir.bdat = (select max(bdat) from int_ratn ii where ii.acc = a.acc and bdat <=  :sFdat1)'||nlchr||
                           ' ) tt,'||nlchr||
                           ' t,'||nlchr||
                           ' job_log jl'||nlchr||
                           ' where ((tt.acr_dat is null) or'||nlchr||
                           '(tt.acr_dat < tt.plan_dat - 1 and tt.stp_dat is null) or'||nlchr||
                           '(tt.acr_dat < tt.plan_dat - 1 and tt.stp_dat > tt.acr_dat))'||nlchr||
                           'and tt.plan_dat between t.dt and  :sFdat1'||nlchr||
                           'and jl.dpt_id (+) = tt.deposit_id';
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
    l_rep.description :='Звіт по не нарахованим відсоткам';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat1,sFdat,"",FALSE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 160; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 6444;


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
               ('$RM_WEBP', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в "АРМ Робота з клієнтом (WEB)"';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в "АРМ Робота з клієнтом (WEB)"';
    end;
        
     	
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     
