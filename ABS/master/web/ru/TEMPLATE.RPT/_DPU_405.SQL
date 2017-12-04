prompt ===================================== 
prompt == Аналiз депозитного портфелю ЮО (Бранч+Вид)
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
   l_zpr.name := 'Аналiз депозитного портфелю ЮО (Бранч+Вид)';
   l_zpr.pkey := '\SBR\BRS\DPU\405';

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
    l_zpr.name         := 'Аналiз депозитного портфелю ЮО (Бранч+Вид)';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2=''''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'DPT_403.qrp ';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select k.BRANCH, k.KV, k.NBS, k.VIDD, k.VX,  k.VXQ ,k.DOS, k.DOSQ ,k.KOS, k.KOSQ, k.IX, k.IXQ, '||nlchr||
                           '       k.SR, k.ST, k.KOL, b.NAME, t.name VNAME,'||nlchr||
                           '                                      k.VX1, k.VX1Q,k.DOS1,k.DOS1Q,k.KOS1,k.KOS1Q,k.IX1,k.IX1Q,'||nlchr||
                           '                                      K.VKOL,K.DKOL,K.KKOL,K.IKOL       '||nlchr||
                           'from ( '||nlchr||
                           'select BRANCH, KV, NBS, VIDD,  '||nlchr||
                           '              sum (VX)   VX  , sum(dos )  DOS  , sum(kos)   KOS  , sum(ix)   IX,'||nlchr||
                           '              sum (VXq)  VXq , sum(dosq)  DOSq , sum(kosq)  KOSq , sum(ixq)  IXq,  '||nlchr||
                           '              sum(sr)    SR  , sum(st)    ST   , count(*)   KOL  ,'||nlchr||
                           '              sum (VX1)  VX1 , sum(dos1 ) DOS1 , sum(kos1)  KOS1 , sum(ix1)  IX1,'||nlchr||
                           '              sum (VX1q) VX1q, sum(dos1q) DOS1q, sum(kos1q) KOS1q, sum(ix1q) IX1q  ,'||nlchr||
                           '              sum (VKOL) VKOL, sum(dKOL)  DKOL , sum(kKOL)  KKOL , sum(iKOL) IKOL                 '||nlchr||
                           '       from ( select d.branch, a.kv, a.nbs, d.vidd, '||nlchr||
                           '                     fost (d.acc, to_date(:sFdat1,''dd.mm.yyyy'') -1 ) VX,  '||nlchr||
                           '                     fostq(d.acc, to_date(:sFdat1,''dd.mm.yyyy'') -1 ) VXq,  '||nlchr||
                           '                     fdos (d.acc, to_date(:sFdat1,''dd.mm.yyyy''), to_date(:sFdat2,''dd.mm.yyyy'')) dos,'||nlchr||
                           '                     fdosq(d.acc, to_date(:sFdat1,''dd.mm.yyyy''), to_date(:sFdat2,''dd.mm.yyyy'')) dosq,'||nlchr||
                           '                     fkos (d.acc, to_date(:sFdat1,''dd.mm.yyyy''), to_date(:sFdat2,''dd.mm.yyyy'')) kos,'||nlchr||
                           '                     fkosq(d.acc, to_date(:sFdat1,''dd.mm.yyyy''), to_date(:sFdat2,''dd.mm.yyyy'')) kosq,       '||nlchr||
                           '                     fost (d.acc, to_date(:sFdat2,''dd.mm.yyyy'')) iX,'||nlchr||
                           '                     fostq(d.acc, to_date(:sFdat2,''dd.mm.yyyy'')) iXq,  '||nlchr||
                           '                     acrn.fprocn(d.acc,1, to_date(:sFdat2,''dd.mm.yyyy'') )* '||nlchr||
                           '                        fostq(d.acc, to_date(:sFdat2,''dd.mm.yyyy'') ) sr, '||nlchr||
                           '                     (d.dat_end-d.dat_begin) * fostq(d.acc, to_date(:sFdat2,''dd.mm.yyyy'') ) st,'||nlchr||
                           '                     fost (i.acra, to_date(:sFdat1,''dd.mm.yyyy'') -1 ) VX1,  '||nlchr||
                           '                     fostq(i.acra, to_date(:sFdat1,''dd.mm.yyyy'') -1 ) VX1q,  '||nlchr||
                           '                     fdos (i.acra, to_date(:sFdat1,''dd.mm.yyyy''), to_date(:sFdat2,''dd.mm.yyyy'')) dos1,'||nlchr||
                           '                     fdosq(i.acra, to_date(:sFdat1,''dd.mm.yyyy''), to_date(:sFdat2,''dd.mm.yyyy'')) dos1q,'||nlchr||
                           '                     fkos (i.acra, to_date(:sFdat1,''dd.mm.yyyy''), to_date(:sFdat2,''dd.mm.yyyy'')) kos1,'||nlchr||
                           '                     fkosq(i.acra, to_date(:sFdat1,''dd.mm.yyyy''), to_date(:sFdat2,''dd.mm.yyyy'')) kos1q,       '||nlchr||
                           '                     fost (i.acra, to_date(:sFdat2,''dd.mm.yyyy'')) iX1,'||nlchr||
                           '                     fostq(i.acra, to_date(:sFdat2,''dd.mm.yyyy'')) iX1q  ,'||nlchr||
                           '                     CASE WHEN A.DAOS <  to_date(:sFdat1,''dd.mm.yyyy'') THEN 1 ELSE 0  END  vkOL,'||nlchr||
                           '                     CASE WHEN A.DAOS >= to_date(:sFdat1,''dd.mm.yyyy'') THEN 1 ELSE 0  END  KkOL,'||nlchr||
                           '                     CASE WHEN A.DAzs <= to_date(:sFdat2,''dd.mm.yyyy'') THEN 1 ELSE 0  END  DkOL,'||nlchr||
                           '                     CASE WHEN A.DAzS >= to_date(:sFdat2,''dd.mm.yyyy'') OR A.DAZS IS NULL THEN 1 ELSE 0  END  IkOL '||nlchr||
                           '             from DPU_DEAL d, v_gl a, (select acc, acra from int_accn where id=1) i'||nlchr||
                           '             where a.acc=d.acc and d.acc=i.acc(+) '||nlchr||
                           '             ) '||nlchr||
                           '       where (vx<>0 or dos<>0 or kos<>0 or ix<>0)'||nlchr||
                           '       group by branch, kv, nbs, vidd        '||nlchr||
                           '       ) k ,'||nlchr||
                           '       BRANCH b, DPU_vidd t'||nlchr||
                           'where b.branch = k.branch and t.vidd=k.vidd   '||nlchr||
                           'order by k.branch, k.vidd ';
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
    l_rep.description :='Аналiз депозитного портфелю ЮО (Бранч+Вид)';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",FALSE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 115; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 405;


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

begin
 Insert into APP_REP  (CODEAPP, CODEREP, APPROVE) Values ('WOPR', 405, 1);
exception when dup_val_on_index then null;
end;

begin
 Insert into APP_REP  (CODEAPP, CODEREP, APPROVE) Values ('ANI1', 405, 1);
exception when dup_val_on_index then null;
end;

end;                                        
/                                           
                                            
commit;                                     
