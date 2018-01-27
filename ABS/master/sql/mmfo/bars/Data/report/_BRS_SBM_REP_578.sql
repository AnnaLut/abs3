

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_578.sql =========*** Run *
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Реестр проводок по виконавцю
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
   l_zpr.name := 'Реестр проводок по виконавцю';
   l_zpr.pkey := '\BRS\SBM\REP\578';

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
    l_zpr.name         := 'Реестр проводок по виконавцю';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:Param0=''Код операції'',:Param1=''Вал'',:Param2=''Рахунок А'',:Param3=''Рахунок В'',:Param4=''Код виконавця'',:BRANCH=''Код відділення'',:Param5=''З підлеглими відділ.(1-так,0-ні)'' ';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'provodp.qrp';
    l_zpr.form_proc    := 'p_rep_provod(:sFdat1,:Param4)';
    l_zpr.default_vars := ':Param0=''%'',:Param1=''%'',:Param2=''%'',:Param3=''%'',:BRANCH=''Поточне'',:Param5=''0''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT :sFdat1 DAT1,    p.tt TT,    '||nlchr||
                           '                      p.ref REF,   p.kv KV,     p.nlsa NLSA, '||nlchr||
                           '                      p.s/100 S,   p.sq/100   SQ,    '||nlchr||
                           '                     p.nlsb NLSB,   p.nazn NAZN,        p.PDAT,     p.NAMTT,     p.isp ISP   ,'||nlchr||
                           '                     :Param0 P0,  :Param1 P1, :Param2 P2, :Param3 P3, :Param4 P4,'||nlchr||
                           '                    to_number( :Param5) P5,  :BRANCH PBR, '||nlchr||
                           '                    substr(sys_context(''bars_context'',''user_branch''),1,30)  CONT_BR'||nlchr||
                           'FROM        tmp_rep_provod p,        staff$base sb'||nlchr||
                           'WHERE    (substr(:Param0,1,3) in      (''%%1'',''%%2'',''%00'',''%01'',''%02'',''%03'',''%MB'') '||nlchr||
                           '                                                   and    p.tt = substr(:Param0,1,3) '||nlchr||
                           '                  or (substr(:Param0,1,3) not in       (''%%1'',''%%2'',''%00'',''%01'',''%02'',''%03'',''%MB'' )     '||nlchr||
                           '                                                  and      p.tt like :Param0||''%''))     '||nlchr||
                           '    --and      substr(:Param0,1,3) not like ''CL%''                                        '||nlchr||
                           '    AND      p.tt not like ''CL%'' '||nlchr||
                           '    AND      to_char(p.kv) like :Param1||''%'' '||nlchr||
                           '    AND      trim(p.nlsa) LIKE :Param2||''%'' '||nlchr||
                           '    AND      trim(p.nlsb) LIKE :Param3||''%'' '||nlchr||
                           '    AND      p.isp = sb.id '||nlchr||
                           '    AND      ((:Param5 =''1'' '||nlchr||
                           '             and p.branch like '||nlchr||
                           '                    decode(:BRANCH,''Поточне'', sys_context(''bars_context'',''user_branch''), :BRANCH)||''%'')'||nlchr||
                           '             or  (:Param5=''0'' and p.branch='||nlchr||
                           '                    decode(:BRANCH,''Поточне'', sys_context(''bars_context'',''user_branch''), :BRANCH)))'||nlchr||
                           'order by  p.tt,p.kv,p.s'||nlchr||
                           ''||nlchr||
                           ''||nlchr||
                           '';
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
    l_rep.description :='Реестр проводок по виконавцю';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 50; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 63;


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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_578.sql =========*** End *
PROMPT ===================================================================================== 
