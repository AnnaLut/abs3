prompt ===================================== 
prompt == Звіт з купівлі банківських металів ФО/ФОП/ЮО
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
   l_zpr.name := 'Звіт з купівлі банківських металів ФО/ФОП/ЮО';
   l_zpr.pkey := '\BRS\SBM\ZAY\4018';

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
    l_zpr.name         := 'Звіт з купівлі банківських металів ФО/ФОП/ЮО';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':Param0=''Код ЄДРПОУ/РНОКПП:'',:Param1=''Серія документу:'',:Param2=''Номер документу:''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_4018.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param1=''%'',:Param2=''%''';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := '    select z.*, b.name kf_name
    , bars.f_zay_get_state(p_sos => z.sos,p_viza => z.viza,
                           p_priority =>(select zz.priority from v_zay zz where zz.id=z.zay_id) 
                          ) state
    from zay_val_control z
        inner join banks_ru b on B.MFO=z.mfo 
        inner join tabval tv  on tv.kv=z.kv2 and tv.prv=1
    where     
      z.okpo  = :Param0
      and ( (z.SER_PASP  like nvl(:Param1,z.SER_PASP) )   or z.ser_pasp is null)
      and ( (z.NOM_PASP like nvl(:Param2,z.NOM_PASP) ) or z.nom_pasp is null)
      and z.sos in (0,1) and z.viza in (1,2)
      and (z.zay_date_v = trunc(sysdate) or z.zay_date_v is null)
      and Z.ZAY_DATE >=trunc(sysdate)-30
';
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
    l_rep.description :='Звіт з купівлі банківських металів ФО/ФОП/ЮО';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',19,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    


    if l_isnew = 1 then                        
       l_isnewr:=1;                            
    else                                        
       begin                                    
          select id into l_rep.id               
          from reports                          
          where substr(param, 1,instr(param,',')-1)=to_char(l_zpr.kodz) 
                and form='frm_FastReport'      
                and rownum=1;                   
                                                
          l_message:=l_message||nlchr||'Существуют печатные отчеты, которые ссылаются на данный кат.запрос.';
                                                
          update reports set                    
            name        = l_rep.name,           
            description = l_rep.description,    
            form        = l_rep.form,           
            param       = l_rep.param,          
            ndat        = l_rep.ndat,           
            mask        = l_rep.mask,           
            usearc      = l_rep.usearc,         
            idf         = l_rep.idf             
          where id in (                         
           select id from reports               
           where substr(param, 1,instr(param,',')-1)=to_char(l_zpr.kodz) 
           and form='frm_FastReport');                             
                                                 
          l_message:=l_message||nlchr||'Печатные отчеты - изменены.';
                                                 
       exception when no_data_found then         
          l_isnewr:=1;                           
       end;                                      
                                                 
     end if;                                     

                                                 
     if l_isnewr = 1 then    l_rep.id := 4018;
      -- Фиксированный № печатного отчета   
        begin                                    
           insert into reports values l_rep;     
           l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
        exception when dup_val_on_index then     
           bars_error.raise_error('REP',13,to_char(l_rep.id));
        end;                                     
     end if;                                     

                                           
 begin
  insert into app_rep (CODEAPP, CODEREP, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR, ACODE)
  values ('$RM_DRU1',l_rep.id, 1, null, null, null, null, null, null, 1, null);
  exception
  when dup_val_on_index then
    null;
  end;
                                         
    bars_report.print_message(l_message);   
end;                                        
/                                           

                                            
commit;                                     
