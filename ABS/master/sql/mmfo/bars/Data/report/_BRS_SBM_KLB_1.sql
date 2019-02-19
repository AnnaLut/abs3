prompt ===================================== 
prompt == Документи електронних клієнтів 
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
   l_zpr.name := 'Документи електронних клієнтів';
   l_zpr.pkey := '\BRS\SBM\KLB\1';

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
    l_zpr.name         := 'Документи електронних клієнтів';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:Param0=''Маска_рахунку(%-всі)'',:BRANCH=''Код відділення'',:Param5=''З підлеглими відділ.(1-так,0-ні)'',:Param6=''Стан документа(5-опл.,1- не опл.)'',:Param7=''Код исполнителя(%-все)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'RP_PETM.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':Param0=''%'',:BRANCH=''Поточне'',:Param5=''0'',:Param6=''5'',:Param7=''%''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT  distinct :sFdat1 DAT1, :sFdat2 DAT2, c.sab SAB, o.ref REF, o.nd ND,     '||nlchr||
                           '        o.nlsa NLSA, o.nam_a NAM_A, o.mfoa MFOA,      '||nlchr||
                           '        o.nlsb NLSB, o.nam_b NAM_B, o.mfob MFOB,  '||nlchr||
                           '        o.S/100 S,   o.dk DK,      '||nlchr||
                           '        ba.nb NB_A,  bb.nb NB_B, o.nazn NAZN,  '||nlchr||
                           '        o.id_a ID_A, o.id_b ID_B '||nlchr||
                           '----,to_char(o.pdat,''dd-mm-yyyy'') VDAT, to_char(l.fdat,''dd-mm-yyyy'') FDAT '||nlchr||
                           ' FROM oper o, accounts a, customer c,'||nlchr||
                           '      banks ba,banks bb,opldok l '||nlchr||
                           ' WHERE o.sos=:Param6  and '||nlchr||
                           '       o.ref=l.ref   '||nlchr||
                           '       and l.fdat >=:sFdat1 '||nlchr||
                           '       and l.fdat <=:sFdat2   '||nlchr||
                           '       and o.pdat >=:sFdat1'||nlchr||
                           '       and o.nlsa=a.nls'||nlchr||
                           '       and o.kv=a.kv   '||nlchr||
                           '       and a.nls like decode(:Param0,''%'',a.nls,:Param0||''%'')'||nlchr||
                           '       and  ((:Param5 =''1'' '||nlchr||
                           '             and o.branch like '||nlchr||
                           '                    decode(:BRANCH,''Поточне'', sys_context(''bars_context'',''user_branch''), :BRANCH)||''%'')'||nlchr||
                           '             or  (:Param5=''0'' and o.branch='||nlchr||
                           '                    decode(:BRANCH,''Поточне'', sys_context(''bars_context'',''user_branch''), :BRANCH)))'||nlchr||
                           '       and a.rnk=c.rnk  '||nlchr||
                           '       --and o.tt in (''KL1'',''KL2'')'||nlchr||
                           '       and o.tt in (''IB1'',''IB2'',''IB3'',''IB4'',''IB5'',''IB6'',''IBB'',''IBO'',''IBS'') --COBUMMFO-9649    '||nlchr||
                           '       and o.mfoa=ba.mfo and o.mfob=bb.mfo'||nlchr||
                           '       and a.isp = decode(:Param7,''%'',a.isp,:Param7) '||nlchr||
                           ' order by NLSA,DK,S'||nlchr||
                           '';
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
    l_rep.description :='Документи електронних клієнтів';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 190; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 269;


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

