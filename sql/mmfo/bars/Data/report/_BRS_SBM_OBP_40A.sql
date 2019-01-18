

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_OBP_40A.sql =========*** Run *
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Выписка ДСС way4
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
   l_zpr.name := 'Выписка ДСС way4';
   l_zpr.pkey := '\BRS\SBM\OBP\40A';

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
    l_zpr.name         := 'Выписка ДСС way4';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:p_rnk=''RNK комп.'',:p_nls=''Номер счета корп карты DSS'',:kv=''Код валюты''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'dss.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':p_rnk=''31609'',:kv=''980''';
    l_zpr.bind_sql     := ':kv=''TABVAL|KV|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select w4a.card_code,
       w4a.nls_pk,
       :sFdat1 dat1,
       :sFdat2 dat2,
       (select kv||'' ''||tv.name from tabval$global tv where tv.kv= w4a.kv) kv,
       aw.value owner,
       (fost(w4a.acc_pk,to_date(:sFdat1,''dd.mm.yyyy'') -1)/100
        -decode(w4a.acc_2208,null,0,fost(w4a.acc_2208,to_date(:sFdat1,''dd.mm.yyyy'') -1))/100
        -decode(w4a.acc_3570,null,0,fost(w4a.acc_3570,to_date(:sFdat1,''dd.mm.yyyy'') -1))/100
       ) as inost,
       o.NAZN,
       ow.value owdat,
       sq/100*(decode(o.dk,0,-1,o.dk)),
        s/100*(decode(o.dk,0,-1,o.dk)),
       o.fdat,
       (fost(w4a.acc_pk,:sFdat2)/100
        -decode(w4a.acc_2208,null,0,fost(w4a.acc_2208,:sFdat2))/100
        -decode(w4a.acc_3570,null,0,fost(w4a.acc_3570,:sFdat2))/100
       ) outost,
       ow2.value
  from v_w4_accounts w4a
  left join opl o
    on w4a.acc_pk  = o.ACC
   and o.sos=5
   and o.FDAT between :sFdat1 and :sFdat2
  left join accountsw aw
    on aw.acc=w4a.acc_pk
   and aw.tag=''W4_CPN''
  left join operw ow
    on o.ref = ow.ref
   and ow.tag = ''OW_LD''
  LEFT JOIN operw ow2
    ON ow.ref=ow2.ref AND ow2.tag=''OW_DS''
 where w4a.rnk=:p_rnk
   and w4a.daos_pk<=:sFdat2
   and (w4a.dazs_pk is null or w4a.dazs_pk>=:sFdat2)
   and w4a.nls_pk=:p_nls
   and w4a.kv=:kv
  order by w4a.acc_pk,fdat ';
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
    l_rep.description :='Выписка ДСС way4';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 75; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 4020;


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

exec umu.add_report2arm(4020,'$RM_DRU1');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_OBP_40A.sql =========*** End *
PROMPT ===================================================================================== 
