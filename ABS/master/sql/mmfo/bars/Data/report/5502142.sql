prompt ===================================== 
prompt == виписка по рахункам Дніпропетровського ЕРЦ
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
   l_zpr.name := 'виписка по рахункам Дніпропетровського ЕРЦ';
   l_zpr.pkey := '\BRS\SBR\REP\1002';

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
    l_zpr.name         := 'виписка по рахункам Дніпропетровського ЕРЦ';
    l_zpr.namef        := 'mncptoday2.txt';
    l_zpr.bindvars     := ':p_date0=''Дата з:'',:p_date1=''Дата по:'',:KF=''МФО'',:NLS=''Рахунок'',:NAZN=''Призначення платежу містить''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':p_date0=,:p_date1=,:KF=305482,:NLS=,:NAZN=305482';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select to_char(p.datd,''YYYYMMDD'')  datd                              ,'||nlchr||
                           '       to_char(p.pdat,''YYYYMMDDHH24MISS'')  pdat                      ,'||nlchr||
                           '       to_char(case when p.dk = 0 then p.mfoa else p.mfob end)mfoa   ,'||nlchr||
                           '       to_char(case when p.dk = 0 then p.nlsa else p.nlsb end)nlsa   ,'||nlchr||
                           '       to_char(case when p.dk = 0 then p.id_a else p.id_b end) id_a  ,'||nlchr||
                           '       to_char(case when p.dk = 0 then p.mfob else p.mfoa end)mfob   ,'||nlchr||
                           '       to_char(case when p.dk = 0 then p.nlsb else p.nlsa end)nlsb   ,'||nlchr||
                           '       to_char(case when p.dk = 0 then p.id_b else p.id_a end)id_b   ,'||nlchr||
                           '       ''"''|| replace(replace(trim(p.nd),''"'',''""''),'','',''.'') ||''"'' nd,'||nlchr||
                           '       to_char(p.s)  s                                            ,'||nlchr||
                           '       ''"''|| replace(replace(p.nazn,''"'',''""''),'','',''.'')     ||''"'' line'||nlchr||
                           '  from opldok o, '||nlchr||
                           '       saldo s,'||nlchr||
                           '     ( select p.ref, '||nlchr||
                           '              p.dk,'||nlchr||
                           '              p.s,'||nlchr||
                           '              nvl(q.nd, p.nd) nd,'||nlchr||
                           '              nvl(q.nazn, p.nazn) nazn,'||nlchr||
                           '              nvl(q.datd, p.datd) datd,'||nlchr||
                           '              nvl(q.pdat, p.pdat) pdat,'||nlchr||
                           '              nvl(q.mfoa, p.mfoa) mfoa,'||nlchr||
                           '              nvl(q.mfob, p.mfob) mfob,'||nlchr||
                           '              nvl(q.nlsa, p.nlsa) nlsa,'||nlchr||
                           '              nvl(q.nlsb, p.nlsb) nlsb,'||nlchr||
                           '              nvl(q.id_a, p.id_a) id_a,'||nlchr||
                           '              nvl(q.id_b, p.id_b) id_b'||nlchr||
                           '        from oper p, operw w, oper q'||nlchr||
                           '       where p.ref = w.ref(+) and ''REF92'' = w.tag(+) and w.value = q.ref(+)) p '||nlchr||
                           ' where o.ref = p.ref'||nlchr||
                           '   and o.acc = s.acc'||nlchr||
                           '   and o.sos = 5'||nlchr||
                           '   and s.kf = :KF'||nlchr||
                           '   and s.nls = :NLS'||nlchr||
                           '   and p.nazn like ''%''||:NAZN||''%'''||nlchr||
                           '   and o.fdat between to_date(:p_date0,''dd.mm.yyyy'') and to_date(:p_date1,''dd.mm.yyyy'')'||nlchr||
                           ' order by p.pdat, p.nd';
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

