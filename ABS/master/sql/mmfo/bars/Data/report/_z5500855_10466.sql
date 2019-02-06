PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_***_DPT_1DFCBdbf.sql =========*** 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Звіт 1-ДФ (Cash-back) DBF
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
   l_zpr.name := 'Звіт 1-ДФ (Cash-back) DBF';
   l_zpr.pkey := '\BRS\***\DPT\1DFCBdbf';

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
    l_zpr.name         := 'Звіт 1-ДФ (Cash-back) DBF';
    l_zpr.namef        := '1_DF_CB.dbf';
    l_zpr.bindvars     := ':sFdat1=''Дата_З(dd/mm/yyyy)'',:sFdat2=''Дата_ПО(dd/mm/yyyy)''';
    l_zpr.create_stmt  := 'NP NUMBER(6),'||nlchr||
                           'PERIOD NUMBER(2),'||nlchr||
                           'RIK NUMBER(5),'||nlchr||
                           'KOD CHAR(10),'||nlchr||
                           'TYP NUMBER(2),'||nlchr||
                           'TIN CHAR(10),'||nlchr||
                           'S_NAR NUMBER(13,2),'||nlchr||
                           'S_DOX NUMBER(13,2),'||nlchr||
                           'S_TAXN NUMBER(13,2),'||nlchr||
                           'S_TAXP NUMBER(13,2),'||nlchr||
                           'OZN_DOX NUMBER(4),'||nlchr||
                           'D_PRIYN CHAR(10),'||nlchr||
                           'D_ZVILN CHAR(10),'||nlchr||
                           'OZN_PILG NUMBER(3),'||nlchr||
                           'OZNAKA NUMBER(2)';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'with lvls
as
(select *
   from (SELECT dat, PERIOD, RIK, (select val  from params where par = ''OKPO'') KOD, typ, pKOD TIN, sum(s_nar) as S_NAR, sum(s_dox) as S_DOX, sum(s_taxn) as S_TAXN, sum(s_taxp) as S_TAXP, D_PRIYN, D_ZVILN, OZN_PILG, OZNAKA, lvl
           from v_1df_cash_back_dbf
          where dat BETWEEN (TO_DATE (:sFdat1, ''dd/mm/yyyy'')) and (TO_DATE (:sFdat2, ''dd/mm/yyyy''))
          group by dat, PERIOD, RIK, pKOD, typ, nls, D_PRIYN, D_ZVILN, OZN_PILG, OZNAKA, lvl
          ORDER BY lvl, s_taxn desc
         )
)
select rownum NP,PERIOD, RIK, KOD, TYP, TIN, S_NAR, S_DOX, S_TAXN, S_TAXP, 126 as OZN_DOX, D_PRIYN, D_ZVILN, OZN_PILG, 0 OZNAKA
  from (select  PERIOD, RIK, KOD, TYP, TIN, S_NAR, S_DOX, S_TAXN, S_TAXP, 0 as OZN_DOX, D_PRIYN, D_ZVILN, OZN_PILG, OZNAKA
          from lvls where lvl = 1
        union all
        select  PERIOD, RIK, '''', 0 TYP, '''', sum(S_NAR), sum(S_DOX), sum(S_TAXN), sum(S_TAXP),126 as OZN_DOX, '''' D_PRIYN, '''' D_ZVILN, 0 OZN_PILG, 0 OZNAKA
          from lvls
         where lvl = 2
         group by PERIOD, RIK
       )';
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
    l_rep.description :='Звіт 1-ДФ (Cash-back) DBF';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',11,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='1_DF_CB.dbf';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 3018;


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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_***_DPT_1DFCBdbf.sql =========*** 
PROMPT ===================================================================================== 