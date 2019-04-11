

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_5759.sql =========*** Run 
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Довідка про перерах. коштів, що не залучені у вигляді кредиту
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
   l_zpr.name := 'Довідка про перерах. коштів, що не залучені у вигляді кредиту';
   l_zpr.pkey := '\BRS\SBM\REP\5759';

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
    l_zpr.name         := 'Довідка про перерах. коштів, що не залучені у вигляді кредиту';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':Param0=''ЄДРПОУ'',:Param1=''Референс документу''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '5759.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'with t as (
  select distinct
         c.nmk,
         c.adr,
         o.s,
         o.nd,
         o.datd,
         o.ref,
         o.dk,
         o.nam_a,
         o.id_a,
         bank_a.nb as nba,
         o.mfoa,
         o.nlsa,
         o.nam_b,
         o.id_b,
         bank_b.nb as nbb,
         o.mfob,
         o.nlsb,
         kv.lcv,
         kv.kv,
         kv.gender,
         o.nazn
    from customer c
    join cust_acc ca on ca.rnk = c.rnk
    join accounts a on a.acc = ca.acc
    join opldok opl on opl.acc = a.acc
    join oper o on o.ref = opl.ref
    join tabval kv on kv.kv = o.kv
    join banks$base bank_a on bank_a.mfo = o.mfoa
    join banks$base bank_b on bank_b.mfo = o.mfob
   where c.okpo = :Param0
     and o.ref = :Param1)

select nmk,
       adr,
       s/100 as s,
       nd,
       replace(f_month_lit(datd), ''"'', '''') as datd1,
       f_doc_attr(''STAFF_FIO'', 0) as executant,
       nd||'' (#''||ref||'')'' as ndref,
       f_month_lit(datd) as datd2,
       ''"''||to_char(datd, ''DD/MM/YYYY'')||''"р.'' as datd3,
       decode(dk, 1, nam_a, nam_b) as nam_pl,
       decode(dk, 1, id_a, id_a) as id_pl,
       decode(dk, 1, nba, nbb) as nb_pl,
       decode(dk, 1, mfoa, mfob) as mfo_pl,
       decode(dk, 1, nlsa, nlsb) as dt_nls,
       decode(dk, 1, nam_b, nam_a) as nam_otr,
       decode(dk, 1, id_b, id_a) as id_otr,
       decode(dk, 1, nbb, nba) as nb_otr,
       decode(dk, 1, mfob, mfoa) as mfo_otr,
       decode(dk, 1, nlsb, nlsa) as kt_nls,
       lcv,
       f_sumpr(nSum_      => s,
               nCcyCode_  => kv,
               strGender_ => gender) s_txt,
       nazn
  from t';
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
    l_rep.description :='Довідка про перерах. коштів, що не залучені у вигляді кредиту';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',19,sFdat,sFdat,"",TRUE,FALSE';
    l_rep.ndat        :=0;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 5759;


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

exec umu.add_report2arm(5759,'$RM_DRU1');
commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_BRS_SBM_REP_5759.sql =========*** End 
PROMPT ===================================================================================== 
