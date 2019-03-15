prompt ===================================== 
prompt == Звіт по акцептованим заявкам дилером
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
   l_zpr.name := 'Звіт по акцептованим заявкам дилером';
   l_zpr.pkey := '\BRS\SBR\ZAY\5508';

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
    l_zpr.name         := 'Звіт по акцептованим заявкам дилером';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:DK=''Тип заявки, %-всі'',:KV2=''Валюта, %-всі''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '5508.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':DK=''%'',:KV2=''%''';
    l_zpr.bind_sql     := ':DK=''ZDK|DK|Z_TYPE''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'WITH'||nlchr||
                           '    zap'||nlchr||
                           '    AS'||nlchr||
                           '        (SELECT z.dk,'||nlchr||
                           '                z.mfo,'||nlchr||
                           '                (SELECT name'||nlchr||
                           '                   FROM banks_ru b'||nlchr||
                           '                  WHERE b.mfo = z.mfo)'||nlchr||
                           '                    AS branch_name,'||nlchr||
                           '                z.rnk,'||nlchr||
                           '                Z.NMK,'||nlchr||
                           '                z.kv2,'||nlchr||
                           '                Z.KURS_F,'||nlchr||
                           '                Z.S2,'||nlchr||
                           '                CASE'||nlchr||
                           '                    WHEN z.dk = 2'||nlchr||
                           '                    THEN'||nlchr||
                           '                        o.s'||nlchr||
                           '                    WHEN Z.DK IN (1)'||nlchr||
                           '                    THEN'||nlchr||
                           '                        (SELECT o.s'||nlchr||
                           '                           FROM zayavka_ru  zp'||nlchr||
                           '                                LEFT JOIN oper o'||nlchr||
                           '                                    ON (o.ref_a ='||nlchr||
                           '                                        TO_CHAR ('||nlchr||
                           '                                            ROUND ('||nlchr||
                           '                                                MOD (zp.ref_sps, 1000000000))))'||nlchr||
                           '                          WHERE     o.vdat = TO_DATE ( :sFdat1, ''dd.mm.yyyy'')'||nlchr||
                           '                                AND Zp.DK IN (1, 3, 4)'||nlchr||
                           '                                AND zp.ref_sps_check = z.ref_sps_check)'||nlchr||
                           '                    ELSE'||nlchr||
                           '                        NULL'||nlchr||
                           '                END'||nlchr||
                           '                    AS s_eq,'||nlchr||
                           '                CASE WHEN Z.DK IN (3, 4) THEN z.kv_conv ELSE NULL END'||nlchr||
                           '                    AS kv_conv,'||nlchr||
                           '                CASE'||nlchr||
                           '                    WHEN Z.DK IN (3, 4)'||nlchr||
                           '                    THEN'||nlchr||
                           '                        (SELECT o.s'||nlchr||
                           '                           FROM zayavka_ru  zp'||nlchr||
                           '                                LEFT JOIN oper o'||nlchr||
                           '                                    ON (o.ref_a ='||nlchr||
                           '                                        TO_CHAR ('||nlchr||
                           '                                            ROUND ('||nlchr||
                           '                                                MOD (zp.ref_sps, 1000000000))))'||nlchr||
                           '                          WHERE     o.vdat = TO_DATE ( :sFdat1, ''dd.mm.yyyy'')'||nlchr||
                           '                                AND Zp.DK IN (1, 3, 4)'||nlchr||
                           '                                AND zp.ref_sps_check = z.ref_sps_check)'||nlchr||
                           '                    ELSE'||nlchr||
                           '                        NULL'||nlchr||
                           '                END'||nlchr||
                           '                    AS s_conv'||nlchr||
                           '           FROM bars.oper  o'||nlchr||
                           '                LEFT JOIN zayavka_ru z ON (z.ref_sps_check = o.REF)'||nlchr||
                           '          WHERE     o.vdat = TO_DATE ( :sFdat1, ''dd.mm.yyyy'')'||nlchr||
                           '                AND o.tt = ''GOR'''||nlchr||
                           '                AND o.kf = ''300465'''||nlchr||
                           '                AND z.dk IN (1,'||nlchr||
                           '                             2,'||nlchr||
                           '                             3,'||nlchr||
                           '                             4)'||nlchr||
                           '         UNION ALL'||nlchr||
                           '         SELECT z.dk,'||nlchr||
                           '                z.kf'||nlchr||
                           '                    AS mfo,'||nlchr||
                           '                (SELECT name'||nlchr||
                           '                   FROM banks_ru b'||nlchr||
                           '                  WHERE b.mfo = z.kf)'||nlchr||
                           '                    AS branch_name,'||nlchr||
                           '                z.rnk,'||nlchr||
                           '                (SELECT nmk'||nlchr||
                           '                   FROM customer c'||nlchr||
                           '                  WHERE c.rnk = z.rnk)'||nlchr||
                           '                    AS nmk,'||nlchr||
                           '                z.kv2,'||nlchr||
                           '                Z.KURS_F,'||nlchr||
                           '                Z.S2,'||nlchr||
                           '                o.s'||nlchr||
                           '                    AS s_eq,'||nlchr||
                           '                NULL'||nlchr||
                           '                    AS kv_conv,'||nlchr||
                           '                NULL'||nlchr||
                           '                    AS s_conv'||nlchr||
                           '           FROM opl o LEFT JOIN zayavka z ON (z.REF = o.REF)'||nlchr||
                           '          WHERE     o.fdat = TO_DATE ( :sFdat1, ''dd.mm.yyyy'')'||nlchr||
                           '                AND o.tt = ''GO2'''||nlchr||
                           '                AND z.kf = ''300465'''||nlchr||
                           '                AND o.dk = 0'||nlchr||
                           '                AND z.dk = 1'||nlchr||
                           '         UNION ALL'||nlchr||
                           '         SELECT z.dk,'||nlchr||
                           '                z.kf'||nlchr||
                           '                    AS mfo,'||nlchr||
                           '                (SELECT name'||nlchr||
                           '                   FROM banks_ru b'||nlchr||
                           '                  WHERE b.mfo = z.kf)'||nlchr||
                           '                    AS branch_name,'||nlchr||
                           '                z.rnk,'||nlchr||
                           '                (SELECT nmk'||nlchr||
                           '                   FROM customer c'||nlchr||
                           '                  WHERE c.rnk = z.rnk)'||nlchr||
                           '                    AS nmk,'||nlchr||
                           '                z.kv2,'||nlchr||
                           '                Z.KURS_F,'||nlchr||
                           '                Z.S2,'||nlchr||
                           '                Z.S2 * Z.KURS_F'||nlchr||
                           '                    AS s_eq,'||nlchr||
                           '                NULL'||nlchr||
                           '                    AS kv_conv,'||nlchr||
                           '                NULL'||nlchr||
                           '                    AS s_conv'||nlchr||
                           '           FROM opl o LEFT JOIN zayavka z ON (z.REF = o.REF)'||nlchr||
                           '          WHERE     o.fdat = TO_DATE ( :sFdat1, ''dd.mm.yyyy'')'||nlchr||
                           '                AND o.tt = ''GO1'''||nlchr||
                           '                AND z.kf = ''300465'''||nlchr||
                           '                AND o.dk = 0'||nlchr||
                           '                AND z.dk = 2'||nlchr||
                           '         UNION ALL'||nlchr||
                           '         SELECT z.dk,'||nlchr||
                           '                z.kf'||nlchr||
                           '                    AS mfo,'||nlchr||
                           '                (SELECT name'||nlchr||
                           '                   FROM banks_ru b'||nlchr||
                           '                  WHERE b.mfo = z.kf)'||nlchr||
                           '                    AS branch_name,'||nlchr||
                           '                z.rnk,'||nlchr||
                           '                (SELECT nmk'||nlchr||
                           '                   FROM customer c'||nlchr||
                           '                  WHERE c.rnk = z.rnk)'||nlchr||
                           '                    AS nmk,'||nlchr||
                           '                z.kv2,'||nlchr||
                           '                Z.KURS_F,'||nlchr||
                           '                Z.S2,'||nlchr||
                           '                NULL'||nlchr||
                           '                    AS s_eq,'||nlchr||
                           '                z.kv_conv,'||nlchr||
                           '                o.s'||nlchr||
                           '                    AS s_conv'||nlchr||
                           '           FROM opl o LEFT JOIN zayavka z ON (z.REF = o.REF)'||nlchr||
                           '          WHERE     o.fdat = TO_DATE ( :sFdat1, ''dd.mm.yyyy'')'||nlchr||
                           '                AND o.tt = ''GO2'''||nlchr||
                           '                AND z.kf = ''300465'''||nlchr||
                           '                AND o.dk = 0'||nlchr||
                           '                AND z.dk IN (3, 4))'||nlchr||
                           'SELECT DECODE (dk,'||nlchr||
                           '               1, ''Купівля'','||nlchr||
                           '               2, ''Продаж'','||nlchr||
                           '               3, ''Конверсія купівля'','||nlchr||
                           '               4, ''Конверсія продаж'','||nlchr||
                           '               NULL)'||nlchr||
                           '           AS DK,'||nlchr||
                           '       mfo,'||nlchr||
                           '       branch_name,'||nlchr||
                           '       rnk,'||nlchr||
                           '       nmk,'||nlchr||
                           '       kv2,'||nlchr||
                           '       KURS_F,'||nlchr||
                           '       S2 / 100'||nlchr||
                           '           AS S2,'||nlchr||
                           '       s_eq / 100'||nlchr||
                           '           AS s_eq,'||nlchr||
                           '       kv_conv,'||nlchr||
                           '       s_conv / 100'||nlchr||
                           '           AS s_conv'||nlchr||
                           '  FROM zap'||nlchr||
                           ' WHERE dk LIKE :DK AND kv2 LIKE :KV2
						      ORDER BY DK, KV2, KURS_F';
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
    l_rep.description :='Звіт по акцептованим заявкам дилером';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',4,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 99; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5508;


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
     
