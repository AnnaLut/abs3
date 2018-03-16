

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_ZVT_2.sql =========*** Run **
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == 2.Бранч: Зведення документiв дня - РЕЄСТР проводок по папкам
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
   l_zpr.name := '2.Бранч: Зведення документiв дня - РЕЄСТР проводок по папкам';
   l_zpr.pkey := '\BRS\SBER\ZVT\2';

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
    l_zpr.name         := '2.Бранч: Зведення документiв дня - РЕЄСТР проводок по папкам';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:T=''Код папки (0-всі)'',:I=''Код викон(0=всi)'',:P=''Перегляд-0,Папки бух_облік-1,Папка(26,27)-2,Папка(38,39)-3,Папки бек-офіс-4''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'ZVT2n.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':T=''0'',:I=''0'',:P=''0''';
    l_zpr.bind_sql     := ':T=''TEST_ZVT|TEMA|NAME|ORDER BY TEMA ''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select b.BRANCH, t.TEMA, d.ISP USERID, d.KV,  d.TT,  d.REF, d.NLSD, d.NLSK,  d.S  S, d.SQ ,  b.NAME, t.name NAMET
 from zvt_doc d, branch b, TEST_ZVT t
 where d.fdat = to_date( :sFdat1,''dd-mm-yyyy'')
   and d.branch like sys_context(''bars_context'',''user_branch'') || decode (length(sys_context(''bars_context'',''user_branch'') ), 8, ''%'', '''' )
   and b.branch = d.branch     and ( nvl(:P,''0'') = ''0'' or t.PRN =:P )
   and t.tema =  abs( d.tema)  and t.tema = decode(:T,''0'', t.tema, to_number(:T))
   and d.ISP = decode(:I,''0'', d.ISP, to_number(:I))
 order by 1, 2, 3,  sign(d.tema),4, 5, 6';
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
    l_rep.description :='2.Бранч: Зведення документiв дня - РЕЄСТР проводок по папкам';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 80; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 2;


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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_ZVT_2.sql =========*** End **
PROMPT ===================================================================================== 
