

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_***_5053.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == DBF-Динамiка змiни залишкiв(вихiдних)по рахунках клiєнтiв
prompt ===================================== 

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
   l_zpr.name := 'DBF-Динамiка змiни залишкiв(вихiдних)по рахунках клiєнтiв';
   l_zpr.pkey := '\BRS\SBM\***\5053';

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
    l_zpr.name         := 'DBF-Динамiка змiни залишкiв(вихiдних)по рахунках клiєнтiв';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':BRANCH=''МФО (% - всі)'',:sFdat1=''На дату(dd/mm/yyyy)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep5053.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''BANKS_RU|MFO|NAME|ORDER BY MFO''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select distinct
       to_date(:sFdat1, ''dd.mm.yyyy'') DATE_REP,
       to_number(a.kf) MFO_DEP,
       substr(c.okpo, 1, 10) ZKPO_CLI,
       substr(c.nmk, 1, 50) NAME_CLI,
       to_number(a.nbs) BAL_ACC,
       substr(a.nms, 1, 50) NAME_ACC,
       a.kv KV,
       a.ob22 OB22,
       r.r011 R011,
       r.r013 R013,
       r.s240 S240,
       a.nls NLS,
       case
         when fost(a.acc, to_date(:sFdat1, ''dd.mm.yyyy'')) < 0 then
          1
         else
          2
       end DK,
       fost(a.acc, to_date(:sFdat1, ''dd.mm.yyyy'')) / 100 AMOUNT
  from customer c, scli_r20 b, scli_zkp k, accounts a, specparam r
 where (:BRANCH = ''%'' or c.kf = :BRANCH)
   and a.rnk = c.rnk
   and a.kf = c.kf
   and (dazs is null or dazs > to_date(:sFdat1, ''dd.mm.yyyy''))
   and a.nbs = b.r020
   and c.okpo = k.zkpo
   and a.acc = r.acc(+)
 order by r.r013, 2';
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
    l_rep.description :='DBF-Динамiка змiни залишкiв(вихiдних)по рахунках клiєнтiв';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 210; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5053;


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



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_***_5053.sql =========*** End 
PROMPT ===================================================================================== 
