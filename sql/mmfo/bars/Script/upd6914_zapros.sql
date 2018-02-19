
Prompt   update zapros for '�������� ��������� #A7'
BEGIN
    bc.home;

    update zapros
       set txt =
'select r.tobo  TOBO,  
       r.nls  NLS, 
       r.kv  KV,
       r.datf DATF,
       r.acc ACC, 
       substr(r.kodp,1,1) DK ,   
       substr(r.kodp,2,4) NBS ,
       substr(r.kodp,12,3) KV1 ,
       substr(r.kodp,6,1) R011 , 
       substr(r.kodp,8,1) S181,
       substr(r.kodp,7,1) R013 , 
       substr(r.kodp,9,1) S240, 
       substr(r.kodp,10,1) K030, 
       substr(r.kodp,11,1) S190, 
       r.znap ZNAP, 
       r.rnk rnk, 
       c.okpo okpo,
       replace(c.nmk, '';'', '' '') nmk ,
       r.mdate mdate, 
       r.isp isp, 
       trim(r.nd) nd,
       nvl(cc.cc_id,null) cc_id,
       nvl(cc.sdate,null) sdate, 
       nvl(cc.wdate,null) wdate,
       nvl(r.ref,null) ref,
       r.comm comm
from (select branch tobo, acc_num nls, kv, 
             report_date datf, acc_id acc, 
             field_code kodp, field_value znap, 
             cust_id rnk, maturity_date mdate, nd, 
             description comm, ref, null isp 
     from NBUR_DETAIL_PROTOCOLS_ARCH
     where REPORT_DATE = to_date(to_char(:sFdat1),''dd-mm-yyyy'') and
           report_code = ''#A7'' and
           version_id = (select version_id
                         from nbur_lst_files
                         where REPORT_DATE = to_date(to_char(:sFdat1),''dd-mm-yyyy'') and
                               FILE_ID = 16555 and
                               file_status in (''BLOCKED'', ''FINISHED''))) r,
                  customer c, cc_deal cc
where r.rnk = c.rnk
   and r.nd = cc.nd(+)  
 order by r.nls, r.kv'  
     where pkey ='\BRS\SBM\OTC\4010';

COMMIT;
EXCEPTION WHEN OTHERS THEN 
   NULL;
END;
/



