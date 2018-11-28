

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_***_5049.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == K-файл (Консолідована виписка)
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
   l_zpr.name := 'K-файл (Консолідована виписка)';
   l_zpr.pkey := '\BRS\SBM\***\5049';

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
    l_zpr.name         := 'K-файл (Консолідована виписка)';
    l_zpr.namef        := 'select k_file_name(:sFdat1,:KODK) from dual';
    l_zpr.bindvars     := ':sFdat1='''',:nbs=''Б/Р(всi-%)'',:nls=''Номер рахунку(всi-%)'',:KODK=''Код корпорації''';
    l_zpr.create_stmt  := 'COLUMNSELECT';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := 'null';
    l_zpr.default_vars := ':nbs=''%'',:nls=''%'',:KODK=''%''';
    l_zpr.bind_sql     := ':KODK=''KOD_CLI|KOD_CLI''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select '||nlchr||
                           'ROWTYPE||''|''||'||nlchr||
                           'lpadchr(kf, '' '',9)||''|''||'||nlchr||
                           'lpadchr(nls, '' '',14)||''|''||'||nlchr||
                           'lpadchr(nvl(kv,0), '' '',3)||''|''||'||nlchr||
                           'lpadchr(okpo, '' '',14)||''|''||'||nlchr||
                           'lpadchr(nvl(obdb,0), '' '',14)||''|''||'||nlchr||
                           'lpadchr(nvl(obdbq,0), '' '',14)||''|''||'||nlchr||
                           'lpadchr(nvl(obkr,0), '' '',14)||''|''||'||nlchr||
                           'lpadchr(nvl(obkrq,0), '' '',14)||''|''||'||nlchr||
                           'lpadchr(nvl(ost,0), '' '',14)||''|''||'||nlchr||
                           'lpadchr(nvl(ostq,0), '' '',14)||''|''||'||nlchr||
                           'lpadchr(case when rowtype=2 then 0 else kod_corp end, '' '',20)||''|''||'||nlchr||
                           'lpadchr(nvl(kod_ustan,0),'' '',20)||''|''||'||nlchr||
                           'lpadchr(case when length(kod_analyt)=1 then ''0''||substr(kod_analyt,1,2) else substr(kod_analyt,1,2) end,'' '',2)||''|''||'||nlchr||
                           'lpadchr(to_char(dapp,''YYMMDD''),'' '',6)||''|''||'||nlchr||
                           'rpadchr(case when rowtype=2 then ''WINDOWS-1251'' else null end,'' '',60)||''|''||'||nlchr||
                           'lpadchr(to_char(docdat,''YYMMDD''),'' '',6)||''|''||'||nlchr||
                           'lpadchr(to_char(postdat,''YYMMDD''),'' '',6)||''|''||'||nlchr||
                           'lpadchr(to_char(valdat,''YYMMDD''),'' '',6)||''|''||'||nlchr||
                           'rpadchr(nd,'' '',10)||''|''||'||nlchr||
                           'lpadchr(nvl(substr(to_char(vob),1,2),0), '' '',2)||''|''||'||nlchr||
                           'lpadchr(nvl(dk,0), '' '',1)||''|''||'||nlchr||
                           'lpadchr(mfoa, '' '',9)||''|''||'||nlchr||
                           'rpadchr(case when rowtype=2 then ''0'' else to_char(nlsa) end, '' '',14)||''|''||'||nlchr||
                           'rpadchr(nvl(kva,0), '' '',3)||''|''||'||nlchr||
                           'rpadchr(substr(nama,1,38), '' '',38)||''|''||'||nlchr||
                           'rpadchr(substr(okpoa,1,38), '' '',14)||''|''||'||nlchr||
                           'lpadchr(mfob, '' '',9)||''|''||'||nlchr||
                           'rpadchr(nlsb, '' '',14)||''|''||'||nlchr||
                           'rpadchr(nvl(kvb,0), '' '',3)||''|''||'||nlchr||
                           'rpadchr(substr(namb,1,38), '' '',38)||''|''||'||nlchr||
                           'rpadchr(substr(okpob,1,38), '' '',14)||''|''||'||nlchr||
                           'lpadchr(nvl(s,0), '' '',16)||''|''||'||nlchr||
                           'rpadchr(nvl(dockv,0), '' '',3)||''|''||'||nlchr||
                           'lpadchr(nvl(sq,0), '' '',16)||''|''||'||nlchr||
                           'rpadchr(substr(nazn,1,160), '' '',160)||''|''||'||nlchr||
                           'lpadchr(nvl(doctype,0), '' '',1)||''|''||'||nlchr||
                           'lpadchr(to_char(posttime,''HHMM''),'' '',4)||''|''||'||nlchr||
                           'rpadchr(substr(namk,1,60), '' '',60)||''|''||'||nlchr||
                           'rpadchr(substr(nms,1,60), '' '',60)||''|''||'||nlchr||
                           'rpadchr(tt, '' '',3)||''|''name'||nlchr||
                           'from V_OB_CORP_REPORT_LAST'||nlchr||
                           'where file_date = :sFdat1'||nlchr||
                           'and corporation_id = :KODK'||nlchr||
                           'and instr(decode(:nbs,''%'',substr(nls,1,4),:nbs),substr(nls,1,4))>0'||nlchr||
                           'and instr(decode(:nls,''%'',nls,:nls),nls)>0';
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
    l_rep.description :='K-файл (Консолідована виписка)';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',7,sFdat,sFdat,"",TRUE,TRUE';
    l_rep.ndat        :=1;
    l_rep.mask        :='K*';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 210; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5049;


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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_***_5049.sql =========*** End 
PROMPT ===================================================================================== 

