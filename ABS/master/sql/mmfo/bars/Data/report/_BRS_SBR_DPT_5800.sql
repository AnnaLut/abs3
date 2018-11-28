declare                               

   nlchr       char(2):=chr(13)||chr(10);
   l_zpr       zapros%rowtype;    
   l_zprr      zapros%rowtype;    
   l_rep       reports%rowtype;   
   l_repfolder number;            
   l_isnew     smallint:=0;       
   l_isnewr    smallint:=0;       
   l_message   varchar2(1000);   
   l_zpr_txt   varchar2(5000); 

begin    
   dbms_output.enable(1000000); 
   l_zpr.name := 'Протокол роботи щоденного джобу (пакет Ексклюзивний)';
   l_zpr.pkey := '\BRS\SBR\DPT\5800';

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
    l_zpr.name         := 'Протокол роботи щоденного джобу (пакет Ексклюзивний)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''На дату''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5800.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr_txt := 
    'SELECT sx.*, dpt_bonus.get_MMFO_ZPcard_count(sx.rnk, sx.dep_dat_begin) cnt_zp, 
    nvl(sx.bonus_wb,0) + nvl(sx.bonus_extn,0) + greatest(nvl(sx.bonus_zp,0), nvl(sx.bonus_excl,0)) BONUS , 
    to_char(to_date(:sFdat1, ''DD.MM.YYYY''), ''DD.MM.YYYY'' ) repdata 
    FROM (with dbr as (select distinct dpt_id, kf  
                from bars.dpt_bonus_requests 
                where request_state = ''ALLOW'' 
                and request_deleted = ''N'' 
                and request_user = 1 
                and trunc(request_date) = to_date(:sFdat1, ''DD.MM.YYYY'') 
                and (kf = sys_context(''bars_context'',''user_mfo'') or nvl(sys_context(''bars_context'',''user_mfo''),''/'') = ''/'' )) 
    SELECT
    dd.deposit_id            
    , dd.dat_begin         
    , dd.kv                   
    , dd.acc                  
    , dv.vidd                 
    , dv.type_name            
    , dd.rnk                  
    , trunc(ir.bdat) bdat      
    , nvl(ir.ir, 0) ir        
    , nvl(ir.br, 0) br        
    , dd.kf                   
    , dd.wb                   
    , brwb.bonus_value_fact BONUS_WB 
    , case when dv.type_cod = ''MPRG'' then
      (select nvl(max(ddc.dat_begin), dd.dat_begin)
       from bars.dpt_deposit_clos ddc
       where ddc.deposit_id = dd.deposit_id
       and nvl(ddc.cnt_dubl,0) = trunc(nvl(dd.cnt_dubl,0)/12) * 12)
      else 
        dd.dat_begin 
      end dep_dat_begin
    , brzp.bonus_value_fact BONUS_ZP 
    ,(select coalesce(to_char(min(t1.daos),''dd.mm.yyyy''),'' - '') 
      from bars.accounts t1
      join bars.w4_Acc wa on wa.acc_pk = t1.acc and wa.kf = t1.kf
      join bars.w4_Card wc on wc.code = wa.card_code and wc.kf = t1.kf
      join bars.w4_product wp on wp.code = wc.product_code and wp.kf = t1.kf 
      where t1.rnk = dd.rnk
      and wp.grp_code = ''SALARY''
      and wp.name not like ''%STUD%''
      and wa.card_code not like ''%STUD%''
      and (t1.dazs is null or t1.dazs >to_date(:sFdat1, ''DD.MM.YYYY''))) DAT_MIN_OPEN_ZP 
    ,(select coalesce(to_char(max(t2.dazs),''dd.mm.yyyy''),'' - '') 
      from bars.accounts t2
      join bars.w4_Acc wa on wa.acc_pk = t2.acc and wa.kf = t2.kf
      join bars.w4_Card wc on wc.code = wa.card_code and wc.kf = t2.kf
      join bars.w4_product wp on wp.code = wc.product_code and wp.kf = t2.kf  
      where t2.rnk = dd.rnk
      and wp.grp_code = ''SALARY''
      and wp.name not like ''%STUD%''
      and wa.card_code not like ''%STUD%'') DAT_MAX_CLOS_ZP 
    , bars.kost(dd.acc, to_date(:sFdat1, ''DD.MM.YYYY''))/100 OST 
    , brexcl.bonus_value_fact BONUS_EXCL 
    , brextn.bonus_value_fact BONUS_EXTN 
    , (lead(ir.bdat, 1, to_date(''31.12.4999'', ''DD.MM.YYYY'')) over (partition by ir.acc order by ir.bdat))-1 pdat
    , nvl(lag(ir.ir, 1) over (partition by ir.acc order by ir.bdat),0) ex_ir
    , nvl(lag(ir.br, 1) over (partition by ir.acc order by ir.bdat),0) ex_br
    , nvl(lag(ir.bdat, 1) over (partition by ir.acc order by ir.bdat), ir.bdat) ex_bdat   
   FROM
    dbr 
    inner join bars.dpt_deposit dd on dd.deposit_id = dbr.dpt_id and dd.kf = dbr.kf
    inner join bars.dpt_vidd dv on dv.vidd = dd.vidd
    left join bars.dpt_bonus_requests brwb on brwb.dpt_id = dd.deposit_id and brwb.bonus_id = dpt_bonus.get_bonus_id(''DPWB'') and brwb.kf = dd.kf and trunc(brwb.request_date) = to_date(:sFdat1, ''DD.MM.YYYY'') and brwb.request_state = ''ALLOW'' and brwb.request_deleted = ''N'' 
    left join bars.dpt_bonus_requests brzp on brzp.dpt_id = dd.deposit_id and brzp.bonus_id = dpt_bonus.get_bonus_id(''DPZP'') and brzp.kf = dd.kf and trunc(brzp.request_date) = to_date(:sFdat1, ''DD.MM.YYYY'') and brzp.request_state = ''ALLOW'' and brzp.request_deleted = ''N'' 
    left join bars.dpt_bonus_requests brexcl on brexcl.dpt_id = dd.deposit_id and brexcl.bonus_id = dpt_bonus.get_bonus_id(''EXCL'') and brexcl.kf = dd.kf and trunc(brexcl.request_date) = to_date(:sFdat1, ''DD.MM.YYYY'') and brexcl.request_state = ''ALLOW'' and brexcl.request_deleted = ''N'' 
    left join bars.dpt_bonus_requests brextn on brextn.dpt_id = dd.deposit_id and brextn.bonus_id = dpt_bonus.get_bonus_id(''EXTN'') and brextn.kf = dd.kf and trunc(brextn.request_date) = to_date(:sFdat1, ''DD.MM.YYYY'') and brextn.request_state = ''ALLOW'' and brextn.request_deleted = ''N'' 
    left join bars.int_ratn ir on ir.acc = dd.acc and id = 1         
   WHERE 1=1) sx
  WHERE sx.bdat between to_date(:sFdat1, ''DD.MM.YYYY'') and to_date(:sFdat1, ''DD.MM.YYYY'') + 1 ' ;
    l_zpr.txt          := l_zpr_txt;   
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
    l_rep.description :='Протокол роботи щоденного джобу (пакет Ексклюзивний)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat1,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5800;

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
