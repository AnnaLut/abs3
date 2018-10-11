PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_***_8081.sql =========*** Run
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Запит за договорами кредитного портфелю
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
   l_zpr.name := 'Запит за договорами кредитного портфелю';
   l_zpr.pkey := '\BRS\SBER\***\8081';

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
    l_zpr.name         := 'Запит за договорами кредитного портфелю';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''Дата з'',:sFdat2=''Дата по'',:RNK=''РНК'',:TIP=''Тип рах.'',:KV=''Код вал.'',:CTYPE=''Тип клієнта'',:ND=''Реф. дог.'',:TT=''Код операції'',:NLSA=''Рах. А'',:NLSB=''Рах.Б'',:DK=''Д/К''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep8081.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':RNK=''%'',:TIP=''%'',:KV=''%'',:CTYPE=''%'',:ND=''%'',:TT=''%'',:NLSA=''%'',:NLSB=''%'',:DK=''%''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := '  SELECT c.NMK AS NMK,'||nlchr||
                           '         c.RNK as RNK,'||nlchr||
                           '         x.NDG as NDG,'||nlchr||
                           '         x.nd as KR_DOG,'||nlchr||
                           '         a.kv as KV,'||nlchr||
                           '         a.tip as TIP,'||nlchr||
                           '         a.nls as NLS,'||nlchr||
                           '         a.ostc as OSTC,'||nlchr||
                           '         a.acc as ACC,'||nlchr||
                           '         p.tt AS TT,'||nlchr||
                           '         p.REF AS REF,'||nlchr||
                           '         p.ND as ND,'||nlchr||
                           '         p.VDAT as VDAT,'||nlchr||
                           '         p.DK as DK,'||nlchr||
                           '         p.KV as KV1,'||nlchr||
                           '         p.NLSA as NLSA,'||nlchr||
                           '         p.S / 100 as S1,'||nlchr||
                           '         p.Kv2 as KV2,'||nlchr||
                           '         p.NLSB as NLSB,'||nlchr||
                           '         p.S2 / 100 as S2,'||nlchr||
                           '         p.NAZN as NAZN'||nlchr||
                           '    FROM (SELECT *'||nlchr||
                           '            FROM accounts a1'||nlchr||
                           '           WHERE      decode(:RNK,''%'',RNK,:RNK) = a1.RNK'||nlchr||
                           '                 AND  decode(:TIP,''%'', a1.tip,:RNK) = a1.TIP'||nlchr||
                           '                 AND  decode(:KV,''%'', a1.kv,:KV) = a1.KV'||nlchr||
                           '                 AND a1.tip IN (''SRR'','||nlchr||
                           '                                ''SNA'','||nlchr||
                           '                                ''SDI'','||nlchr||
                           '                                ''SDA'','||nlchr||
                           '                                ''SDM'','||nlchr||
                           '                                ''SDF'','||nlchr||
                           '                                ''XDI'','||nlchr||
                           '                                ''XDA'','||nlchr||
                           '                                ''XDM'','||nlchr||
                           '                                ''XDF'')) a,'||nlchr||
                           '         (SELECT *'||nlchr||
                           '            FROM customer c1'||nlchr||
                           '           WHERE     decode(:RNK,''%'',RNK,:RNK) = c1.RNK'||nlchr||
                           '                 AND decode(:CTYPE,''%'', c1.Custtype,:CTYPE) = c1.Custtype) c,'||nlchr||
                           '         saldoa s,'||nlchr||
                           '         opldok o,'||nlchr||
                           '         oper p,'||nlchr||
                           '         (SELECT n.acc,'||nlchr||
                           '                 n.nd,'||nlchr||
                           '                 d.NDG,'||nlchr||
                           '                 d.VIDD,'||nlchr||
                           '                 d.cc_id,'||nlchr||
                           '                 d.sdate'||nlchr||
                           '            FROM nd_acc n, cc_deal d'||nlchr||
                           '           WHERE decode( :ND,''%'', n.ND,:ND) = n.ND AND n.ND = d.ND(+)) x'||nlchr||
                           '   WHERE     a.rnk = c.rnk'||nlchr||
                           '         AND a.acc = s.acc'||nlchr||
                           '         AND o.acc = s.acc'||nlchr||
                           '         AND o.fdat = s.fdat'||nlchr||
                           '         AND o.REF = p.REF'||nlchr||
                           '         AND a.acc = x.acc(+)'||nlchr||
                           '         AND s.FDAT >= NVL ( :sFdat1, a.DAOS)'||nlchr||
                           '         AND s.FDAT <= NVL ( :sFdat2, SYSDATE)'||nlchr||
                           '         AND decode(  :TT,''%'', p.TT,:TT) = p.TT'||nlchr||
                           '         AND decode(  :NLSA,''%'', p.NLSA,:NLSA) = p.NLSA'||nlchr||
                           '         AND decode(  :NLSB,''%'', p.NLSB,:NLSB) = p.NLSB'||nlchr||
                           '         AND decode(  :DK, ''%'', o.DK,:DK) = o.DK'||nlchr||
                           'ORDER BY a.KF,'||nlchr||
                           '         c.Custtype,'||nlchr||
                           '         c.RNK,'||nlchr||
                           '         x.nd,'||nlchr||
                           '         a.tip,'||nlchr||
                           '         s.FDAT,'||nlchr||
                           '         o.DK,'||nlchr||
                           '         o.S';
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
    l_rep.description :='Запит за договорами кредитного портфелю';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',19,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 180; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 8081;


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

    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('$RM_PRVN', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ-PRVN';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ-PRVN';
    end; 
                                     
    bars_report.print_message(l_message); 
      
end;                                        
/                                           
                                            
commit;                                     



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_***_8081.sql =========*** End
PROMPT ===================================================================================== 
