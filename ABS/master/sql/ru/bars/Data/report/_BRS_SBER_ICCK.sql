

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_ICCK.sql =========*** Run ***
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Визначенi Кредитнi справи в сховищi
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
   l_zpr.name := 'Визначенi Кредитнi справи в сховищi';
   l_zpr.pkey := '\BRS\SBER\ICCK';

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
    l_zpr.name         := 'Визначенi Кредитнi справи в сховищi';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':BRANCH=''Бранч-2''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'ICCK.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':BRANCH=''%'''; 
    l_zpr.bind_sql     := ':BRANCH=''BRANCH|BRANCH|NAME|WHERE length(branch)=15 order by branch ''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT I.BRANCH, I.S_02, I.S_83, I.S_79,I.S_03,I.S_I3, I.S_B8, E.SDATE, E.CC_ID, E.RNK, E.NMK, I.ND, I.K_02, I.K_83, I.K_79,I.K_03,I.K_I3,I.K_B8, e.branch as branch_kd  
FROM (select TO_CHAR(d.nd) nd, d.rnk, d.cc_id, d.sdate, c.nmk, d.sos, d.branch from V_CC_DEAL D, CUSTOMER C where d.rnk=c.rnk and d.branch like decode(SYS_CONTEXT (''bars_context'', ''user_branch''), ''/''||f_ourmfo||''/000000/'',''%'',SYS_CONTEXT (''bars_context'', ''user_branch'')||''%'')) E,
  (SELECT S.BRANCH, S.S_02, S.S_83, S.S_79,S.S_03, S.S_I3, S.S_B8,  NVL(K.ND,0) ND, K.K_02, K.K_83, K.K_79, K.K_03, K.K_I3, K.K_B8
   FROM  (SELECT BRANCH, -SUM(DECODE (OB22,''02'',OSTC,0))/100 S_02,
                         -SUM(DECODE (OB22,''83'',OSTC,0))/100 S_83, 
                         -SUM(DECODE (OB22,''79'',OSTC,0))/100 S_79,
                         -SUM(DECODE (OB22,''03'',OSTC,0))/100 S_03,
                         -SUM(DECODE (OB22,''I3'',OSTC,0))/100  S_I3, 
                         -SUM(DECODE (OB22,''B8'',OSTC,0))/100 S_B8                         
          FROM accounts WHERE NBS =''9819'' AND OB22 IN (''02'',''03'',''79'',''83'',''B8'',''I3'') 
               AND LENGTH(BRANCH)=15 AND BRANCH LIKE :BRANCH           
          GROUP BY BRANCH    ) S,   
         (SELECT A.BRANCH, W.ND,
                -SUM(DECODE(O.DK,0,-1,1) *  DECODE(A.OB22,''02'',O.S,0))/100 K_02,
                -SUM(DECODE(O.DK,0,-1,1) *  DECODE(A.OB22,''83'',O.S,0))/100 K_83,     
                -SUM(DECODE(O.DK,0,-1,1) *  DECODE(A.OB22,''79'',O.S,0))/100 K_79,
                -SUM(DECODE(O.DK,0,-1,1) *  DECODE(A.OB22,''03'',O.S,0))/100 K_03,
                -SUM(DECODE(O.DK,0,-1,1) *  DECODE(A.OB22,''I3'',O.S,0))/100  K_I3, 
                -SUM(DECODE(O.DK,0,-1,1) *  DECODE(A.OB22,''B8'',O.S,0))/100 K_B8                        
          FROM OPLDOK O, 
               accounts A, 
               (select ref, value ND from OPERW where tag=''ND'')  w,   
               BRANCH_PARAMETERS  i, saldoa s
          WHERE i.branch LIKE :BRANCH 
            and i.tag    = ''REF_ICCK''
            and o.ref   >= to_number(i.VAL)  
            and a.dazs is null and A.ACC = O.ACC AND A.NBS =''9819'' AND A.OB22 IN (''02'',''79'',''83'',''03'',''I3'',''B8'') 
            AND O.REF = W.REF
            and o.sos = 5  and a.acc = s.acc and o.fdat = s.fdat 
            AND LENGTH(A.BRANCH)=15 AND A.BRANCH LIKE :BRANCH   
            AND O.FDAT >= TO_DATE (''21.02.2011'',''DD.MM.YYYY'') 
          GROUP BY A.BRANCH, W.ND ) K         
   WHERE S.BRANCH = K.BRANCH (+)  ) I
where i.nd = E.nd(+)  
  and (e.sos < 15 or ( e.sos = 15 and  (abs(I.K_02) + abs(I.K_83) + abs(I.K_79) + abs(I.K_03) + abs(I.K_I3) + abs(I.K_B8)) <> 0))
order by e.branch, i.branch, i.nd';
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
    l_rep.description :='Визначенi Кредитнi справи в сховищi';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=0;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 180; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 495;


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
               ('ICCK', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Інвентаризацiя Кредитних Справ в сховищi';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Інвентаризацiя Кредитних Справ в сховищi';
    end;

    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('WIKD', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Інвентаризацiя кредитних справ в сховищi(WEB)';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Інвентаризацiя кредитних справ в сховищi(WEB)';
    end;

    begin
       Insert into BARS.APP_REP
               (CODEAPP, CODEREP, APPROVE, GRANTOR)
       Values
               ('DRU1', l_rep.id, 1, 1);
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' добавлен в АРМ Друк звітів';
    exception when dup_val_on_index
          then 
          l_message:=l_message||nlchr||'Печатный отчет под №'||l_rep.id||' существует в АРМ Друк звітів';
    end;

    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_ICCK.sql =========*** End ***
PROMPT ===================================================================================== 
