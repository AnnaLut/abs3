PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBR_REP_6001.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == 7.ВИК: Зведення документiв дня - РЕЄСТР проводок  (Папки,Бранчi+)
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
   l_zpr.name := '7.ВИК: Зведення документiв дня - РЕЄСТР проводок  (Папки,Бранчi+)';
   l_zpr.pkey := '\BRS\SBR\REP\6001';

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
    l_zpr.name         := '7.ВИК: Зведення документiв дня - РЕЄСТР проводок  (Папки,Бранчi+)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:TEMA=''Код папки (0-всі)'',:BRANCH=''Відділення (%-всі)'',:PRN=''Перегляд-0,Папки бух_облік-1,Папка(26,27)-2,Папка(38,39)-3,Папки бек-офіс-4'',:ISP=''Вик. (0-всі)'',:ROLE=''Роль(0-всі)'',:SECTOR=''Код сектору (0-всі)'',:TEAM=''Код відділу(0-всі)'',:DIVISION=''Код управління(0-всі)'',:DEPARTMENT=''Код департаменту(0-всі)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'ZVT_REG.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':TEMA=''0'',:BRANCH=''%'',:PRN=''0'',:ISP=''0'',:ROLE=''0'',:SECTOR=''0'',:TEAM=''0'',:DIVISION=''0'',:DEPARTMENT=''0''';
    l_zpr.bind_sql     := ':TEMA=''TEST_ZVT|TEMA|NAME|ORDER BY TEMA'',:BRANCH=''BRANCH2|BRANCH|NAME|WHERE BRANCH NOT LIKE ''/300465/%'' OR UPPER(NAME) LIKE ''%ОЩАД%'' OR BRANCH = ''/300465/'' ORDER BY BRANCH'',:ROLE=''ZVT_ROLE|ROLE_CODE|ROLE_ID|ORDER BY ROLE_CODE'',:SECTOR=''ZVT_SECTOR|SECTOR_ID|NAME|ORDER BY SECTOR_ID'',:TEAM=''ZVT_TEAM|TEAM_ID|NAME|ORDER BY TEAM_ID'',:DIVISION=''ZVT_DIVISION|DIVISION_ID|NAME|ORDER BY DIVISION_ID'',:DEPARTMENT=''ZVT_DEPARTMENT|DEPARTMENT_ID|NAME|ORDER BY DEPARTMENT_ID''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := '  SELECT t.TEMA,'||nlchr||
                           '         b.BRANCH,'||nlchr||
                           '         d.isp USERID,'||nlchr||
                           '         d.KV,'||nlchr||
                           '         d.TT,'||nlchr||
                           '         d.REF,'||nlchr||
                           '         d.NLSD,'||nlchr||
                           '         d.NLSK,'||nlchr||
                           '         d.S S,'||nlchr||
                           '         d.SQ,'||nlchr||
                           '         b.NAME,'||nlchr||
                           '         t.name NAMET,'||nlchr||
                           '         f_zvt_get_struct_name ( :SECTOR,'||nlchr||
                           '                                :TEAM,'||nlchr||
                           '                                :DIVISION,'||nlchr||
                           '                                :DEPARTMENT)'||nlchr||
                           '            AS struct,'||nlchr||
                           '         TO_DATE ( :sFdat1, ''dd.mm.yyyy'') AS zvt_date,'||nlchr||
                           '         (SELECT fio'||nlchr||
                           '            FROM staff$base'||nlchr||
                           '           WHERE id = user_id)'||nlchr||
                           '            AS fio'||nlchr||
                           '    FROM branch b, TEST_ZVT t, zvt_doc d'||nlchr||
                           '   WHERE     d.fdat = TO_DATE ( :sFdat1, ''dd.mm.yyyy'')'||nlchr||
                           '         AND (NVL ( :PRN, ''0'') = ''0'' OR t.PRN = :PRN)'||nlchr||
                           '         AND b.branch = SUBSTR (d.branch, 1, 15)'||nlchr||
                           '         AND t.tema = ABS (d.tema)'||nlchr||
                           '         AND t.tema = DECODE ( :TEMA, ''0'', t.tema, TO_NUMBER ( :TEMA))'||nlchr||
                           '         AND b.branch LIKE :BRANCH || DECODE (LENGTH ( :BRANCH), 8, '''', ''%'')'||nlchr||
                           '         AND d.isp IN (SELECT user_id'||nlchr||
                           '                             FROM V_ROLE_STAFF v'||nlchr||
                           '                            WHERE v.role_id IN (SELECT role_id'||nlchr||
                           '                                                  FROM zvt_role z'||nlchr||
                           '                                                 WHERE     nvl (Z.DEPARTMENT_ID,0) ='||nlchr||
                           '                                                              DECODE ('||nlchr||
                           '                                                                 :DEPARTMENT,'||nlchr||
                           '                                                                 0,  nvl (Z.DEPARTMENT_ID,0),'||nlchr||
                           '                                                                 :DEPARTMENT) --1'||nlchr||
                           '                                                       AND nvl(z.division_id,0) ='||nlchr||
                           '                                                              DECODE ('||nlchr||
                           '                                                                 :DIVISION,'||nlchr||
                           '                                                                 0,nvl(z.division_id,0),'||nlchr||
                           '                                                                 :DIVISION) --9'||nlchr||
                           '                                                       AND nvl(z.team_id,0) ='||nlchr||
                           '                                                              DECODE ('||nlchr||
                           '                                                                 :TEAM,'||nlchr||
                           '                                                                 0, nvl(z.team_id,0),'||nlchr||
                           '                                                                 :TEAM)   --19'||nlchr||
                           '                                                       AND nvl(z.sector_id,0) ='||nlchr||
                           '                                                              DECODE ('||nlchr||
                           '                                                                 :SECTOR,'||nlchr||
                           '                                                                 0, nvl(z.sector_id,0),'||nlchr||
                           '                                                                 :SECTOR)  --3'||nlchr||
                           '                                                       AND nvl(z.role_id,0) ='||nlchr||
                           '                                                              DECODE ('||nlchr||
                           '                                                                 :ROLE,'||nlchr||
                           '                                                                 0, nvl(z.role_id,0),'||nlchr||
                           '                                                                 :ROLE))'||nlchr||
                           '             and v.user_id = decode (:ISP,0,v.user_id,:ISP) )'||nlchr||
                           'ORDER BY 1,'||nlchr||
                           '         2,'||nlchr||
                           '         3,'||nlchr||
                           '         SIGN (tema),'||nlchr||
                           '         4,'||nlchr||
                           '         5,'||nlchr||
                           '         6';
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
    l_rep.description :='7.ВИК: Зведення документiв дня - РЕЄСТР проводок  (Папки,Бранчi+)';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 6001;


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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBR_REP_6001.sql =========*** End 
PROMPT ===================================================================================== 