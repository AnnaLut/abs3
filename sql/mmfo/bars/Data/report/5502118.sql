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
   l_zpr.pkey := '\BRS\SBR\REP\1000';

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
    l_zpr.namef        := 'miracree.txt';
    l_zpr.bindvars     := ':p_date0=''Дата з:'',:p_date1=''Дата по:''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':p_date0=''01.01.2018'',:p_date1=''02.01.2018''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'with a as ('||nlchr||
                           'select ''34/08-191/1'' agr, ''Еко-Комунтранс'' nam, ''37392070219449'' nls from dual union all'||nlchr||
                           'select ''34/08-191/2'' agr, ''Даяр''           nam, ''37393080219449'' nls from dual union all'||nlchr||
                           'select ''78'' agr, ''КП УЖКХ''                 nam, ''37390050219449'' nls from dual union all'||nlchr||
                           'select ''87'' agr, ''ПП К-П-1''                nam, ''37391060219449'' nls from dual union all'||nlchr||
                           'select ''76'' agr, ''КП Павлоградтеплоенерго'' nam, ''37396010219449'' nls from dual union all'||nlchr||
                           'select ''79'' agr, ''КП Павлоградводоканал''   nam, ''37397020219449'' nls from dual union all'||nlchr||
                           'select ''82'' agr, ''КП Затишне місце''        nam, ''37398030219449'' nls from dual union all'||nlchr||
                           'select ''83'' agr, ''КП Павлограджитлосервіс'' nam, ''37399040219449'' nls from dual'||nlchr||
                           ')'||nlchr||
                           'select to_char(trunc(pdat),''YYYYMMDD'') dat,'||nlchr||
                           '       (select agr||'' - ''||nam from a where a.agr = o.agr) agr,'||nlchr||
                           '--     mfo,'||nlchr||
                           '--     nls,'||nlchr||
                           '       case when nls like ''6110%'' then ''Комісія банку'' else nam end korr,'||nlchr||
                           '       count(*) c,'||nlchr||
                           '       case when oper = 1 then sum(s)/100 end sinp,'||nlchr||
                           '       case when oper = 2 then sum(s)/100 end sout'||nlchr||
                           'from ('||nlchr||
                           '    select a.agr,'||nlchr||
                           '           o.pdat,'||nlchr||
                           '           o.mfob mfo,'||nlchr||
                           '           o.nlsb nls,'||nlchr||
                           '           o.nam_b nam,'||nlchr||
                           '           2 oper,'||nlchr||
                           '           s'||nlchr||
                           '      from oper o, a'||nlchr||
                           '      where o.nlsa = a.nls  '||nlchr||
                           '    union all'||nlchr||
                           '    select a.agr,'||nlchr||
                           '           o.pdat,'||nlchr||
                           '           o.mfoa mfo,'||nlchr||
                           '           o.nlsa nls,'||nlchr||
                           '           o.nam_a nam,'||nlchr||
                           '           1 oper,'||nlchr||
                           '           s'||nlchr||
                           '      from oper o, a'||nlchr||
                           '      where o.nlsb = a.nls'||nlchr||
                           ') o  '||nlchr||
                           'where pdat between to_date(:p_date0, ''dd.mm.yyyy'') and to_date(:p_date1, ''dd.mm.yyyy'') + 1'||nlchr||
                           'group by trunc(pdat), agr, oper, mfo, nls, nam'||nlchr||
                           'order by trunc(pdat), agr, oper, mfo, nls';
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

