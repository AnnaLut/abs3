

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_***_5052.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == K-файл (Технічна виписка)
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
   l_zpr.name := 'K-файл (Технічна виписка)';
   l_zpr.pkey := '\BRS\SBM\***\5052';

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
    l_zpr.name         := 'K-файл (Технічна виписка)';
    l_zpr.namef        := 'select ''TG''||to_char(:sFdat1, ''yymmdd'')||''.''||(select SUBSTR(kod_s, -3) from clim_mfo where mfo = F_OURMFO)  from dual';
    l_zpr.bindvars     := ':sFdat1='''',:nbs=''Б/Р(всi-%)'',:nls=''Номер рахунку(всi-%)'',:KODK=''Код корпорації'',:okpo=''ОКПО(всi-%)'',:kod_analyt=''Код аналітичного обліку(всi-%)''';
    l_zpr.create_stmt  := 'COLUMNSELECT';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := 'null';
    l_zpr.default_vars := ':nbs=''%'',:nls=''%'',:KODK=''%'',:okpo=''%'',:kod_analyt=''%''';
    l_zpr.bind_sql     := ':KODK=''KOD_CLI|KOD_CLI''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select '||nlchr||
                           '''0''||'||nlchr||
                           'lpadchr(a.kf, ''0'',9)||'||nlchr||
                           'rpadchr(a.nls, '' '',14)||'||nlchr||
                           't.LCV||'||nlchr||
                           'to_char(a.postdat,''YYYYMMDD'')||'||nlchr||
                           'to_char(a.dapp,''YYYYMMDD'')||'||nlchr||
                           'lpadchr(to_char(abs(a.ostq+a.obdbq-a.obkrq)),'' '',19)||'||nlchr||
                           'lpadchr(to_char(abs(a.ost+a.obdb-a.obkr)),'' '',19)||'||nlchr||
                           'case when sign(a.ost+a.obdb-a.obkr) = -1 then ''-'' else ''+'' end||'||nlchr||
                           'lpadchr(to_char(d.kred),''0'',6)||'||nlchr||
                           'lpadchr(to_char(abs(a.obdbq)),'' '',19)||'||nlchr||
                           'lpadchr(to_char(abs(a.obdb)),'' '',19)||'||nlchr||
                           'lpadchr(to_char(d.deb),''0'',6)||'||nlchr||
                           'lpadchr(to_char(abs(a.obkrq)),'' '',19)||'||nlchr||
                           'lpadchr(to_char(abs(a.obkr)),'' '',19)||'||nlchr||
                           'lpadchr(to_char(abs(a.ostq)),'' '',19)||'||nlchr||
                           'lpadchr(to_char(abs(a.ost)),'' '',19)||'||nlchr||
                           'case when sign(a.ost) = -1 then ''-'' else ''+'' end||'||nlchr||
                           'rpadchr(a.okpo,'' '',14)||'||nlchr||
                           'rpadchr(substr(a.namk,1,38),'' '',38)||'||nlchr||
                           'rpadchr(substr(a.nms,1,60),'' '',60) name'||nlchr||
                           'from ob_corp_data_acc a'||nlchr||
                           'left join (select dd.sess_id, dd.acc,  '||nlchr||
                           '                  count(case when dd.dk = 0 then 1 else null end) as kred,'||nlchr||
                           '                  count(case when dd.dk = 1 then 1 else null end) as deb'||nlchr||
                           '             from ob_corp_data_doc dd'||nlchr||
                           '            group by dd.sess_id, dd.acc) d on a.acc = d.acc and a.sess_id = d.sess_id'||nlchr||
                           'left join tabval t on t.kv=a.kv'||nlchr||
                           'where a.FDAT = :sFdat1'||nlchr||
                           'and a.corp_id = :KODK'||nlchr||
                           'and a.is_last = 1'||nlchr||
                           'and instr(decode(:nbs,''%'',substr(a.nls,1,4),:nbs),substr(a.nls,1,4))>0'||nlchr||
                           'and instr(decode(:nls,''%'',a.nls,:nls),a.nls)>0'||nlchr||
                           'and instr(decode(:kod_analyt,''%'',nvl(a.kod_analyt,0),:kod_analyt),nvl(a.kod_analyt,0))>0'||nlchr||
                           'and instr(decode(:okpo,''%'',a.okpo,:okpo),a.okpo)>0'||nlchr||
                           'union all'||nlchr||
                           'select '||nlchr||
                           '''1''||'||nlchr||
                           'case when d.dk = 0 then ''-'' else ''+''end||'||nlchr||
                           'lpadchr(d.mfoa, ''0'',9)||'||nlchr||
                           'rpadchr(d.nlsa, '' '',14)||'||nlchr||
                           'rpadchr(d.okpoa, '' '',14)||'||nlchr||
                           'rpadchr(substr(d.nama,1,40), '' '',40)||'||nlchr||
                           'lpadchr(d.mfob, ''0'',9)||'||nlchr||
                           'rpadchr(d.nlsb, '' '',14)||'||nlchr||
                           'rpadchr(d.okpob, '' '',14)||'||nlchr||
                           'rpadchr(substr(d.namb,1,40), '' '',40)||'||nlchr||
                           'decode(d.dk,0,''02'',''01'')||'||nlchr||
                           'rpadchr(d.nd, '' '',10)||'||nlchr||
                           'lpadchr(d.sq, '' '',19)||'||nlchr||
                           'lpadchr(d.s, '' '',19)||'||nlchr||
                           'case when d.dk=1 then to_char(d.postdat,''YYYYMMDD'') else ''        '' end||'||nlchr||
                           'case when d.dk=1 and d.postdat is not null then to_char(d.postdat,''HHMM'') else ''    '' end||'||nlchr||
                           'case when d.dk=0 then to_char(d.postdat,''YYYYMMDD'') else ''        '' end||'||nlchr||
                           'case when d.dk=0 and d.postdat is not null then to_char(d.postdat,''HHMM'') else ''    '' end||'||nlchr||
                           'rpadchr(substr(d.nazn,1,255),'' '',255)'||nlchr||
                           'from ob_corp_data_acc a'||nlchr||
                           'join ob_corp_data_doc d on a.acc = d.acc and a.sess_id = d.sess_id'||nlchr||
                           'left join tabval t on t.kv=a.kv'||nlchr||
                           'where  a.FDAT = :sFdat1'||nlchr||
                           'and a.corp_id = :KODK'||nlchr||
                           'and a.is_last = 1'||nlchr||
                           'and instr(decode(:nbs,''%'',substr(a.nls,1,4),:nbs),substr(a.nls,1,4))>0'||nlchr||
                           'and instr(decode(:nls,''%'',a.nls,:nls),a.nls)>0'||nlchr||
                           'and instr(decode(:kod_analyt,''%'',nvl(a.kod_analyt,0),:kod_analyt),nvl(a.kod_analyt,0))>0'||nlchr||
                           'and instr(decode(:okpo,''%'',a.okpo, :okpo),a.okpo)>0';
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
    l_rep.description :='K-файл (Технічна виписка)';
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
    l_rep.id          := 5052;


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

commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_***_5052.sql =========*** End 
PROMPT ===================================================================================== 

