prompt ===================================== 
prompt ==REP: Інф. про рахунки корпоративних клієнтів
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
   l_message   varchar2(8000);    

begin     
   l_zpr.name := 'REP: Інф. про рахунки корпоративних клієнтів';
   l_zpr.pkey := '\BRS\SBER\***\208';

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
    l_zpr.name         := 'REP: Інф. про рахунки корпоративних клієнтів';
    l_zpr.namef        := '=case when nvl(:sFdat1,gl.bd) =nvl(:sFdat1,Dat_last(gl.bd)) then (select ''ZvitAccounts2''||substr(ncks,2,3)||substr(bars_report.frmt_date(nvl(:sFdat1,gl.bd),''DMY''),1,3)||''.DBF'' from rcukru where mfo=gl.kf) else ''null'' end';
    l_zpr.bindvars     := ':sFdat1=''Початкова дата (dd/mm/yyyy)'',:sFdat2=''Остання дата (dd/mm/yyyy)''';
    l_zpr.create_stmt  := 'DG  CHAR(10),
DAT_START  CHAR(10),
DAT_END  CHAR(10),
VAL  CHAR(6),
BRANCH  CHAR(30),
NMKK  CHAR(38),
RNK  NUMBER(14),
OKPO  CHAR(14),
PAP  NUMBER(1),
NBS  CHAR(4),
OB22  CHAR(2),
ACC  NUMBER(14),
NLS  CHAR(15),
NMS  CHAR(70),
KV  NUMBER(3),
ISHQ  CHAR(40),
AVGQ  CHAR(40),
IR  CHAR(40),
DAPP  CHAR(10),
DOSQ  CHAR(40),
DOSQ_PP  CHAR(40),
DOSQ_CORP2  CHAR(40),
DOSQ_POL  CHAR(40),
SUM_NACASH  CHAR(40),
KOSQ  CHAR(40),
KOSQ_PP  CHAR(40),
KOSQ_CORP2  CHAR(40),
KOSQ_POL  CHAR(40),
SUM_ACC  CHAR(40),
COUNT_T  CHAR(40),
COUNT_PP  CHAR(40),
COUNT_M  CHAR(40),
COUNT1  CHAR(15),
COUNT2  CHAR(15),
COUNT3  CHAR(15),
COUNT4  CHAR(15),
COUNT5  CHAR(15),
COUNT6  CHAR(15),
COUNT7  CHAR(15),
COUNT8  CHAR(15),
COUNT9  CHAR(15),
COUNT10  CHAR(15),
COUNT11  CHAR(15),
NKD  CHAR(30),
ND  NUMBER(14) ,
DAOS  CHAR(10),
DAZS  CHAR(10),
TRNK  NUMBER(14),
T2RNK  NUMBER(14),
T1  CHAR(15),
T2  CHAR(15),
T3  CHAR(10),
T4  CHAR(15),
T5  CHAR(140)';
    l_zpr.rpt_template := '';
    l_zpr.form_proc    := 'PUL_DAT (nvl(:sFdat1,to_char(trunc(to_date(:sFdat1,''dd.mm.yyyy''),''mm''),''dd.mm.yyyy'')), nvl(:sFdat2,to_char(last_day(to_date(:sFdat2,''dd.mm.yyyy'')),''dd.mm.yyyy'')) )';
    l_zpr.default_vars := '';
    l_zpr.bind_sql     := '';
    l_zpr.xml_encoding := 'CL8MSWIN1251';
    l_zpr.txt          := 'select
DG  ,
DAT_START  ,
DAT_END ,
VAL ,
BRANCH ,
NMKK  ,
RNK ,
OKPO  ,
PAP ,
NBS  ,
OB22 ,
ACC ,
NLS  ,
NMS  ,
KV  ,
ISHQ  ,
AVGQ  ,
IR  ,
DAPP  ,
DOSQ ,
DOSQ_PP,
DOSQ_CORP2,
DOSQ_POL,
SUM_NACASH,
KOSQ,
KOSQ_PP,
KOSQ_CORP2 ,
KOSQ_POL,
SUM_ACC,
COUNT_T,
COUNT_PP ,
COUNT_M ,
COUNT1,
COUNT2,
COUNT3 ,
COUNT4,
COUNT5,
COUNT6,
COUNT7,
COUNT8,
COUNT9,
COUNT10,
COUNT11,
NKD,
ND,
DAOS,
DAZS,
TRNK ,
T2RNK ,
T1,
T2 ,
T3,
T4,
T5
from V_CCK_ACCOUNTS_DKB where  (:sFdat1 is not null or gl.bd=dat_last(gl.bd))';
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
    l_rep.description :='REP: Інф. про рахунки корпоративних клієнтів';
    l_rep.form        :='frm_FastReport';
    l_rep.param       :=l_zpr.kodz||',3,sFdat,sFdat2,"",FALSE,FALSE';
    l_rep.ndat        :=2;
    l_rep.mask        :='';
    l_rep.usearc      :=0;
    l_rep.idf         :=null;    


    if l_isnew = 1 then                        
       l_isnewr:=1;                            
    else                                        
       begin                                    
          select id into l_rep.id               
          from reports                          
          where substr(param, 1,instr(param,',')-1)=to_char(l_zpr.kodz) 
                and form='frm_FastReport'      
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
           and form='frm_FastReport');                             
                                                 
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
  