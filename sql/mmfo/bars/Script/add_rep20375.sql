begin
delete from CBIREP_QUERIES t where t.rep_id = 20375;
exception
  when others then
    null;
end;
/
commit;
/
begin
delete from APP_REP t where t.coderep =20375;
exception
  when others then
    null;
end;
/
commit;
/
begin
delete from zapros z where z.kodz = 5502520;
exception
  when others then
    null;
end;
/
commit;
/
begin
delete from reports r where r.id = 20375; 
exception
  when others then
    null;
end;
/
commit;
/
begin
insert into REPORTS (ID, NAME, DESCRIPTION, FORM, PARAM, NDAT, WT, MASK, NAMEW, PATH, WT2, IDF, NODEL, DBTYPE, BRANCH, USEARC, EMPTYFILES)
values (20375, 'Empty', 'Виписки в розрізі дат ВАЛ.(Звіт 20375) ', 'frm_FastReport', '5502520,3,sFdat,sFdat2,"",TRUE,TRUE', 2, null,
 'VPVAL*.*', null, null, null, 30, null, null, '/300465/', 0, null);
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
begin
insert into ZAPROS (KODZ, ID, NAME, NAMEF, BINDVARS, CREATE_STMT, RPT_TEMPLATE, KODR, FORM_PROC, DEFAULT_VARS, CREATOR, BIND_SQL, XSL_DATA, TXT, XSD_DATA, XML_ENCODING, PKEY, BRANCH, LAST_UPDATED)
values (5502520, 1, 'Виписки в розрізі дат ВАЛ.(Звіт 20375)', '= ''VPVAL''||substr(:sFdat1,1,2)||substr(:sFdat1,4,2)||''.''||user_id', ':sFdat1='''',:sFdat2='''',:Param0=''Маска рахунку (%-всi)'',:KV=''Валюта (0-всi)'',:BRANCH=''Вiддiлення'',:DEP=''Вкл. пiдлеглих (1-вкл.)'',:INFORM=''Вкл. iнф.повiдомл.(1-вкл.)'',:NODOCS=''Вкл. без оборотiв (1-вкл.)''', null, 'rep20375.frx', null, 'bars_rptlic.lic_valb(to_date(:sFdat1), to_date(:sFdat2) , :Param0,  :KV, 0,  bars_report.get_branch(:BRANCH,:DEP) , :INFORM)', ':Param0=''%'',:KV=''0'',:BRANCH=''Поточне'',:DEP=''1'',:INFORM=''0'',:NODOCS=''0''', null, ':BRANCH=''V_BRANCH_OWN|BRANCH|NAME''', null,
 'select   '''' fio, 
       srt,  
       dksrt,
       vobsrt,
       nmk ,
       okpo,    
       acc,            
       nls,            
       v.kv,           
       lcv,            
       v.fdat,           
       dapp,           
       ostf,           
       ostfq,           
       nms,            
       s,      
       sq,     
       doss,   
       koss,   
       dossq,  
       kossq,  
       nd,     
       mfo2,    
       nb2  ,     
       nls2   ,   
       nmk2 ,  
       okpo2,   
       nazn,   
       bis,
       dosr,       
       kosr,       
       ostfr,          
       v.fdat,
       curs,
       bsum,
       paydate
from  v_rptlic2 v, 
          tabval t, 
         ( select  t.kv, t.fdat,  c1.bsum,    c1.rate_o curs
              from (select unique kv, fdat from tmp_licm)  t,    cur_rates c1
           where  c1.kv = t.kv  and c1.vdate  = t.fdat
      ) k          
where v.kv = t.kv and k.kv = v.kv
  and k.fdat = v.fdat 
  and nvl(v.ref, 0)  =  decode(:NODOCS, ''0'',  v.ref,   nvl(v.ref, 0) )
order by okpo, nls, v.kv, v.fdat,  srt desc, dksrt, sign(s),  vobsrt,  abs(s), ref, bis  ', null, 'CL8MSWIN1251', '\BRS\SBM\REP\20375', '/', to_date('19-11-2018 18:04:13', 'dd-mm-yyyy hh24:mi:ss'));
exception
  when dup_val_on_index then
    null;
end;
/
commit;
/
exec umu.add_report2arm(20375,'$RM_CRPC');
/
exec umu.add_report2arm(20375,'$RM_WSSR');
/
exec umu.add_report2arm(20375,'$RM_@UDT');
/
exec umu.add_report2arm(20375,'$RM_@ECH');
/
exec umu.add_report2arm(20375,'$RM_OPER');
/
exec umu.add_report2arm(20375,'$RM_UCCK');
/
exec umu.add_report2arm(20375,'$RM_VALB');
/
exec umu.add_report2arm(20375,'$RM_W_FM');
/
exec umu.add_report2arm(20375,'$RM_WDOC');
/
exec umu.add_report2arm(20375,'$RM_DRU1');
/
exec umu.add_report2arm(20375,'$RM_MAIN');
/
exec umu.add_report2arm(20375,'$RM_BVBB');
/
exec umu.add_report2arm(20375,'$RM_WCIM');
/
commit;