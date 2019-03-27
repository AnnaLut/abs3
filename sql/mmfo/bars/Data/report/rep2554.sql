

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/rep2554.sql ==*** Run *** =============
PROMPT ===================================================================================== 
prompt ===================================== 
prompt == Звіт по символах касплану за період видатки (розгорнутий) 
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
   l_zpr.name := 'Звіт по символах касплану за період видатки (розгорнутий) ';
   l_zpr.pkey := '\BRS\SBM\OTC\71';

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
    l_zpr.name         := 'Звіт по символах касплану за період видатки (розгорнутий) ';
    l_zpr.namef        := 'rep#12v.txt';
    l_zpr.bindvars     := ':sFdat1=''З дати'',:sFdat2=''По дату'',:BRANCH=''Вiддiлення (%-всi)''';
    l_zpr.create_stmt  := '';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := 'bars.p_f12_rep(to_date(:sFdat1, ''dd/mm/yyyy''),to_date(:sFdat2, ''dd/mm/yyyy''))';
    l_zpr.default_vars := ':BRANCH=''Поточне''';
    l_zpr.bind_sql     := ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select branch "Код_відділення", name "Назва_відділення",
       sum(decode(kodp,40,znap, null)) "P40",
       sum(decode(kodp,41,znap, null)) "P41",
       sum(decode(kodp,42,znap, null)) "P42",
       sum(decode(kodp,43,znap, null)) "P43",
       sum(decode(kodp,44,znap, null)) "P44",
       sum(decode(kodp,45,znap, null)) "P45",
       sum(decode(kodp,46,znap, null)) "P46",
       sum(decode(kodp,47,znap, null)) "P47",
       sum(decode(kodp,48,znap, null)) "P48",
       sum(decode(kodp,49,znap, null)) "P49",
       sum(decode(kodp,50,znap, null)) "P50",
       sum(decode(kodp,51,znap, null)) "P51",
       sum(decode(kodp,52,znap, null)) "P52",
       sum(decode(kodp,53,znap, null)) "P53",
       sum(decode(kodp,54,znap, null)) "P54",
       sum(decode(kodp,55,znap, null)) "P55",
       sum(decode(kodp,56,znap, null)) "P56",
       sum(decode(kodp,57,znap, null)) "P57",
       sum(decode(kodp,58,znap, null)) "P58",
       sum(decode(kodp,59,znap, null)) "P59",
       sum(decode(kodp,60,znap, null)) "P60",
       sum(decode(kodp,61,znap, null)) "P61",
       sum(decode(kodp,62,znap, null)) "P62",
       sum(decode(kodp,63,znap, null)) "P63",
       sum(decode(kodp,64,znap, null)) "P64",
       sum(decode(kodp,65,znap, null)) "P65",
       sum(decode(kodp,66,znap, null)) "P66",
       sum(decode(kodp,67,znap, null)) "P67",
       sum(decode(kodp,68,znap, null)) "P68",
       sum(decode(kodp,69,znap, null)) "P69",
       sum(decode(kodp,70,znap, null)) "P70",
       sum(decode(kodp,71,znap, null)) "P71",
       sum(decode(kodp,72,znap, null)) "P72",
       sum(decode(kodp,73,znap, null)) "P73",
       sum(decode(kodp,74,znap, null)) "P74"
from                                                           
( 
select a.branch branch, 
       b.name, t.kv, sum(t.znap)/100 znap, t.kodp    
from  rnbu_trace1 t,
      accounts a,
      branch b
where t.userid = user_id and
      t.acc = a.acc and 
      a.branch = b.branch
                    and a.branch like 
                    decode(:BRANCH,''Поточне'', sys_context(''bars_context'',''user_branch''), :BRANCH)||''%''          
      and  to_number(t.kodp) between 40 and 74
group by a.branch, 
         b.name, t.kv, t.kodp
order by a.branch,b.name
)  
group by branch,name
order by branch,name';
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
    l_rep.description :='Звіт по символах касплану за період видатки (розгорнутий) ';
    l_rep.form        :='frm_UniReport';
    l_rep.param       :=l_zpr.kodz||',,sFdat,sFdat2,"",TRUE,TRUE';
    l_rep.ndat        :=2;
    l_rep.mask        :='rep#12v.txt';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    


    if l_isnew = 1 then                        
       l_isnewr:=1;                            
    else                                        
       begin                                    
          select id into l_rep.id               
          from reports                          
          where substr(param, 1,instr(param,',')-1)=to_char(l_zpr.kodz) 
                and form='frm_UniReport'      
                and rownum=1;                   
                                                
          l_message:=l_message||nlchr||'Существуют печатные отчеты, которые ссылаются на данный кат.запрос.';
                                                
          update reports set                    
            name        = l_rep.name,           
            description = l_rep.description,    
            form        = l_rep.form,           
            param       = l_rep.param,          
            ndat        = l_rep.ndat,           
            mask        = l_rep.mask,           
            usearc      = l_rep.usearc,         
            idf         = l_rep.idf             
          where id in (                         
           select id from reports               
           where substr(param, 1,instr(param,',')-1)=to_char(l_zpr.kodz) 
           and form='frm_UniReport');                             
                                                 
          l_message:=l_message||nlchr||'Печатные отчеты - изменены.';
                                                 
       exception when no_data_found then         
          l_isnewr:=1;                           
       end;                                      
                                                 
     end if;                                     
                                                 
                                                 
     if l_isnewr = 1 then                        
        l_rep.id := bars_report.next_reportid;   
        begin                                    
           insert into reports values l_rep;     
           l_message:=l_message||nlchr||'Добавлен новый печ. отчет под №'||l_rep.id;
        exception when dup_val_on_index then     
           bars_error.raise_error('REP',13,to_char(l_rep.id));
        end;                                     
     end if;                                     
                                           
                                           
    bars_report.print_message(l_message);   
end;                                        
/                                           
                                            
commit;                                     

commit;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/rep2554.sql===*** End *** =============
PROMPT ===================================================================================== 
