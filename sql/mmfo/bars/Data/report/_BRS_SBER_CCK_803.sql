

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_CCK_803.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Попередній реєстр клієнтів із залученням компенсаційних програм
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
   l_zpr.name := 'Попередній реєстр клієнтів із залученням компенсаційних програм';
   l_zpr.pkey := '\BRS\SBER\CCK\803';

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
    l_zpr.name         := 'Попередній реєстр клієнтів із залученням компенсаційних програм';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''З:'',:sFdat2=''ПО:''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'CCK797.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select rownum as rn,
       c.nmk,
       c.okpo,
       substr(D.PROD,5,2) as ob22,
       (select ''Номер ''||d.cc_id||chr(13)||chr(10)|| ''Дата ''||to_date(d.DSDATE, ''dd/MM/yyyy'') from dual) as num,
       round(months_between(d.dwdate,d.dsdate)) as moun,
       d.pr,
       case  when cck_app.Get_ND_TXT(d.nd,''SQBA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'' then  cck_app.Get_ND_TXT(d.nd,''SQBA4'')  
             when cck_app.Get_ND_TXT(d.nd,''SQCA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'' then  cck_app.Get_ND_TXT(d.nd,''SQCA4'') 
             when cck_app.Get_ND_TXT(d.nd,''SQDA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQDA1'') = ''Міста'' then  cck_app.Get_ND_TXT(d.nd,''SQDA4'') end countcom,
       to_number(d.sdog) as sum,
       case  when cck_app.Get_ND_TXT(d.nd,''SQBA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'' then round(((select sum((c.sumo - c.sumg)/100) from cc_lim c where nd =D.ND)/d.pr * to_number(cck_app.Get_ND_TXT(d.nd,''SQBA4'')))) 
             when cck_app.Get_ND_TXT(d.nd,''SQCA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'' then round(((select sum((c.sumo - c.sumg)/100) from cc_lim c where nd =D.ND)/d.pr * to_number(cck_app.Get_ND_TXT(d.nd,''SQCA4''))))
             when cck_app.Get_ND_TXT(d.nd,''SQDA3'') = 1 and cck_app.Get_ND_TXT(d.nd,''SQDA1'') = ''Міста'' then round(((select sum((c.sumo - c.sumg)/100) from cc_lim c where nd =D.ND)/d.pr * to_number(cck_app.Get_ND_TXT(d.nd,''SQDA4'')))) end as sumproc,
       (select
                        REGION||'',''||chr(13)||chr(10)||
                        decode(locality_type,1,''м.'',3,''c.'',2,''смт.'',5, ''ст.'',4, ''хут.'',null )||decode(locality,null,null,(locality||'', ''))||chr(13)||chr(10)||
                        decode(STREET_type,1,''вул.'',2,''пр-т'',3,''б-р'',4, ''пров.'',5, ''шос.'',6, ''уз.'',7, ''туп.'',8, ''пл.'',9, ''кв.'',10, ''м-н'',11, ''ж/м'',null )||decode(STREET,null,null,(STREET||'', ''))||chr(13)||chr(10)||
                        decode(HOME_type,1,''буд.'',2,''д/в'',null )||decode(HOME,null,null,(HOME||'', ''))||chr(13)||chr(10)||
                        decode(ROOM_type,1,''кв.'',2,''кімн.'',3,''оф. '',null )||decode(ROOM,null,null,(ROOM||'', ''))
                         from customer_address where rnk= C.RNK and TYPE_ID = 1 and rownum =1) custadress,
       (select NAME from branch where branch = d.branch) as ru,
       nullif((select NAME from V_STTYPE where id = cck_app.Get_ND_TXT(d.nd,''SQBA3'') and cck_app.Get_ND_TXT(d.nd,''SQBA3'')=1 and  cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'')||chr(13)||chr(10), chr(13)||chr(10))||
       nullif((select NAME from V_STTYPE where id = cck_app.Get_ND_TXT(d.nd,''SQCA3'')and cck_app.Get_ND_TXT(d.nd,''SQCA3'')=1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'')||chr(13)||chr(10), chr(13)||chr(10))||
       (select NAME from V_STTYPE where id = cck_app.Get_ND_TXT(d.nd,''SQDA3'')and cck_app.Get_ND_TXT(d.nd,''SQDA3'')=1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'') typecom,
       case when  cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'' then cck_app.Get_ND_TXT(d.nd,''SQBA1'')
            when  cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'' then cck_app.Get_ND_TXT(d.nd,''SQCA1'')
            when  cck_app.Get_ND_TXT(d.nd,''SQDA1'') = ''Міста'' then cck_app.Get_ND_TXT(d.nd,''SQDA1'')
            end  zalcom,
       case when  cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'' then cck_app.Get_ND_TXT(d.nd,''SQBA2'')
            when  cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'' then cck_app.Get_ND_TXT(d.nd,''SQCA2'')
            when  cck_app.Get_ND_TXT(d.nd,''SQDA1'') = ''Міста'' then cck_app.Get_ND_TXT(d.nd,''SQDA2'')
            end LOCALITY,
       (select a.ob22
                    from nd_acc na, accounts a
                    where a.nbs in (''2620'',''2625'')
                    and a.dazs is null
                    and na.nd = d.nd
                    and na.acc = a.acc
                    and rownum = 1) as ob22_2620 
 from cc_v d, customer c
 where 
        substr(d.prod,1,6) in (''220256'',''220257'',''220258'',''220346'',''220347'',''220348'')
        and d.sos in (10,11,13,15)
        and d.rnk = c.rnk
        and d.dsdate  between to_date(:sFdat1,''dd/MM/yyyy'') and  to_date(:sFdat2,''dd/MM/yyyy'')
        and (cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'' or
             cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'' or
             cck_app.Get_ND_TXT(d.nd,''SQDA1'') = ''Міста'')
        and (cck_app.Get_ND_TXT(d.nd,''SQBA3'') = 1 or
             cck_app.Get_ND_TXT(d.nd,''SQCA3'') = 1 or
             cck_app.Get_ND_TXT(d.nd,''SQDA3'') = 1 )
        and (select nullif((select NAME from V_STTYPE where id = cck_app.Get_ND_TXT(d.nd,''SQBA3'') and cck_app.Get_ND_TXT(d.nd,''SQBA3'')=1 and  cck_app.Get_ND_TXT(d.nd,''SQBA1'') = ''Міста'')||chr(13)||chr(10), chr(13)||chr(10))||
             nullif((select NAME from V_STTYPE where id = cck_app.Get_ND_TXT(d.nd,''SQCA3'')and cck_app.Get_ND_TXT(d.nd,''SQCA3'')=1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'')||chr(13)||chr(10), chr(13)||chr(10))||
            (select NAME from V_STTYPE where id = cck_app.Get_ND_TXT(d.nd,''SQDA3'')and cck_app.Get_ND_TXT(d.nd,''SQDA3'')=1 and cck_app.Get_ND_TXT(d.nd,''SQCA1'') = ''Міста'') from dual)  is not null';
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
    l_rep.description :='Попередній реєстр клієнтів із залученням компенсаційних програм';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 803;


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

exec umu.add_report2arm(803,'$RM_DRU1');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_CCK_803.sql =========*** End 
PROMPT ===================================================================================== 
