

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/_OLD_***_***_259.sql =========*** Run *
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Звіт по зводу документів дня по операціоністу
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
   l_zpr.name := 'Звіт по зводу документів дня по операціоністу';
   l_zpr.pkey := '\OLD\***\***\259';

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
    l_zpr.name         := 'Звіт по зводу документів дня по операціоністу';
    l_zpr.namef        := 'zvit40_i';
    l_zpr.bindvars     := ':sFdat1=''Дата'',:Param1=''Користувач'',:Param2=''Відділ''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := 'zvit40i.qrp';
    l_zpr.form_proc    := '';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select fdat, id, namo, userid, fio, kv, name, tt, nt,'||nlchr||
                           '       sum(KOLPROV) KOL,'||nlchr||
                           '       sum(S_NOM) s,'||nlchr||
                           '       sum(S_EQV) sq,'||nlchr||
                           '      sum(KOLDOC) KOLD'||nlchr||
                           '-- +===============================================================+'||nlchr||
                           '-- | *** 495 - Zvit po zvodu dokumntiv dnya (po operacionistu) *** |'||nlchr||
                           '-- | 06/10/2010 12:30                                              |'||nlchr||
                           '-- +===============================================================+'||nlchr||
                           'from'||nlchr||
                           ' ('||nlchr||
                           '  select K.FDAT, O.ID, O.NAME NAMO, K.USERID, F.FIO,'||nlchr||
                           '         K.KV, T.NAME NAME, K.TT, S.NAME NT, K.KOLPROV, K.S_NOM, K.S_EQV,  koldok  KOLDOC'||nlchr||
                           '  from staff$base f,'||nlchr||
                           '       tabval   t,'||nlchr||
                           '       tts      s,'||nlchr||
                           '       OTDEL    o,'||nlchr||
                           '       OTD_USER u,'||nlchr||
                           '       ( ---------------------------------------------------------------------------'||nlchr||
                           '         --------                  selecting PROVODKI                 --------------'||nlchr||
                           '         ---------------------------------------------------------------------------'||nlchr||
                           '         select to_date(:sFdat1, ''DD/MM/YYYY'') as "FDAT", o1.userid, a.kv, o2.tt, count(*) kolprov, sum(o2.s) s_nom, sum(gl.p_icurval(a.kv,o2.s,o2.fdat)) s_eqv, count(distinct o1.ref) koldok'||nlchr||
                           '           from oper o1, opl o2, accounts a'||nlchr||
                           '          where o2.fdat = to_date(:sFdat1, ''DD/MM/YYYY'')'||nlchr||
                           '            and decode(o1.tt,        ''PKD'', o2.fdat, --o1.vdat,'||nlchr||
                           '                       decode(o1.tt, ''PKF'', o2.fdat, --o1.vdat,'||nlchr||
                           '                       decode(o1.tt, ''PKK'', o2.fdat, --o1.vdat,'||nlchr||
                           '                       decode(o1.tt, ''PKR'', o2.fdat, --o1.vdat,'||nlchr||
                           '                       decode(o1.tt, ''PKQ'', o2.fdat, --o1.vdat,'||nlchr||
                           '                       decode(o1.tt, ''PKY'', o2.fdat, --o1.vdat,'||nlchr||
                           '                       decode(o1.tt, ''IB1'', decode(substr(o1.nlsb,1,4),''2625'',o1.vdat,o2.fdat),'||nlchr||
                           '                       decode(o1.tt, ''KL1'', o1.vdat, o2.fdat)))))))) = decode( o1.nlsa,''29242000'',o1.vdat,'||nlchr||
                           '                                                                                                  o2.fdat)'||nlchr||
                           '            and o1.sos >= 4'||nlchr||
                           '            and o1.ref = o2.ref'||nlchr||
                           '            and o1.tt  = o2.tt'||nlchr||
                           '            and o1.tt not in (''PVP'',''PO1'',''PO3'')'||nlchr||
                           '            and o1.kv  = o2.kv'||nlchr||
                           '            and o1.dk  = o2.dk'||nlchr||
                           '            and o2.acc = a.acc '||nlchr||
                           '            and o2.acc not in (select acc from accounts where nls like ''8%'')'||nlchr||
                           '            and o1.userid = :Param1'||nlchr||
                           '          group by o2.fdat, o1.userid, a.kv, o2.tt'||nlchr||
                           '       union all -------------------------------------------'||nlchr||
                           '       select to_date(:sFdat1, ''DD/MM/YYYY''), o1.userid, a.kv, o2.tt, count(*) kolprov, sum(o2.s) s_nom, sum(gl.p_icurval(a.kv,o2.s,o2.fdat)) s_eqv, count(distinct o1.ref) koldok'||nlchr||
                           '          from oper o1, opl o2, accounts a'||nlchr||
                           '          where o2.fdat = to_date(:sFdat1,''DD/MM/YYYY'')'||nlchr||
                           '            and o1.sos >= 4'||nlchr||
                           '            and o1.ref = o2.ref'||nlchr||
                           '            and o1.tt  = o2.tt'||nlchr||
                           '            and o1.kv  <> o2.kv'||nlchr||
                           '            and o1.dk  = o2.dk'||nlchr||
                           '            and o2.acc = a.acc'||nlchr||
                           '            and o1.userid = :Param1'||nlchr||
                           '          group by o2.fdat, o1.userid, a.kv, o2.tt'||nlchr||
                           '       union all -------------------------------------------CLD,CLO'||nlchr||
                           '       select to_date(:sFdat1, ''DD/MM/YYYY''), o1.userid, a.kv, o2.tt, count(*) kolprov, sum(o2.s) s_nom, sum(gl.p_icurval(a.kv,o2.s,o2.fdat)) s_eqv, 0 koldok'||nlchr||
                           '          from oper o1, opl o2, accounts a'||nlchr||
                           '          where o2.fdat = to_date(:sFdat1,''DD/MM/YYYY'')'||nlchr||
                           '            and o1.sos >= 4'||nlchr||
                           '            and o1.ref = o2.ref'||nlchr||
                           '            and o1.tt  <> o2.tt'||nlchr||
                           '            and o2.tt not in (''PO3'')'||nlchr||
                           '            and o1.kv  = o2.kv'||nlchr||
                           '            and o1.dk  = o2.dk'||nlchr||
                           '            and o2.acc = a.acc'||nlchr||
                           '            and o1.userid = :Param1'||nlchr||
                           '          group by o2.fdat, o1.userid, a.kv, o2.tt'||nlchr||
                           '       union all ------------------------------------------- specific operation ("CLI")'||nlchr||
                           '             select o2.fdat, o1.userid, o1.kv, o1.tt, 0 kolprov,'||nlchr||
                           '                                                      sum(o1.s) s_nom,'||nlchr||
                           '                                                      0 s_eqv, count(*) KOLDOC'||nlchr||
                           '               from oper o1, opl o2'||nlchr||
                           '              where o2.fdat = to_date(:sFdat1,''DD/MM/YYYY'')'||nlchr||
                           '                and o1.sos = 5'||nlchr||
                           '                and o1.ref  = o2.ref'||nlchr||
                           '                and o1.tt   = ''CLI'''||nlchr||
                           '                and o1.dk   = o2.dk -- this condition is need for selecting unique ref from oper'||nlchr||
                           '                and o2.tt   = ''CLD'' -- while we counting specific operation CLI'||nlchr||
                           '                and o1.userid = :Param1'||nlchr||
                           '              group by o2.fdat, o1.userid, o1.tt, o1.kv          '||nlchr||
                           '       union all -------------------------------------------'||nlchr||
                           '       select to_date(:sFdat1, ''DD/MM/YYYY''), o1.userid, a.kv, o2.tt, count(*) kolprov, sum(o2.s) s_nom, sum(gl.p_icurval(a.kv,o2.s,o2.fdat)) s_eqv, 0 koldok'||nlchr||
                           '          from oper o1, opl o2, accounts a'||nlchr||
                           '          where o2.fdat = to_date(:sFdat1,''DD/MM/YYYY'')'||nlchr||
                           '            and o1.sos >= 4'||nlchr||
                           '            and o1.ref = o2.ref'||nlchr||
                           '            and o1.tt  <> o2.tt'||nlchr||
                           '            and o1.kv  <> o2.kv'||nlchr||
                           '            and o2.tt not in (''PO3'')'||nlchr||
                           '            and substr(o2.nls,1,1) <> ''8'''||nlchr||
                           '            and o1.dk  = o2.dk'||nlchr||
                           '            and o2.acc = a.acc'||nlchr||
                           '            and o1.userid = :Param1'||nlchr||
                           '          group by o2.fdat, o1.userid, a.kv, o2.tt'||nlchr||
                           '       union all -------------------------------------------'||nlchr||
                           '       select to_date(:sFdat1, ''DD/MM/YYYY''),'||nlchr||
                           '                       decode(o1.tt, ''PRI'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                     ''ISG'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                     ''ZAL'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                     ''CR9'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                     ''CI1'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                     ''CI2'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                     ''OVR'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                     ''IME'', hex_to_num(substr(o1.chk,21,4)),'||nlchr||
                           '                                     ''IMI'', hex_to_num(substr(o1.chk,21,4)),'||nlchr||
                           '                                     ''KLO'', hex_to_num(substr(o1.chk,21,4)),'||nlchr||
                           '                                     ''KL7'', hex_to_num(substr(o1.chk,21,4)),'||nlchr||
                           '                                     ''KL8'', hex_to_num(substr(o1.chk,21,4)) ) userid,'||nlchr||
                           '              a.kv, o2.tt, count(*) kolprov,'||nlchr||
                           '              sum(o2.s) s_nom, sum(gl.p_icurval(a.kv,o2.s,o2.fdat)) s_eqv, count(distinct o1.ref) koldok'||nlchr||
                           '          from oper o1, opl o2, accounts a'||nlchr||
                           '          where o1.ref = o2.ref'||nlchr||
                           '            and o2.sos >= 4'||nlchr||
                           '            and o2.fdat = to_date(:sFdat1,''DD/MM/YYYY'')'||nlchr||
                           '            and o1.dk   = o2.dk'||nlchr||
                           '            and :Param2 = 5'||nlchr||
                           '            and decode(o1.tt, ''PRI'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                              ''ISG'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                              ''ZAL'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                              ''CR9'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                              ''CI1'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                              ''CI2'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                              ''OVR'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                              ''IME'', hex_to_num(substr(o1.chk,21,4)),'||nlchr||
                           '                              ''IMI'', hex_to_num(substr(o1.chk,21,4)),'||nlchr||
                           '                              ''KLO'', hex_to_num(substr(o1.chk,21,4)),'||nlchr||
                           '                              ''KL7'', hex_to_num(substr(o1.chk,21,4)),'||nlchr||
                           '                              ''KL8'', hex_to_num(substr(o1.chk,21,4)) ) = :Param1'||nlchr||
                           '            and o2.acc = a.acc'||nlchr||
                           '          group by to_date(:sFdat1, ''DD/MM/YYYY''),'||nlchr||
                           '                            decode(o1.tt, ''PRI'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                          ''ISG'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                          ''ZAL'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                          ''CR9'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                          ''CI1'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                          ''CI2'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                          ''OVR'', hex_to_num(substr(o1.chk,3,4)),'||nlchr||
                           '                                          ''IME'', hex_to_num(substr(o1.chk,21,4)),'||nlchr||
                           '                                          ''IMI'', hex_to_num(substr(o1.chk,21,4)),'||nlchr||
                           '                                          ''KLO'', hex_to_num(substr(o1.chk,21,4)),'||nlchr||
                           '                                          ''KL7'', hex_to_num(substr(o1.chk,21,4)),'||nlchr||
                           '                                          ''KL8'', hex_to_num(substr(o1.chk,21,4)) ), a.kv, o2.tt'||nlchr||
                           '       ) k'||nlchr||
                           '  where k.userid = f.id and k.kv = t.kv and s.tt = k.tt and        --COBUMMFO-3643'||nlchr||
                           '        k.userid = u.userid (+) and o.ID = u.otd and f.id = :Param1 and u.otd = :Param2'||nlchr||
                           '   '||nlchr||
                           ' ) tabl1'||nlchr||
                           'group by fdat, id, namo, userid, fio, kv, name, tt, nt'||nlchr||
                           'order by kv, s';
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
    l_rep.description :='Звіт по зводу документів дня по операціоністу';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat,"",TRUE,TRUE';
    l_rep.ndat        :=1;
    l_rep.mask        :='zvit40_i';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    

    -- Фиксированный № печатного отчета   
    l_rep.id          := 100953;


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
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/_OLD_***_***_259.sql =========*** End *
PROMPT ===================================================================================== 
