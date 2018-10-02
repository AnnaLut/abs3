prompt ========================================================== 
prompt == Реестр платежів по угодам МІРАЦ (м.Павлоград) за період
prompt ==========================================================

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
   l_zpr.name := 'Реестр платежів по угодам МІРАЦ (м.Павлоград) за період';
   l_zpr.pkey := '\BRS\SBR\REP\1001';

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
    l_zpr.name         := 'Реестр платежів по угодам МІРАЦ (м.Павлоград) за період';
    l_zpr.namef        := 'miracre2.txt';
    l_zpr.bindvars     := ':p_date0=''Дата з:'',:p_date1=''Дата по:''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':p_date0=''01.01.2018'',:p_date1=''02.01.2018''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'with a as ('||nlchr||
                           'select ''34/08-191/1'' agr, ''Еко-Комунтранс'' nam, acc, kf mfo, nls from accounts where kf = ''305482'' and nls = ''37392070219449'' union all'||nlchr||
                           'select ''34/08-191/2'' agr, ''Даяр''           nam, acc, kf mfo, nls from accounts where kf = ''305482'' and nls = ''37393080219449'' union all'||nlchr||
                           'select ''78'' agr, ''КП УЖКХ''                 nam, acc, kf mfo, nls from accounts where kf = ''305482'' and nls = ''37390050219449'' union all'||nlchr||
                           'select ''87'' agr, ''ПП К-П-1''                nam, acc, kf mfo, nls from accounts where kf = ''305482'' and nls = ''37391060219449'' union all'||nlchr||
                           'select ''76'' agr, ''КП Павлоградтеплоенерго'' nam, acc, kf mfo, nls from accounts where kf = ''305482'' and nls = ''37396010219449'' union all'||nlchr||
                           'select ''79'' agr, ''КП Павлоградводоканал''   nam, acc, kf mfo, nls from accounts where kf = ''305482'' and nls = ''37397020219449'' union all'||nlchr||
                           'select ''82'' agr, ''КП Затишне місце''        nam, acc, kf mfo, nls from accounts where kf = ''305482'' and nls = ''37398030219449'' union all'||nlchr||
                           'select ''83'' agr, ''КП Павлограджитлосервіс'' nam, acc, kf mfo, nls from accounts where kf = ''305482'' and nls = ''37399040219449'' '||nlchr||
                           '),'||nlchr||
                           'd as ('||nlchr||
                           'select to_date(:p_date0, ''dd.mm.yyyy'') date0, to_date(:p_date1, ''dd.mm.yyyy'') + 1 date1 from dual'||nlchr||
                           ') '||nlchr||
                           'select to_char(dat,''YYYYMMDD'')||'';''||'||nlchr||
                           '       agr||'';''||'||nlchr||
                           '       code||'';''||'||nlchr||
                           '       ltrim(to_char(s/100,''999999990.99''))||'';"''||'||nlchr||
                           '       replace(nam,''"'','''''''')||''";"''||'||nlchr||
                           '       replace(nazn,''"'','''''''')||''"'' text'||nlchr||
                           'from (       '||nlchr||
                           '      select o.pdat dat,'||nlchr||
                           '             a.agr,'||nlchr||
                           '             o.code,'||nlchr||
                           '             s,'||nlchr||
                           '             o.nam,'||nlchr||
                           '             nazn'||nlchr||
                           '        from ('||nlchr||
                           '              select pdat,'||nlchr||
                           '                     1 code,     '||nlchr||
                           '                     mfob mfo,'||nlchr||
                           '                     nlsb nls,'||nlchr||
                           '                     nam_a nam,'||nlchr||
                           '                     s s,'||nlchr||
                           '                     nazn,'||nlchr||
                           '                     sos'||nlchr||
                           '                from oper'||nlchr||
                           '               union all'||nlchr||
                           '               select pdat,'||nlchr||
                           '                      2 code,'||nlchr||
                           '                      mfoa mfo,'||nlchr||
                           '                      nlsa nls,'||nlchr||
                           '                      nam_b nam,'||nlchr||
                           '                      -s s,'||nlchr||
                           '                      nazn,'||nlchr||
                           '                      sos'||nlchr||
                           '               from oper) o, a, d        '||nlchr||
                           '         where o.pdat between d.date0 and d.date1'||nlchr||
                           '           and o.nls = a.nls and o.sos = 5'||nlchr||
                           '         union all'||nlchr||
                           '        select trunc(d.date1-1) dat,'||nlchr||
                           '               a.agr,'||nlchr||
                           '               3 code,'||nlchr||
                           '               -bars.fost(acc,d.date1-1) s,'||nlchr||
                           '               nam,'||nlchr||
                           '               ''Нерозподілені кошти на ''||to_char(d.date1-1,''YYYYMMDD'') nazn'||nlchr||
                           '           from d, a)    '||nlchr||
                           'order by 1';
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
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     

