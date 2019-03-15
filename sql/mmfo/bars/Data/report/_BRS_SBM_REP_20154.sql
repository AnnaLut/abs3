PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_20154.sql =========*** Run
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Реестр купленной иностранной валюты (Ощадбанк) в ПТКС
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
   l_zpr.name := 'Реестр купленной иностранной валюты (Ощадбанк) в ПТКС';
   l_zpr.pkey := '\BRS\SBM\REP\20154';

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
    l_zpr.name         := 'Реестр купленной иностранной валюты (Ощадбанк) в ПТКС';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:BRANCH=''Відділення(всi-%)'',:Param0=''Виконавець ''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep20154.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''0'',:BRANCH=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := q'[SELECT :sFdat1 DAT,
       o.odat TIME_OP,
       o.REF,
       t.lcv NAME,
       CASE WHEN sos = -1 THEN 'ТАК' ELSE 'НІ' END sos,
       o.userid,
       branch_attribute_utl.get_value('ADR_BRANCH') adress,
       branch_attribute_utl.get_value('NAME_BRANCH') BRANCH,
       NVL (o.s , 0) / 100 SUM_N,
       NVL (o.s2, 0) / 100 SUM_G,
       NVL (TO_NUMBER (nvl(f_operw(o.ref,'KURS'),0)), 0) KURS,
       o.pdat,
       TRIM (o.nd) ND1
  FROM oper o, tabval t
 WHERE o.kv != 980
   --AND o.kv != kv2
   AND (
         (o.nlsb like '2620%' AND o.nlsa like '2924%' AND o.tt = 'OW2') or 
         (o.nlsb like '2924%' AND o.nlsa like '2920%' AND o.tt = 'OW1')
       )
   AND o.kv = t.kv
   AND o.pdat >= TO_DATE ( :sFdat1, 'dd/MM/yyyy')
   AND o.pdat < TO_DATE ( :sFdat1, 'dd/MM/yyyy') + 1
   AND o.branch LIKE :BRANCH || '%'
   AND o.userid = DECODE ( :Param0, '0', o.userid, TO_NUMBER ( '0'))]';
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
    l_rep.description :='Реестр купленной иностранной валюты (Ощадбанк) в ПТКС';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 70; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 20154;


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

exec umu.add_report2arm(20154,'$RM_DRU1');

commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_20154.sql =========*** End
PROMPT ===================================================================================== 
