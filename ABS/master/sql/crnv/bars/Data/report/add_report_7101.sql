prompt ===================================== 
prompt == Виписка по рахунку нова
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
   l_zpr.name := 'Виписка по рахунку нова';
   l_zpr.pkey := '\BRS\SBR\REP\7101';

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
    l_zpr.name         := 'Виписка по рахунку нова';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':Param0=''Ключ''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep7101.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select distinct o.tt,
                                  o.ref,
                                  o.nd,
                                  case o.dk when 1 then  o.s else 0 end dt,
                                  case o.dk when 0 then  o.s else 0 end kt,
                                  o.nazn,
                                  to_char(to_date(asv.dzagr,''dd.mm.yyyy'' ),''dd.mm.yyyy'' ) dat1,
                                  to_char( trunc (sysdate) ) dat2,
                                  asv.nls,
                                  (select max(v.dat) from oper_visa v where o.ref = v.ref) pdat,
                                  op_s.name,
                                  o.sos,
                                  asv.fio,
                                  asv.idcode,
                                  asv.ost,
                                  asv.kv
                           from asvo_immobile asv 
                               left outer join bars.operw op    on asv.key = to_char(op.value)  and op.tag = ''REF92'' and op.value = :Param0
                               left outer join bars.oper o      on o.ref = op.ref and trunc(o.pdat) between to_date(asv.dzagr,''dd.mm.yyyy'') and trunc(sysdate)  and o.sos in (5,-1)
                               left outer join bars.op_sos op_s on op_s.sos = o.sos      
                          where  asv.key  = :Param0
                           order by pdat';
    l_zpr.xsl_data     := '';
    l_zpr.xsd_data     := '';

    if l_isnew = 1 then           
       insert into zapros values l_zpr;  
       l_message:=l_message||'Добавлен новый кат.запрос №'||l_zpr.kodz||'.'; 
    else                           
       update zapros set name         = l_zpr.name,        
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
    l_rep.description :='Виписка по рахунку нова';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',19,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=0;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    
    
 -- Фиксированный № печатного отчета   
    l_rep.id          :=7101;


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
   
    begin
       Insert into BARS.APP_REP WOPR
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('WOPR', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Друк Звітів';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ друк Звітів';
    end;                                           
                                           
    bars_report.print_message(l_message);   
end;                                        
/                                           
   
commit;