

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_REP_5752.sql =========*** Run
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == БАЛАНС оборотiв i залишкiв в ГРН-еквiвалентi
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
   l_zpr.name := 'БАЛАНС оборотiв i залишкiв в ГРН-еквiвалентi';
   l_zpr.pkey := '\BRS\SBER\REP\5752';

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
    l_zpr.name         := 'БАЛАНС оборотiв i залишкiв в ГРН-еквiвалентi';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'BZ001S.frx';
    l_zpr.form_proc    := 'P_BAL_SNP(1, to_date (:sFdat1, ''dd-mm-yyyy''), '''', '''', '''')';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select B1, K, R, G, NBS, DOS, KOS, OSTD, OSTK, SK, SR, SG, SB1, DAT, decode(rownum, 1, 0, 1) titl
  from (select B1, K, R, G, NBS, DOS, KOS, OSTD, OSTK, SK, SR, SG, SB1, DAT
          from tmp_bal
         where b1 = 7
         order by k, r, g, nbs) k
 union all
select B1, K, R, G, NBS, DOS, KOS, OSTD, OSTK, SK, SR, SG, SB1, DAT, decode(rownum, 1, 0, 1) titl
  from (select B1, K, R, G, NBS, DOS, KOS, OSTD, OSTK, SK, SR, SG, SB1, DAT
          from tmp_bal
         where b1 = 9
         order by k, r, g, nbs) k';
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
    l_rep.description :='БАЛАНС оборотiв i залишкiв в ГРН-еквiвалентi';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',19,sFdat,sFdat,"",FALSE,FALSE';
    l_rep.ndat        :=1;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5752;


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

exec umu.add_report2arm(5752,'$RM_AN01');
exec umu.add_report2arm(5752,'$RM_ANI1');
exec umu.add_report2arm(5752,'$RM_BUHG');
exec umu.add_report2arm(5752,'$RM_REZR');
exec umu.add_report2arm(5752,'$RM_TEHA');
exec umu.add_report2arm(5752,'$RM_UCCK');
exec umu.add_report2arm(5752,'$RM_DRU1');
exec umu.add_report2arm(5752,'$RM_BVBB');
exec umu.add_report2arm(5752,'$RM_MAIN');
exec umu.add_report2arm(5752,'$RM_BVB ');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBER_REP_5752.sql =========*** End
PROMPT ===================================================================================== 
