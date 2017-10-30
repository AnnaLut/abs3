prompt ===================================== 
prompt == Звіт для контролю файлів стат звітності по валютних операціях на РУ
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
   l_zpr.name := 'Звіт для контролю файлів стат звітності по валютних операціях';
   l_zpr.pkey := '\BRS\SBR\REP\5502';

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
    l_zpr.name         := 'Звіт для контролю файлів стат звітності по валютних операціях';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''Дата з (DD.MM.YYYY)'',:sFdat2=''Дата по (DD.MM.YYYY)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'rep_5502.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select 
(select ''#F20:''||s.value||''#'' from sw_operw s where s.tag = 20 and s.swref = so.swref and rownum = 1) S_20,
(select ''#F32A:''||s.value||''#'' from sw_operw s where s.tag = 32 and s.opt = ''A'' and s.swref = so.swref and rownum = 1) S_32A,
(select ''#F33B:''||s.value||''#'' from sw_operw s where s.tag = 33 and s.opt = ''B'' and s.swref = so.swref and rownum = 1) S_33B,
(select ''#F50F:''||replace(s.value,chr(13)||chr(10), ''#''||chr(13)||chr(10)||''#'')||''#'' from sw_operw s where s.tag = 50 and s.opt = ''F'' and s.swref = so.swref and rownum = 1) S_50F,
(select ''#F52A:''||s.value||''#'' from sw_operw s where s.tag = 52 and s.opt = ''A'' and s.swref = so.swref and rownum = 1) S_52A,
(select ''#F57A:''||s.value||''#'' from sw_operw s where s.tag = 57 and s.opt = ''A'' and s.swref = so.swref and rownum = 1) S_57A,
(select ''#F59:''||replace(s.value,chr(13)||chr(10), ''#''||chr(13)||chr(10)||''#'')||''#'' from sw_operw s where s.tag = 59 and s.swref = so.swref and rownum = 1) S_59,
(select ''#F70:''||s.value||''#'' from sw_operw s where s.tag = 70 and s.swref = so.swref and rownum = 1) S_70,
(select ''#F71A:''||s.value||''#'' from sw_operw s where s.tag = 71 and s.opt = ''A'' and s.swref = so.swref and rownum = 1) S_71A,
o.branch, o.ref, o.tt, o.nd, to_date(o.pdat, ''dd.mm.yy'') pdat, o.kv, o.s, o.sq, o.nlsa, o.nam_a, o.mfoa, o.nlsb, o.nam_b, o.mfob, o.nazn from oper o, sw_oper so where o.ref = so.ref and o.kv != 980 
and (o.nlsa like ''1500%'' or o.nlsa like ''1600%'') 
and (o.nlsb = decode(o.mfob, ''302076'', ''29090100010082'',
decode(o.mfob, ''303398'', ''29093100020082'',
decode(o.mfob, ''305482'', ''29098100030082'',
decode(o.mfob, ''335106'', ''29093100040082'',
decode(o.mfob, ''311647'', ''29095100050082'',
decode(o.mfob, ''312356'', ''29095100060082'', 
decode(o.mfob, ''313957'', ''29097100070082'',
decode(o.mfob, ''336503'', ''29094100080082'',
decode(o.mfob, ''323475'', ''29095100100082'',
decode(o.mfob, ''304665'', ''29097100120082'',
decode(o.mfob, ''325796'', ''29099100130082'',
decode(o.mfob, ''326461'', ''29095100140082'',
decode(o.mfob, ''328845'', ''29090100150082'', 
decode(o.mfob, ''331467'', ''29093100160082'',
decode(o.mfob, ''333368'', ''29095100170082'',
decode(o.mfob, ''337568'', ''29096100180082'',
decode(o.mfob, ''338545'', ''29094100190082'',
decode(o.mfob, ''351823'', ''29090100200082'',
decode(o.mfob, ''352457'', ''29095100210082'',
decode(o.mfob, ''315784'', ''29093100220082'',
decode(o.mfob, ''354507'', ''29097100230082'',
decode(o.mfob, ''353553'', ''29097100230082'', 
decode(o.mfob, ''356334'', ''29096100250082'',
decode(o.mfob, ''322669'', ''29092100260082'' )))))))))))))))))))))))) or 
o.nlsb in (select a.nls from accounts a where a.nbs = ''2909'' and a.ob22 = ''56'' and a.kv = o.kv and o.mfob = a.kf) )
and (to_date(o.pdat, ''dd.mm.yy'') between to_date(:sFdat1,''dd.mm.yyyy'') and to_date(:sFdat2,''dd.mm.yyyy'') )';
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
    l_rep.description :='Звіт для контролю файлів стат звітності по валютних операціях на РУ';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",FALSE,FALSE';
    l_rep.ndat        :=0;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 160;
    exception when no_data_found then
        l_repfolder := null;
    end;
    l_rep.idf := l_repfolder;

    -- Фиксированный № печатного отчета
    l_rep.id          := 5502;


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
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('$RM_DRU1', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Друк звітів';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Друк звітів';
    end;

    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('$RM_NBUR', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Звітність (новий)';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Звітність (новий)';
    end;

    bars_report.print_message(l_message);
end;
/

commit;
