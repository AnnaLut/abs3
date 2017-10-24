

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_FIN_5007.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Файл моніторингу подій дефолту
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
   l_zpr.name := 'Файл моніторингу подій дефолту';
   l_zpr.pkey := '\BRS\SBM\FIN\5007';

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
    l_zpr.name         := 'Файл моніторингу подій дефолту';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'brs5007.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := ' select a.*,'||nlchr||
                           '        (select sum(rezq39) rez39 from nbu23_rez where fdat = a.fdat and nd = a.nd and rnk = a.rnk and '||nlchr||
                           '          ('||nlchr||
                           '           (nkb = ''1'' and tip =  ''CR9'' ) or (nkb = ''2'' and tip != ''CR9'' )'||nlchr||
                           '          )'||nlchr||
                           '        ) rez39'||nlchr||
                           '  from ('||nlchr||
                           ' select (case when a.tip in (''CR9'') then ''1'' else ''2'' end) nkb,'||nlchr||
                           '        min(a.nbs) nkb2,'||nlchr||
                           '        fdat, a.rnk, a.nd, '||nlchr||
                           '        c.nmkk nmk, '||nlchr||
                           '        C.PRINSIDER,'||nlchr||
                           '        c.country, '||nlchr||
                           '        c.ise, '||nlchr||
                           '        CC.CC_ID, CC.SDATE ssdat, CC.SDATE, CC.WDATE,  a.kv,'||nlchr||
                           '        sum(case when a.tip = ''SS '' then bvq else 0 end) sz,'||nlchr||
                           '        sum(case when a.tip = ''SP '' then bvq else 0 end) sp,'||nlchr||
                           '        sum(case when a.tip in(''SN '',''SNO'') then bvq else 0 end) sna,'||nlchr||
                           '        sum(case when a.tip = ''SNA'' then bvq else 0 end) snp,'||nlchr||
                           '        sum(case when a.tip = ''SPN'' then bvq else 0 end) spna,'||nlchr||
                           '        sum(case when a.tip = ''   '' then bvq else 0 end) spnp,'||nlchr||
                           '        sum(eadq)  ead,'||nlchr||
                           '        max(lgd)  lgd,'||nlchr||
                           '        to_char(max(fin_z)) finz,'||nlchr||
                           '        max(vkr)   vkr,'||nlchr||
                           '        max(kol)   kol,'||nlchr||
                           '        to_char(max(a.fin))   fin,'||nlchr||
                           '        max(FIN_NBU.ZN_P_ND_repl_HIST(''NGRK'',51,fdat, a.nd, a.rnk)||''/''||FIN_NBU.ZN_P_ND_repl_HIST(''NGRP'',51,fdat, a.nd, a.rnk)) c_p,'||nlchr||
                           '        to_char(max(FIN_NBU.ZN_P_ND_HIST(''CLS1'',56,fdat, a.nd, a.rnk))) cls1,'||nlchr||
                           '        to_char(max(FIN_NBU.ZN_P_ND_HIST(''CLS2'',56,fdat, a.nd, a.rnk))) cls2,'||nlchr||
                           '        -- Фактори підвищеного ризику'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL25,''1611'')) p1611,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL25,''1612'')) p1612,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL25,''1613'')) p1613,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL25,''1621'')) p1621,        '||nlchr||
                           '        max(fin_rep.f_entry(A.KOL25,''1622'')) p1622,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL25,''1624'')) p1624,'||nlchr||
                           '        -- Події дефолту за ст. 164'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164100000'')) p1641,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216...'')) p1642165,'||nlchr||
                           '        -- Подій дефолту за 165 ст'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216501'')) p1651,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216502'')) p1652,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216530'')) p1653,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216540'')) p1654,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216550'')) p1655,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216560'')) p1656,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216570'')) p1657,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216580'')) p1658,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216590'')) p1659,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216510'')) p16510,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216511'')) p16511,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216512'')) p16512,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216513'')) p16513,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216514'')) p16514,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216515'')) p16515,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216516'')) p16516,'||nlchr||
                           '        max(FIN_NBU.ZN_P_ND_repl_HIST(''PD17'',53,fdat, a.nd, a.rnk)) p16517_1,'||nlchr||
                           '        max(FIN_NBU.ZN_P_ND_repl_HIST(''PD20'',53,fdat, a.nd, a.rnk)) p16517_2,'||nlchr||
                           '        max(FIN_NBU.ZN_P_ND_repl_HIST(''PD18'',53,fdat, a.nd, a.rnk)) p16517_3,'||nlchr||
                           '        max(FIN_NBU.ZN_P_ND_repl_HIST(''PD21'',53,fdat, a.nd, a.rnk)) p16517_4,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216518'')) p16518,'||nlchr||
                           '        -- Події дефолту за ст. 166'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216601'')) p16601,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216602'')) p16602,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216603'')) p16603,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216604'')) p16604,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216605'')) p16605,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216606'')) p16606,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216607'')) p16607,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216608'')) p16608,'||nlchr||
                           '        max(fin_rep.f_entry(A.KOL26,''164216609'')) p16609,'||nlchr||
                           '        --'||nlchr||
                           '        to_char(max(a.fin)) finr,'||nlchr||
                           '        max(a.pd) pd,'||nlchr||
                           '        sum(crq) crq'||nlchr||
                           '   from rez_cr a, customer c, cc_deal cc, v_gl v '||nlchr||
                           '  where fdat = trunc(to_date(:sFdat1,''dd.mm.yyyy''),''MM'')'||nlchr||
                           '    and a.rnk = c.rnk and a.acc = v.acc'||nlchr||
                           '    and CC.RNK = a.rnk and CC.ND = a.nd'||nlchr||
                           '    and a.custtype = 2 --and a.rnk = 300318'||nlchr||
                           '    and a.vidd  between 1 and 3'||nlchr||
                           ' group by (case when a.tip in (''CR9'') then ''1'' else ''2'' end), a.rnk, a.nd, fdat,'||nlchr||
                           '          c.nmkk, C.PRINSIDER, c.country, c.ise,'||nlchr||
                           '          CC.CC_ID, CC.SDATE, a.kv, CC.SDATE, CC.WDATE) a'||nlchr||
                           ' order by a.rnk, a.nd desc'||nlchr||
                           ' '||nlchr||
                           ' ';
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
    l_rep.description :='Файл моніторингу подій дефолту';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",FALSE,FALSE';
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
    l_rep.id          := 5007;


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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_FIN_5007.sql =========*** End 
PROMPT ===================================================================================== 
