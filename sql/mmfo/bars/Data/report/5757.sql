

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_5757.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Довідка про рух грошових коштів (з щомісячною розбивкою)
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
   l_zpr.name := 'Довідка про рух грошових коштів (з щомісячною розбивкою)';
   l_zpr.pkey := '\BRS\SBM\REP\5757';

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
    l_zpr.name         := 'Довідка про рух грошових коштів (з щомісячною розбивкою)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':Param0=''ЄДРПОУ'',:sFdat1=''Прочаткова дата періоду'',:sFdat2=''Кінцева дата періоду''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '5757.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select cust.nmk,
       cust.adr,
       cust.okpo,
       :sFdat1 as sFdat1,
       :sFdat2 as sFdat2,
       acc.nls,
       kv.lcv,
       to_char(months_list.month_value, ''YYYY.MM'') as month_value,
       trim(to_char(months_list.month_value, ''Month'', ''nls_date_language=ukrainian''))||'' ''||extract(YEAR from months_list.month_value)||'' року'' as period,
       coalesce(sum(ost.dos)/100, 0) as dt,
       coalesce(sum(ost.kos)/100, 0) as kt,
       f_doc_attr(''STAFF_FIO'', 0) as executant
  from customer cust
  join cust_acc ca on ca.rnk = cust.rnk
  join accounts acc on acc.acc = ca.acc
  join tabval kv on kv.kv = acc.kv
  --потрібно щоб вивести всі місяці, які були поміж двома датами, навіть якщо в них не було жодних фінансових операцій
  cross join (select to_date(add_months(trunc(to_date(:sFdat1, ''DD.MM.YYYY''), ''mm''), level - 1), ''DD.MM.YYYY'') month_value
                from dual
              connect by level <= months_between(to_date(:sFdat2, ''DD.MM.YYYY''), to_date(:sFdat1, ''DD.MM.YYYY'')) + 1) months_list
  left join saldoa ost on ost.acc = acc.acc and trunc(ost.fdat, ''MM'') = months_list.month_value and
                          ost.fdat between to_date(:sFdat1, ''DD.MM.YYYY'') and to_date(:sFdat2, ''DD.MM.YYYY'')
 where cust.okpo = :Param0
   and (to_date(:sFdat1, ''DD.MM.YYYY'') between acc.daos and coalesce(acc.dazs, to_date(:sFdat1, ''DD.MM.YYYY'')) or
       to_date(:sFdat2, ''DD.MM.YYYY'') between acc.daos and coalesce(acc.dazs, to_date(:sFdat2, ''DD.MM.YYYY'')))
   and (acc.nls like ''2513%'' or
       acc.nls like ''2520%'' or
       acc.nls like ''2523%'' or
       acc.nls like ''2560%'' or
       acc.nls like ''2565%'' or
       (acc.nls like ''2600%'' and acc.ob22 <> ''14'') or
       acc.nls like ''2602%'' or
       acc.nls like ''2603%'' or
       acc.nls like ''2604%'' or
       acc.nls like ''2610%'' or
       acc.nls like ''2620%'' or
       acc.nls like ''2650%'' or
       acc.nls like ''2651%'' or
       acc.nls like ''2654%'')
 group by cust.nmk, cust.adr, cust.okpo, :sFdat1, :sFdat2, acc.nls, kv.lcv, months_list.month_value, sys_context(''bars_global'', ''user_name'')
 order by acc.nls, kv.lcv, months_list.month_value';
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
    l_rep.description :='Довідка про рух грошових коштів (з щомісячною розбивкою)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',19,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5757;


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

exec umu.add_report2arm(5757,'$RM_DRU1');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_5757.sql =========*** End 
PROMPT ===================================================================================== 
