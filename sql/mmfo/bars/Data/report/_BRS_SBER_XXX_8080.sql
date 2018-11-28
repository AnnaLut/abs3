

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_***_8080.sql =========*** Run
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Перелік кредитних договорів ФО по яким не нараховано відсотки
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
   l_zpr.name := 'Перелік кредитних договорів ФО по яким не нараховано відсотки';
   l_zpr.pkey := '\BRS\SBER\***\8080';

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
    l_zpr.name         := 'Перелік кредитних договорів ФО по яким не нараховано відсотки';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''На дату'',:KF=''МФО(%всі)'',:VIDD=''Вид договору''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep8080.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':KF=''%''';
    l_zpr.bind_sql     := ':KF=''BANKS_RU|MFO|NAME'',:VIDD=''V_VIDD_CC_ZVT|VIDD|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select d.KF,'||nlchr||
                           '           D.BRANCH,'||nlchr||
                           '           d.nd,'||nlchr||
                           '           c.nmk,'||nlchr||
                           '           a.ostc/100,'||nlchr||
                           '           ad.pr,'||nlchr||
                           '           ad.s,'||nlchr||
                           '           a.acc,'||nlchr||
                           '           substr(null,1,254) as MESSAGE,'||nlchr||
                           '           a.nls,'||nlchr||
                           '           IA.ACR_DAT,'||nlchr||
                           '           D.SDATE as DATE_FROM ,'||nlchr||
                           '           D.WDATE as DATE_TO   '||nlchr||
                           '                FROM '||nlchr||
                           '                  cc_deal d,'||nlchr||
                           '                  customer c,'||nlchr||
                           '                  accounts a,'||nlchr||
                           '                  nd_acc n,'||nlchr||
                           '                  cc_vidd CV,'||nlchr||
                           '                  INT_accn ia,'||nlchr||
                           '                  (select n.nd,'||nlchr||
                           '                  acrn.fprocn (a8.acc, 0, gl.bd) pr,'||nlchr||
                           '                  ia.s,'||nlchr||
                           '                  CASE'||nlchr||
                           '                     WHEN a8.vid = 4 AND ia.basem <> 1 AND ia.id = 0'||nlchr||
                           '                     THEN'||nlchr||
                           '                        4'||nlchr||
                           '                     WHEN a8.vid = 4 AND ia.basem = 1 AND ia.id = 0'||nlchr||
                           '                     THEN'||nlchr||
                           '                        4'||nlchr||
                           '                     ELSE'||nlchr||
                           '                        0'||nlchr||
                           '                  END'||nlchr||
                           '                     vidda'||nlchr||
                           '                     from nd_acc n, accounts a8, int_accn ia'||nlchr||
                           '                     where n.acc = a8.acc             '||nlchr||
                           '                      AND ia.acc = a8.acc'||nlchr||
                           '                      AND ia.id = 0'||nlchr||
                           '                      AND a8.tip = ''LIM'') ad'||nlchr||
                           '            WHERE     n.nd = d.nd'||nlchr||
                           '                  AND c.rnk = d.rnk'||nlchr||
                           '                  AND c.rnk = a.rnk'||nlchr||
                           '                  AND ia.acc = a.acc'||nlchr||
                           '                  AND n.acc = a.acc'||nlchr||
                           '                  AND CV.vidd = d.vidd'||nlchr||
                           '                  and a.tip <>''LIM'''||nlchr||
                           '                  AND (a.tip IN (''SS '', ''SP '', ''SK9''))'||nlchr||
                           '                  and ia.id in(0,1,2)'||nlchr||
                           '                  AND d.vidd IN (11, 12, 13)'||nlchr||
                           '                  AND d.sos > 0'||nlchr||
                           '                  AND d.sos < 14'||nlchr||
                           '                  AND (ia.stp_dat IS NULL or ia.stp_dat >=:sFdat1)'||nlchr||
                           '                  and IA.ACR_DAT < :sFdat1 '||nlchr||
                           '                  and d.kf like nvl(:KF,''%'') '||nlchr||
                           '                  and d.nd = ad.nd'||nlchr||
                           '                  and (:VIDD = 0 and  ad.vidda = 0 or :VIDD =4 and ad.vidda = 4 and ad.s = EXTRACT (DAY FROM DAT_NEXT_U(:sFdat1,0)))';
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
    l_rep.description :='Перелік кредитних договорів ФО по яким не нараховано відсотки';
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
    l_rep.id          := 8080;


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
               ('$RM_DRU1', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Друк звітів ';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Друк звітів ';
    end;
                                    
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_***_8080.sql =========*** End
PROMPT ===================================================================================== 