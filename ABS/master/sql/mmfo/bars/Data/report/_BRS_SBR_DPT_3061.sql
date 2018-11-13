prompt ===================================== 
prompt == (FR)Протокол - "Автопереоформлення деп.договорів (FR)"
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
   l_message   varchar2(2000);    

begin     
   l_zpr.name := '(FR)Протокол - "Автопереоформлення деп.договорів"';
   l_zpr.pkey := '\BRS\SBR\DPT\3045';

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
    l_zpr.name         := '(FR)Протокол - "Автопереоформлення деп.договорів"';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:Param0=''0-всі, 1-з помилками''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_3061.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''0''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          :=  'with'||nlchr||
                           'dpzp as ('||nlchr||
                           '    select dbr1.* '||nlchr||
                           '      from dpt_bonus_requests dbr1'||nlchr||
                           '     where dbr1.bonus_id = dpt_bonus.get_bonus_id(''DPZP'') '||nlchr||
                           '       and dbr1.request_state = ''ALLOW'' '||nlchr||
                           '       and dbr1.request_deleted = ''N'' '||nlchr||
                           '       and dbr1.request_bdate = :sFdat1)'||nlchr||
                           ', dpwb as ('||nlchr||
                           '    select dbr2.* '||nlchr||
                           '      from dpt_bonus_requests dbr2'||nlchr||
                           '     where dbr2.bonus_id = dpt_bonus.get_bonus_id(''DPWB'') '||nlchr||
                           '       and dbr2.request_state = ''ALLOW'' '||nlchr||
                           '       and dbr2.request_deleted = ''N'' '||nlchr||
                           '       and dbr2.request_bdate = :sFdat1)'||nlchr||
                           ', excl as ('||nlchr||
                           '    select dbr3.* '||nlchr||
                           '      from dpt_bonus_requests dbr3'||nlchr||
                           '     where dbr3.bonus_id = dpt_bonus.get_bonus_id(''EXCL'') '||nlchr||
                           '       and dbr3.request_state = ''ALLOW'' '||nlchr||
                           '       and dbr3.request_deleted = ''N'' '||nlchr||
                           '        and dbr3.request_bdate = :sFdat1) '||nlchr||
                           ', EXTN as (select dbr3.* '||nlchr||
                           '      from dpt_bonus_requests dbr3'||nlchr||
                           '     where dbr3.bonus_id = dpt_bonus.get_bonus_id(''EXTN'') '||nlchr||
                           '       and dbr3.request_state = ''ALLOW'' '||nlchr||
                           '       and dbr3.request_deleted = ''N'' '||nlchr||
                           '        and dbr3.request_bdate = :sFdat1)        '||nlchr||
                           ', dpt_clos as ('||nlchr||
                           '    select max(ddc.dat_begin) dat_begin_12, ddc.deposit_id'||nlchr||
                           '              from bars.dpt_deposit_clos ddc '||nlchr||
                           '               where nvl(ddc.cnt_dubl,0) = trunc(nvl(ddc.cnt_dubl,0)/12) * 12          '||nlchr||
                           '               group by ddc.deposit_id )'||nlchr||
                           ', jb as('||nlchr||
                           '        select --+ materialize '||nlchr||
                           '                jrnl.job_id JOBID,'||nlchr||
                           '                list.job_name JOBNAME,'||nlchr||
                           '                jrnl.run_id RUNID,'||nlchr||
                           '                jrnl.bank_date BDAT,'||nlchr||
                           '                jrnl.start_date SDAT,'||nlchr||
                           '                jrnl.finish_date FDAT,'||nlchr||
                           '                jrnl.user_id USERID,'||nlchr||
                           '                log.branch BRANCH,'||nlchr||
                           '                log.deal_num DPTNUM,'||nlchr||
                           '                log.nls ACCNUM,'||nlchr||
                           '                log.kv CURID,'||nlchr||
                           '                log.ref REF,'||nlchr||
                           '                log.dpt_sum/100 DPTSUM,'||nlchr||
                           '                log.int_sum/100 INTSUM,'||nlchr||
                           '                log.DPT_ID DPTID,'||nlchr||
                           '                log.rnk,'||nlchr||
                           '                b.name BRANCHNAME,'||nlchr||
                           '                case when log.status = 1 then 0 else 1 end STATUS,'||nlchr||
                           '                substr(log.errmsg,1,250) ERRMSG'||nlchr||
                           '          FROM dpt_jobs_list list,'||nlchr||
                           '               dpt_jobs_jrnl jrnl,'||nlchr||
                           '               v_dpt_jobs_log log,'||nlchr||
                           '               branch b'||nlchr||
                           '         WHERE list.job_code = ''JOB_EXTN'''||nlchr||
                           '            and list.job_id = jrnl.job_id'||nlchr||
                           '            and log.branch like sys_context( ''bars_context'', ''user_branch_mask'' )'||nlchr||
                           '            and jrnl.job_id = log.job_id'||nlchr||
                           '            and jrnl.run_id = log.run_id'||nlchr||
                           '            and jrnl.bank_date = :sFdat1'||nlchr||
                           '            and log.branch = b.branch '||nlchr||
                           '            AND (:Param0 = 0 OR (:Param0 = 1 AND log.status <> 1))'||nlchr||
                           '            )'||nlchr||
                           ', preintrtn as ('||nlchr||
                           '    select  ir.acc'||nlchr||
                           '           ,max(ir.bdat) bdat'||nlchr||
                           '      from jb'||nlchr||
                           '          ,dpt_deposit d'||nlchr||
                           '          ,int_ratn ir  '||nlchr||
                           '      where 1 = 1'||nlchr||
                           '       and jb.dptid = d.deposit_id'||nlchr||
                           '       and ir.acc = d.acc'||nlchr||
                           '       and ir.id = 1 '||nlchr||
                           '       and ir.bdat <= :sFdat1'||nlchr||
                           '    group by ir.acc   '||nlchr||
                           '       )'||nlchr||
                           ', intrtn as ('||nlchr||
                           '    select  nvl(ir.br, 0) br '||nlchr||
                           '           ,ir.acc'||nlchr||
                           '           ,ir.bdat bdat'||nlchr||
                           '      from preintrtn p  '||nlchr||
                           '          ,int_ratn ir  '||nlchr||
                           '      where 1 = 1'||nlchr||
                           '       and p.acc = ir.acc'||nlchr||
                           '       and ir.id = 1 '||nlchr||
                           '       and ir.bdat = p.bdat'||nlchr||
                           '       )'||nlchr||
                           'select   '||nlchr||
                           '        d.vidd CV,'||nlchr||
                           '        v.TYPE_NAME TN,'||nlchr||
                           '        d.dat_begin BG,'||nlchr||
                           '        d.datz DATZ,'||nlchr||
                           '        case when d.wb=''Y'' then ''ТАК'' else ''НІ'' end WB,'||nlchr||
                           '        d.dat_end ED,'||nlchr||
                           '        jb.JOBID JOBID,'||nlchr||
                           '        jb.JOBNAME JOBNAME,'||nlchr||
                           '        jb.RUNID RUNID,'||nlchr||
                           '        jb.BDAT BDAT,'||nlchr||
                           '        jb.SDAT SDAT,'||nlchr||
                           '        jb.FDAT FDAT,'||nlchr||
                           '        jb.USERID USERID,'||nlchr||
                           '        s.fio USERNAME,'||nlchr||
                           '        jb.BRANCH BRANCH,'||nlchr||
                           '        jb.BRANCHNAME BRANCHNAME,'||nlchr||
                           '        jb.DPTNUM DPTNUM,'||nlchr||
                           '        c.okpo OKPO,'||nlchr||
                           '        jb.ACCNUM CCNUM,'||nlchr||
                           '        jb.CURID CURID,'||nlchr||
                           '        t.name CURNAME,'||nlchr||
                           '        jb.REF REF,'||nlchr||
                           '        jb.DPTSUM DPTSUM,'||nlchr||
                           '        jb.INTSUM INTSUM,'||nlchr||
                           '        jb.DPTID DPTID,'||nlchr||
                           '        d.cnt_dubl CNTDBL,'||nlchr||
                           '        case when dpt_bonus.get_MMFO_ZPcard_count(jb.rnk,'||nlchr||
                           '                                                  case when v.type_cod = ''MPRG'' '||nlchr||
                           '                                                     then nvl(dc.dat_begin_12, d.dat_begin)'||nlchr||
                           '                                                     else d.dat_begin '||nlchr||
                           '                                                  end) = 0'||nlchr||
                           '             then ''НІ'''||nlchr||
                           '             else ''ТАК'''||nlchr||
                           '        end NLSZ, '||nlchr||
                           '        dpt_web.get_dptrate(d.acc, d.kv, jb.dptsum, jb.bdat) FAСTRATE, '||nlchr||
                           '        i.br BR,'||nlchr||
                           '        -- bars.getbrat '||nlchr||
                           '        case when i.br > 0 '||nlchr||
                           '           then --bars.getbrat(jb.bdat, i.br, jb.curid, jb.DPTSUM)'||nlchr||
                           '                coalesce (     '||nlchr||
                           '                 (select max(rate) keep (dense_rank first order by bdate desc)'||nlchr||
                           '                   from br_normal'||nlchr||
                           '                  where br_id = i.br '||nlchr||
                           '                    and kv = jb.curid '||nlchr||
                           '                    and bdate <= jb.bdat) ,'||nlchr||
                           '                 (select case when max(s) <= jb.DPTSUM  '||nlchr||
                           '                           then max(bt.rate) keep (dense_rank first order by s desc)'||nlchr||
                           '                           else max(bt.rate) keep (dense_rank first order by case when bt.s - jb.DPTSUM >= 0 then 0 else -bt.s end desc, bt.s )'||nlchr||
                           '                         end  '||nlchr||
                           '                    from br_tier bt '||nlchr||
                           '                   where bt.br_id = i.br '||nlchr||
                           '                     and bt.kv = jb.curid '||nlchr||
                           '                     and bt.bdate = (select max(bdate)'||nlchr||
                           '                                        from  br_tier'||nlchr||
                           '                                       where bdate <= jb.bdat '||nlchr||
                           '                                         and br_id = i.br  '||nlchr||
                           '                                         and kv = jb.curid)) )'||nlchr||
                           '          else 0             '||nlchr||
                           '        end brate,'||nlchr||
                           '        nvl(dpwb.BONUS_VALUE_FACT,0) WBBONUS,'||nlchr||
                           '              case when v.type_cod = ''MPRG'' then'||nlchr||
                           '              (select dve.indv_rate '||nlchr||
                           '                 from dpt_vidd_extdesc dve'||nlchr||
                           '                where dve.type_id = v.extension_id '||nlchr||
                           '                  and dve.ext_num = nvl(d.cnt_dubl,0) '||nlchr||
                           '                  and case when method_id not in (5, 9) then base_rate'||nlchr||
                           '                       else (select v.br_id '||nlchr||
                           '                             from bars.dpt_vidd_update vu '||nlchr||
                           '                             where vu.vidd = v.vidd'||nlchr||
                           '                                  and dateu = (select max(dateu) '||nlchr||
                           '                                               from bars.dpt_vidd_update dvu'||nlchr||
                           '                                               where dvu.vidd = v.vidd'||nlchr||
                           '                                                and dateu <= d.datz + 0.99999))'||nlchr||
                           '                           end = i.br) '||nlchr||
                           '        else 0 end DBLBONUS,'||nlchr||
                           '        nvl(dpzp.BONUS_VALUE_PLAN,0) ZPBONUS,'||nlchr||
                           '        nvl(excl.BONUS_VALUE_PLAN,0) EXCLBONUS,'||nlchr||
                           '        nvl(EXTN.BONUS_VALUE_PLAN,0) EXTN,'||nlchr||
                           '        GREATEST(nvl(dpzp.BONUS_VALUE_FACT,0), nvl(excl.BONUS_VALUE_FACT,0)) MAXBONUS,'||nlchr||
                           '        jb.STATUS,'||nlchr||
                           '        jb.ERRMSG'||nlchr||
                           '  from jb'||nlchr||
                           '      ,customer c'||nlchr||
                           '      ,staff$base s  '||nlchr||
                           '      ,tabval t'||nlchr||
                           '      ,dpt_deposit d'||nlchr||
                           '      ,dpt_vidd v'||nlchr||
                           '      ,dpt_clos dc'||nlchr||
                           '      ,intrtn i'||nlchr||
                           '      ,dpzp'||nlchr||
                           '      ,dpwb'||nlchr||
                           '      ,excl'||nlchr||
                           '      ,EXTN'||nlchr||
                           ' where 1= 1 '||nlchr||
                           '   and jb.rnk = c.rnk      '||nlchr||
                           '   and jb.userid = s.id'||nlchr||
                           '   and jb.curid = t.kv'||nlchr||
                           '   and jb.dptid = d.deposit_id'||nlchr||
                           '   and d.vidd = v.vidd'||nlchr||
                           '   and jb.dptid = dc.deposit_id '||nlchr||
                           '   and i.acc = d.acc'||nlchr||
                           '   and jb.dptid = dpzp.dpt_id (+)'||nlchr||
                           '   and jb.dptid = dpwb.dpt_id (+)'||nlchr||
                           '   and jb.dptid = excl.dpt_id (+) '||nlchr||
                           '   and jb.dptid = EXTN.dpt_id (+)';
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
    l_rep.description :='(FR)Протокол - "Автопереоформлення деп.договорів"';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat1,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 3061;


    if l_isnew = 1 then                     
       begin                                
          insert into reports values l_rep;        
          l_message:=l_message||nlchr||'Добавлен новый печ.отчет под №'||l_rep.id;
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
