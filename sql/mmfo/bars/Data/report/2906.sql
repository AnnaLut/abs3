prompt ===================================== 
prompt == Звіт про нерухомі вклади фізичних осіб
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
   l_zpr.name := 'Звіт про нерухомі вклади фізичних осіб';
   l_zpr.pkey := '\BRS\SEB\DPT\101';

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
    l_zpr.name         := 'Звіт про нерухомі вклади фізичних осіб';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:Param0=''По ТВБВ (1-Так/0-Ні)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'DPT_101.QRP';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''1''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select :sFdat1 DAT, branch,
       sum (decode (nbs,''2620'', decode( ob22,''08'',ost,''11'',ost,0))) S_1,
       sum (decode (nbs,''2620'', decode( ob22,''08'',kol,''11'',kol,0))) K_1,
       sum (decode (nbs,''2620'', decode( ob22,''09'',ost,''12'',ost,0))) S_2,
       sum (decode (nbs,''2620'', decode( ob22,''09'',kol,''12'',kol,0))) K_2,
       sum (decode (nbs,''2630'', decode( ob22,''11'',ost,''13'',ost,0),
                        ''2630'', decode( ob22,''B6'',ost,''15'',ost,0),0))S_3,
       sum (decode (nbs,''2630'', decode( ob22,''11'',kol,''13'',kol,0),
                        ''2630'', decode( ob22,''B6'',kol,''15'',kol,0),0))K_3,                        
       sum (decode (nbs,''2630'', decode( ob22,''12'',ost,''14'',ost,0),
                        ''2630'', decode( ob22,''B7'',ost,''16'',ost,0),0))S_4,
       sum (decode (nbs,''2630'', decode( ob22,''12'',kol,''14'',kol,0),
                        ''2630'', decode( ob22,''B7'',kol,''16'',kol,0),0))K_4,
       sum (decode (nbs,''2620'', decode( ob22,''08'',ost,''11'',ost,0),  
                        ''2630'', decode( ob22,''11'',ost,''13'',ost,0),
                        ''2630'', decode( ob22,''B6'',ost,''15'',ost,0),0))S_01,
       sum (decode (nbs,''2620'', decode( ob22,''08'',kol,''11'',kol,0),  
                        ''2630'', decode( ob22,''11'',kol,''13'',kol,0),
                        ''2630'', decode( ob22,''B6'',kol,''15'',kol,0),0))K_01,
       sum (decode (nbs,''2620'', decode( ob22,''09'',ost,''12'',ost,0),
                        ''2630'', decode( ob22,''12'',ost,''14'',ost,0),
                        ''2630'', decode( ob22,''B7'',ost,''16'',ost,0),0))S_02,  
       sum (decode (nbs,''2620'', decode( ob22,''09'',kol,''12'',kol,0),
                        ''2630'', decode( ob22,''12'',kol,''14'',kol,0),
                        ''2630'', decode( ob22,''B7'',kol,''16'',kol,0),0)) K_02                                       
 from (select s.ob22 OB22, a.nbs NBS, 
              decode(:Param0, 1, decode(length(a.branch), 8, a.branch||''000000/060000/'', 15, a.branch||''060''||substr(a.branch, 12), a.branch), substr(a.branch, 1,8)) branch,
              SUM(fost(a.acc,to_date(:sFdat1,''dd.mm.yyyy'')))/100 OST, count(a.acc)KOL 
         from specparam_int s, accounts a
        where a.acc=s.acc and a.kv=980 
          and(a.dazs is null or dazs < to_date(:sFdat1,''dd.mm.yyyy''))
          and( (a.nbs = ''2620'' and s.ob22 in (''08'',''11'',''09'',''12''))
             or(a.nbs = ''2630'' and s.ob22 in (''11'',''12'',''13'',''14'',''B6'',''B7'',''B8'',''B9'')))
       group by branch, a.nbs, s.ob22
       order by a.nbs)
group by branch
order by substr(branch, 18,3)';
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
