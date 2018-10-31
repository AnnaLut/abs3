PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_***_8082.sql =========*** Run
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Визначення кількості днів прострочки за кред.ЮО на дату
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
   l_zpr.name := 'Визначення кількості днів прострочки за кред.ЮО на дату';
   l_zpr.pkey := '\BRS\SBER\***\8082';

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
    l_zpr.name         := 'Визначення кількості днів прострочки за кред.ЮО на дату';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''На дату''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep8082.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT     c.nmk,                                         '||nlchr||
                           '           d.nd,                                          '||nlchr||
                           '           d.cc_id,                                       '||nlchr||
                           '           p.kv,                                          '||nlchr||
                           '           d.sdog,                                        '||nlchr||
                           '              gl.p_icurval ('||nlchr||
                           '              p.kv,'||nlchr||
                           '              d.sdog * 100,'||nlchr||
                           '              to_date(:sFdat1))/100'||nlchr||
                           '              nd_sum,                                     '||nlchr||
                           '           TO_CHAR (d.sdate, ''dd/mm/yyyy'') sdate,         '||nlchr||
                           '           TO_CHAR (d.wdate, ''dd/mm/yyyy'') wdate,         '||nlchr||
                           '             gl.p_icurval ('||nlchr||
                           '                p.kv,'||nlchr||
                           '                p.ss,'||nlchr||
                           '                to_date(:sFdat1))'||nlchr||
                           '           / 100'||nlchr||
                           '              body_norm,                                  '||nlchr||
                           '              gl.p_icurval ('||nlchr||
                           '                p.kv,'||nlchr||
                           '                p.sp,'||nlchr||
                           '                to_date(:sFdat1))'||nlchr||
                           '           / 100'||nlchr||
                           '              expired_body,                               '||nlchr||
                           '              to_char(F_DATE_EXPIRED ('||nlchr||
                           '              to_date(:sFdat1),'||nlchr||
                           '              d.nd,'||nlchr||
                           '              0),''dd/mm/yyyy'')'||nlchr||
                           '              date_expired_body,                          '||nlchr||
                           '             to_date(:sFdat1)'||nlchr||
                           '           - F_DATE_EXPIRED ('||nlchr||
                           '                to_date(:sFdat1),'||nlchr||
                           '                d.nd,'||nlchr||
                           '                0)'||nlchr||
                           '              day_expired_body,                           '||nlchr||
                           '             gl.p_icurval ('||nlchr||
                           '                p.kv,'||nlchr||
                           '                p.sn,'||nlchr||
                           '                to_date(:sFdat1))'||nlchr||
                           '           / 100'||nlchr||
                           '              persent_norm,                               '||nlchr||
                           '             gl.p_icurval ('||nlchr||
                           '                p.kv,'||nlchr||
                           '                p.spn,'||nlchr||
                           '                to_date(:sFdat1))'||nlchr||
                           '           / 100'||nlchr||
                           '              expired_persentm31,                         '||nlchr||
                           '             gl.p_icurval ('||nlchr||
                           '                p.kv,'||nlchr||
                           '                p.spn_30,'||nlchr||
                           '                to_date(:sFdat1))'||nlchr||
                           '           / 100'||nlchr||
                           '              expired_persentb31,                         '||nlchr||
                           '             to_char(F_DATE_EXPIRED ('||nlchr||
                           '                to_date(:sFdat1),'||nlchr||
                           '                d.nd,'||nlchr||
                           '                1),''dd/mm/yyyy'')'||nlchr||
                           '             date_expired_persent,                        '||nlchr||
                           '             to_date(:sFdat1)'||nlchr||
                           '           - F_DATE_EXPIRED ('||nlchr||
                           '                to_date(:sFdat1),'||nlchr||
                           '                d.nd,'||nlchr||
                           '                1)'||nlchr||
                           '              day_expired_persent                         '||nlchr||
                           '      FROM cc_deal d,'||nlchr||
                           '           customer c,'||nlchr||
                           '           cc_add cd,'||nlchr||
                           '           (  SELECT a.kv,'||nlchr||
                           '                     n.nd,'||nlchr||
                           '                     -NVL (SUM (DECODE (a.tip, ''SS '', a.ostc, 0)), 0) ss,'||nlchr||
                           '                     -NVL (SUM (DECODE (a.tip, ''SN '', a.ostc, 0)), 0) sn,'||nlchr||
                           '                     -NVL (SUM (DECODE (a.tip, ''SP '', a.ostc, 0)), 0) sp,'||nlchr||
                           '                     -NVL (SUM (DECODE (a.tip, ''SL '', a.ostc, 0)), 0) sl,'||nlchr||
                           '                     -NVL (SUM (DECODE (a.tip, ''SPN'', a.ostc - a.ost30, 0)), 0)'||nlchr||
                           '                        spn,'||nlchr||
                           '                     -NVL (SUM (DECODE (a.tip, ''SPN'', a.ost30, 0)), 0) spn_30,'||nlchr||
                           '                     -NVL (SUM (DECODE (a.tip, ''SLN'', a.ostc, 0)), 0) sln'||nlchr||
                           '                FROM (SELECT kv,'||nlchr||
                           '                             acc,'||nlchr||
                           '                             tip,'||nlchr||
                           '                             rnk,'||nlchr||
                           '                             fost ('||nlchr||
                           '                                acc,'||nlchr||
                           '                                to_date(:sFdat1))'||nlchr||
                           '                                ostc,'||nlchr||
                           '                             DECODE ('||nlchr||
                           '                                tip,'||nlchr||
                           '                                ''SPN'', -rez.f_get_rest_over_30 ('||nlchr||
                           '                                           acc,'||nlchr||
                           '                                           to_date(:sFdat1)),'||nlchr||
                           '                                0)'||nlchr||
                           '                                ost30'||nlchr||
                           '                        FROM accounts'||nlchr||
                           '                       WHERE     tip IN (''SS '','||nlchr||
                           '                                         ''SP '','||nlchr||
                           '                                         ''SL '','||nlchr||
                           '                                         ''SN '','||nlchr||
                           '                                         ''SPN'','||nlchr||
                           '                                         ''SLN'')'||nlchr||
                           '                             AND nbs LIKE ''20%'') a,'||nlchr||
                           '                     nd_acc n'||nlchr||
                           '               WHERE n.acc = a.acc'||nlchr||
                           '            GROUP BY a.kv, n.nd) p'||nlchr||
                           '     WHERE     d.vidd IN (1,'||nlchr||
                           '                          2,'||nlchr||
                           '                          3)'||nlchr||
                           '           AND d.nd = p.nd'||nlchr||
                           '           AND c.rnk = d.rnk'||nlchr||
                           '           AND d.nd = cd.nd'||nlchr||
                           '           AND (   p.sp <> 0'||nlchr||
                           '                OR p.spn <> 0'||nlchr||
                           '                OR p.spn_30 <> 0'||nlchr||
                           '                OR p.sl <> 0'||nlchr||
                           '                OR p.sln <> 0)';
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
    l_rep.description :='Визначення кількості днів прострочки за кред.ЮО на дату';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',19,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 180; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 8082;


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
               ('$RM_RISK', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Розрахунок кредитного ризику (351) ';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Розрахунок кредитного ризику (351) ';
    end; 
                                 
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_***_8082.sql =========*** End
PROMPT ===================================================================================== 
