
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBR_REP_5502.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Звіт для контролю файлів стат звітності по валютних операціях
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
   l_zpr.name := 'Звіт для контролю файлів стат звітності по валютних операціях';
   l_zpr.pkey := '\BRS\SBR\REP\5502';

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
    l_zpr.name         := 'Звіт для контролю файлів стат звітності по валютних операціях';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''Дата з (DD.MM.YYYY)'',:sFdat2=''Дата по (DD.MM.YYYY)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5502.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select
 oper.branch,
 oper.ref,
 oper.tt,
 oper.nd,
 to_date(oper.pdat, ''dd.mm.yy'') pdat,
 oper.kv,
 (oper.s / 100) s,
 (oper.sq / 100) sq,
 oper.nlsa,
 oper.nam_a,
 oper.mfoa,
 oper.nlsb,
 oper.nam_b,
 oper.mfob,
 oper.nazn,
 oper.kf
  from oper
 where oper.pdat between
       to_date(:sFdat1||'' 00:00:00'', ''dd.mm.yyyy HH24:MI:SS'') and
       to_date(:sFdat2||'' 23:59:59'', ''dd.mm.yyyy HH24:MI:SS'')
   and oper.kv != 980
   and oper.tt = ''C14''
   and exists (select null from sw_oper sw where sw.ref = oper.ref)
   and substr(oper.nlsa, 1, 4) in (''1500'', ''1600'')
   and oper.nlsb in (''29090100010082'',
                     ''29093100020082'',
                     ''29098100030082'',
                     ''29093100040082'',
                     ''29095100050082'',
                     ''29095100060082'',
                     ''29097100070082'',
                     ''29094100080082'',
                     ''29095100100082'',
                     ''29097100120082'',
                     ''29099100130082'',
                     ''29095100140082'',
                     ''29090100150082'',
                     ''29093100160082'',
                     ''29095100170082'',
                     ''29096100180082'',
                     ''29094100190082'',
                     ''29090100200082'',
                     ''29095100210082'',
                     ''29093100220082'',
                     ''29097100230082'',
                     ''29097100230082'',
                     ''29096100250082'',
                     ''29092100260082'',
                     ''29094100010000'',
                     ''29097100020000'',
                     ''29092100030000'',
                     ''29097100040000'',
                     ''29099100050000'',
                     ''29099100060000'',
                     ''29091100070000'',
                     ''29098100080000'',
                     ''29091000100000'',
                     ''29094000120000'',
                     ''29093100130000'',
                     ''29091000140000'',
                     ''29094100150000'',
                     ''29090000160000'',
                     ''29091000170000'',
                     ''29091000180000'',
                     ''29098100190000'',
                     ''29094100200000'',
                     ''29099100210000'',
                     ''29097100220000'',
                     ''29091100230000'',
                     ''29098100240000'',
                     ''29090100250000'',
                     ''29096100260000'')
order by oper.kf';
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
    l_rep.description :='Звіт для контролю файлів стат звітності по валютних операціях';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 160; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5502;


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

	begin
    insert into app_rep (codeapp, coderep, approve)
    values ('$RM_NBUR', 5502, 1);
    exception when dup_val_on_index then null;
    end;		
end;                                        
/                                           
                                            
commit;                                     



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBR_REP_5502.sql =========*** End 
PROMPT ===================================================================================== 