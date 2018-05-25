prompt ===================================== 
prompt == ІБ-Журнал  обліку виплат переказів із-за меж України в інвалюті
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
   l_zpr.name := 'ІБ-Журнал  обліку виплат переказів із-за меж України в інвалюті';
   l_zpr.pkey := '\BRS\SBER\REP\345';

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
    l_zpr.name         := 'ІБ-Журнал  обліку виплат переказів із-за меж України в інвалюті';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:P_BRANCH=''Код відділення''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'ZGP2.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''0''';
    l_zpr.bind_sql     := ':P_BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT o.nd ND,    o.vdat VDAT,   b.branch ||'' '' ||b.name BR,'||nlchr||
                           '                SUBSTR(MAX(o.fio),1,13) FIO1,'||nlchr||
                           '                DECODE(GREATEST(LENGTH(MAX(o.fio)),13),LENGTH(MAX(o.fio)),SUBSTR(MAX(o.fio),14,13), '''') FIO2,'||nlchr||
                           '                DECODE(GREATEST(LENGTH(MAX(o.fio)),26),LENGTH(MAX(o.fio)),SUBSTR(MAX(o.fio),27,13), '''') FIO3,'||nlchr||
                           '                DECODE(GREATEST(LENGTH(MAX(o.fio)),39),LENGTH(MAX(o.fio)),SUBSTR(MAX(o.fio),40,13), '''') FIO4,'||nlchr||
                           '                SUBSTR(MAX(o.adres),1,14) ADR1,'||nlchr||
                           '                DECODE(GREATEST(LENGTH(MAX(o.adres)),14),LENGTH(MAX(o.adres)),SUBSTR(MAX(o.adres),15,14), '''') ADR2,'||nlchr||
                           '                DECODE(GREATEST(LENGTH(MAX(o.adres)),28),LENGTH(MAX(o.adres)),SUBSTR(MAX(o.adres),29,14), '''') ADR3,      '||nlchr||
                           '                DECODE(GREATEST(LENGTH(MAX(o.adres)),42),LENGTH(MAX(o.adres)),SUBSTR(MAX(o.adres),43,14), '''') ADR4,'||nlchr||
                           '                o.s S,  o.kv KV,'||nlchr||
                           '                SUBSTR(MAX(o.nazn),1,20) NAZN1,'||nlchr||
                           '                DECODE(GREATEST(LENGTH(o.nazn),20),LENGTH(o.nazn),SUBSTR(o.nazn,21,20), '''') NAZN2,'||nlchr||
                           '                DECODE(GREATEST(LENGTH(o.nazn),40),LENGTH(o.nazn),SUBSTR(o.nazn,41,20), '''') NAZN3,      '||nlchr||
                           '                DECODE(GREATEST(LENGTH(o.nazn),60),LENGTH(o.nazn),SUBSTR(o.nazn,61,20), '''') NAZN4,'||nlchr||
                           '                --MAX(r.name) REZIDN'||nlchr||
                           '                o.rezidn rezidn,'||nlchr||
                           '                o.KOD KOD,'||nlchr||
                           '                SUBSTR(MAX(o.D6#70N),1,6) STRANA1,'||nlchr||
                           '                DECODE(GREATEST(LENGTH(MAX(o.D6#70N)),6),LENGTH(MAX(o.D6#70N)),SUBSTR(MAX(o.D6#70N),7,6), '''') STRANA2,'||nlchr||
                           '                DECODE(GREATEST(LENGTH(MAX(o.D6#70N)),12),LENGTH(MAX(o.D6#70N)),SUBSTR(MAX(o.D6#70N),13,6), '''') STRANA3,'||nlchr||
                           '                DECODE(GREATEST(LENGTH(MAX(o.D6#70N)),18),LENGTH(MAX(o.D6#70N)),SUBSTR(MAX(o.D6#70N),19,6), '''') STRANA4,'||nlchr||
                           '                SUBSTR(MAX(o.FIU),1,11)  FIU1,'||nlchr||
                           '                DECODE(GREATEST(LENGTH(o.FIU),11),LENGTH(o.FIU),SUBSTR(o.FIU,12,11), '''') FIU2,'||nlchr||
                           '                DECODE(GREATEST(LENGTH(o.FIU),22),LENGTH(o.FIU),SUBSTR(o.FIU,23,11), '''') FIU3'||nlchr||
                           '  FROM (   '||nlchr||
                           '  SELECT o.nd ND,   o.vdat VDAT, o.branch  ,'||nlchr||
                           '                                 f_dop(o.ref,''FIO'') FIO, '||nlchr||
                           '                                   (CASE'||nlchr||
                           '                                   WHEN f_dop(o.ref,''ADRES'') is null THEN f_dop(o.ref,''ADRS'')'||nlchr||
                           '                                   ELSE f_dop(o.ref,''ADRES'')'||nlchr||
                           '                                   END) ADRES,   '||nlchr||
                           '                                 o.s/100 S, o.kv KV,'||nlchr||
                           '                                 o.nazn NAZN,      '||nlchr||
                           '                                 DECODE(w.tag,''REZID'',TRIM(SUBSTR(w.value,1,2)),'''') REZID,                 '||nlchr||
                           '                                 r.name REZIDN,'||nlchr||
                           '                                 DECODE(w1.tag,''D6#70'',TRIM(SUBSTR(w1.value,1,3)),'''') KOD,   '||nlchr||
                           '                                 k.txt D6#70N, '||nlchr||
                           '                                 s.fio FIU'||nlchr||
                           '                    FROM oper o, operw w , operw w1 , rezid r, kl_k040 k, staff$base s'||nlchr||
                           '                WHERE o.vdat=:sFdat1'||nlchr||
                           '                       AND o.tt in (''MUV'', ''MUT'',''MUK'',''437'',''MUU'',''CUV'',''CN2'',''CN3'',''CN4'') '||nlchr||
                           '                       AND o.branch =:P_BRANCH '||nlchr||
                           '                       AND o.sos=5'||nlchr||
                           '                       AND o.REF=w.REF  AND o.REF=w1.REF'||nlchr||
						   '                       AND o.kv !=980'||nlchr||
                           '                       AND DECODE(w.tag,''REZID'',TRIM(SUBSTR(w.value,1,2)),'''')=r.rezid'||nlchr||
                           '                       AND o.userid=s.id              '||nlchr||
                           '                       AND DECODE(w1.tag,''D6#70'',TRIM(SUBSTR(w1.value,1,3)),'''')=k.k040   '||nlchr||
                           '                      )o,'||nlchr||
                           '                 branch b--, rezid r'||nlchr||
                           ' WHERE o.branch = b.branch --and o.rezid = r.rezid'||nlchr||
                           '  GROUP BY o.nd,o.vdat,o.kv,o.s, o.nazn,  b.branch, b.name, o.rezidn,o.KOD, o.D6#70N, o.FIU'||nlchr||
                           ' ORDER BY o.nd';
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
    l_rep.description :='ІБ-Журнал  обліку виплат переказів із-за меж України в інвалюті';
    l_rep.form        :='frm_UniReport';
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
    l_rep.id          := 345;


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
