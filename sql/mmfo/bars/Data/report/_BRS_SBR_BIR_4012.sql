
prompt ===================================== 
prompt == Друк заяв з купівлі ІВ, що надійшли через СДО
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
   l_zpr.name := 'Друк заяв з купівлі ІВ, що надійшли через СДО';
   l_zpr.pkey := '\BRS\SBR\BIR\4012';

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
    l_zpr.name         := 'Друк заяв з купівлі ІВ, що надійшли через СДО';
    l_zpr.namef        := '';
    l_zpr.bindvars     := ':sFdat1='''',:sFdat2='''',:sparam=''0-Чекає на візу, 1-Всі''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'zay_4012.frx';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := ':sparam=1';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'SELECT z.nd num_doc,'||nlchr||
                           '         z.id,'||nlchr||
                           '         z.dk,'||nlchr||
                           '         case when z.fnamekb = ''CL'' then 1 else 0 end kb,'||nlchr||
                           '         f_dat_lit (z.fdat) begin_date,'||nlchr||
                           '         z.s2 / 100 amount_in,'||nlchr||
                           '         ROUND (z.s2 / 100 * z.KURS_F, 2) base_amount_in,'||nlchr||
                           '         z.kv2 currency,'||nlchr||
                           '         z.kv_conv currency_conv,'||nlchr||
                           '         tg.name currency_name,'||nlchr||
                           '         (select tv.name from tabval$global tv where tv.kv = z.kv_conv) currency_conv_name,'||nlchr||
                           '         z.KURS_F kurs_diler,'||nlchr||
                           '         z.comm AS details,'||nlchr||
                           '         z.kom commiss,'||nlchr||
                           '         nvl(z.contact_fio,cz.fio) FIO,'||nlchr||
                           '         nvl(z.contact_tel,cz.tel) TEL,'||nlchr||
                           '         c.nmk name_customer,'||nlchr||
                           '         c.okpo,'||nlchr||
                           '         (SELECT    ca.ZIP'||nlchr||
                           '          || '' '''||nlchr||
                           '          || (SELECT name'||nlchr||
                           '              FROM country'||nlchr||
                           '             WHERE country = CA.COUNTRY)'||nlchr||
                           '          FROM customer_address ca'||nlchr||
                           '          WHERE ca.rnk = c.rnk AND type_id = 1)||'', ''||c.adr as adr,'||nlchr||
                           '         cz.nls29,'||nlchr||
                           '         (SELECT p.telw'||nlchr||
                           '            FROM person p'||nlchr||
                           '           WHERE p.rnk = c.rnk)'||nlchr||
                           '            phone,'||nlchr||
                           '         (SELECT t.val'||nlchr||
                           '            FROM params /*params$base*/ t'||nlchr||
                           '           WHERE t.par = ''NAME'')'||nlchr||
                           '            bank_name,'||nlchr||
                           '         z.kf bank_mfo,'||nlchr||
                           '         (SELECT t.val'||nlchr||
                           '            FROM branch_parameters t'||nlchr||
                           '           WHERE t.tag = ''ADR_BRANCH'' AND t.branch = ''/'' || z.kf || ''/'')'||nlchr||
                           '            adr_branch,'||nlchr||
                           '         ac_$.account_customer,'||nlchr||
                           '         ac_$.bank_mfo_customer,'||nlchr||
                           '         ac_$.bank_name_customer,'||nlchr||
                           '         ac_UAH.account_customer_UAH,'||nlchr||
                           '         ac_UAH.bank_mfo_customer_UAH,'||nlchr||
                           '         ac_UAH.bank_name_customer_UAH,'||nlchr||
                           '         vk.vk_fio,'||nlchr||
                           '         vk.VK_date,'||nlchr||
                           '         vk.VK_time,'||nlchr||
                           '         vv.VV_fio,'||nlchr||
                           '         vv.VV_date,'||nlchr||
                           '         vv.VV_time,'||nlchr||
                           '         TO_CHAR (z.datedokkb, ''dd.mm.yyyy'') POST_KB_date,'||nlchr||
                           '         TO_CHAR (z.datedokkb, ''HH24:MI'') POST_KB_time,'||nlchr||
                           '         (SELECT sb.fio'||nlchr||
                           '            FROM zay_track zt, staff$base sb'||nlchr||
                           '           WHERE     zt.userid = sb.id'||nlchr||
                           '                 AND zt.old_viza is null'||nlchr||
                           '                 AND zt.new_viza = 0'||nlchr||
                           '                 AND zt.id = z.id)'||nlchr||
                           '            POST_KB_fio,'||nlchr||
                           '         nvl(zm.sign01,(substr(z.CL_PERSON1, 0, instr(z.CL_PERSON1,'','')-1))) sign01,'||nlchr||
                           '         nvl(zm.sign02,(substr(Z.cl_person2, 0, instr(Z.cl_person2,'','')-1))) sign02'||nlchr||
                           '    FROM zayavka z,'||nlchr||
                           '         customer c,'||nlchr||
                           '         cust_zay cz,'||nlchr||
                           '         tabval$global tg,'||nlchr||
                           '         (SELECT acc.acc, acc.nls account_customer, acc.kf bank_mfo_customer, b.val bank_name_customer'||nlchr||
                           '            FROM accounts acc, branch_parameters b'||nlchr||
                           '           WHERE b.branch = ''/'' || acc.kf || ''/'' AND b.tag = ''NAME_BRANCH'') ac_$,'||nlchr||
                           '         (SELECT acc.acc, acc.nls account_customer_UAH, acc.kf bank_mfo_customer_UAH, b.val bank_name_customer_UAH'||nlchr||
                           '            FROM accounts acc, branch_parameters b'||nlchr||
                           '           WHERE b.branch = ''/'' || acc.kf || ''/'' AND b.tag = ''NAME_BRANCH'') ac_UAH,'||nlchr||
                           '         (SELECT sb.fio vk_fio, zt.id, TO_CHAR (zt.change_time, ''dd.mm.yyyy'') VK_date, TO_CHAR (zt.change_time, ''HH24:MI'') VK_time'||nlchr||
                           '            FROM zay_track zt, staff$base sb'||nlchr||
                           '           WHERE zt.userid = sb.id AND zt.track_id = (select max(zt1.track_id) from zay_track zt1 where zt1.old_viza in (0, -1) and zt1.new_viza = 1 and zt1.id = zt.id)) vk,'||nlchr||
                           '         (SELECT sb.fio vv_fio, zt.id, TO_CHAR (zt.change_time, ''dd.mm.yyyy'') VV_date, TO_CHAR (zt.change_time, ''HH24:MI'') VV_time'||nlchr||
                           '            FROM zay_track zt, staff$base sb'||nlchr||
                           '           WHERE zt.userid = sb.id AND zt.old_sos = 1 AND zt.new_sos = 2) vv,'||nlchr||
                           '           barsaq.zayavka_id_map zm'||nlchr||
                           '   WHERE     z.rnk = c.rnk'||nlchr||
                           '         AND cz.rnk = c.rnk'||nlchr||
                           '         AND z.kv2 = tg.kv'||nlchr||
                           '         AND z.dk = 1'||nlchr||
                           '         AND z.acc0 = ac_UAH.acc'||nlchr||
                           '         AND z.acc1 = ac_$.acc'||nlchr||
                           '         AND vk.id(+) = z.id'||nlchr||
                           '         AND vv.id(+) = z.id'||nlchr||
                           '         AND z.identkb IS NOT NULL'||nlchr||
                           '         AND z.fdat BETWEEN :sFdat1 AND :sFdat2'||nlchr||
                           '         and z.id = zm.idz(+)'||nlchr||
                           '         and ((z.sos >= 0 and :sparam = 1)'||nlchr||
                           '         or (z.sos = 0 and :sparam = 0))'||nlchr||
                           'ORDER BY z.dk, z.fdat';
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
    l_rep.description :='Друк заяв з купівлі ІВ, що надійшли через СДО';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",TRUE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    begin                                                                        
        select idf into l_repfolder from reportsf where idf = 70; 
    exception when no_data_found then                                            
        l_repfolder := null;                                                     
    end;                         
    l_rep.idf := l_repfolder;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 4012;


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
