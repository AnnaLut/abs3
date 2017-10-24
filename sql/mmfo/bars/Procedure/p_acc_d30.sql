

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ACC_D30.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ACC_D30 ***

  CREATE OR REPLACE PROCEDURE BARS.P_ACC_D30 (dat01_ DATE)
IS


mfo_       NUMBER;
mfou_      NUMBER;
freq_      number;
nd_        NUMBER;
fl_        NUMBER;
ost_nal    NUMBER;
szn_       NUMBER;
sznq_      NUMBER;
szn30_     NUMBER;
sznq30_     NUMBER;
s_kos      NUMBER;
sdat01_    varchar2(10);
se1_       DECIMAL (24);
o_r013_1   VARCHAR2 (1);
o_se_1     DECIMAL (24);
o_comm_1   rnbu_trace.comm%TYPE;
-- ПОСЛЕ 30 ДНЕЙ
o_r013_2   VARCHAR2 (1);
o_se_2     DECIMAL (24);
o_comm_2   rnbu_trace.comm%TYPE;
dat_nal    date  := to_date('01042011','ddmmyyyy');
dat31_     date;
 

begin  
   dat31_:= Dat_last (DAT01_ -4 , DAT01_ -1 );
   sdat01_ := to_char( DAT01_,'dd.mm.yyyy');
   pul_dat(sdat01_,'');
   -- свой МФО
   mfo_ := f_ourmfo ();
   -- МФО "родителя"
   BEGIN
      SELECT mfou INTO mfou_ FROM banks WHERE mfo = mfo_;
   EXCEPTION WHEN NO_DATA_FOUND THEN mfou_ := mfo_;
   END;

   delete from acc_30;
   
   for k in ( select n.nd,c.nmk, a.*,s.r013,ost_korr(a.acc,dat01_,null,a.nbs) se_ 
              from accounts a,specparam s,customer c,nd_acc n 
              where a.nbs in ('2068','2078','2088','2108','2118','2128','2138',
                              '2208','2238', '2607','2627','2657','3570','3578','3118') 
                    and ost_korr(a.acc,dat01_,null,a.nbs)<0 and a.acc = s.acc (+)
                    and a.rnk = c.rnk and a.acc = n.acc (+) 
              )
   LOOP              
      se1_ := k.se_;                                                                  
      begin
         -- определяем периодичность гашения процнтов
         SELECT i.freq INTO freq_
         FROM   nd_acc n8, accounts a8, int_accn i
         WHERE  n8.nd = k.nd AND n8.acc = a8.acc AND a8.nls LIKE '8999%'
                AND a8.acc = i.acc AND i.ID = 0 AND ROWNUM = 1;
      EXCEPTION WHEN NO_DATA_FOUND THEN freq_ := NULL;
      end;
     
      
/*      begin
         select  abs(nvl(s1.ostf,0)-nvl(s1.dos,0)+nvl(s1.kos,0)) into ost_nal
         from   (SELECT r020, SUBSTR (r020, 4, 1) sb FROM kl_r011 kk
                 WHERE  trim(prem) = 'КБ' AND SUBSTR (r020, 4, 1) in ('8','9')
                        and  d_close is null and kk.REM = 'D5'
                 group by r020, SUBSTR (r020, 4, 1)
                 union
                (select '1518' r020, '8' sb from dual union all   select '2238' r020, '8' sb from dual union all   
                 select '2607' r020, '8' sb from dual union all   select '2627' r020, '8' sb from dual union all
                 select '2028' r020, '8' sb from dual )
                ) n8
         left join (SELECT acc, MAX (fdat) fdat FROM saldoa where fdat <dat_nal group by acc)  sn on k.acc=sn.acc
         left join saldoa s1 on s1.acc = sn.acc and s1.fdat = sn.fdat
         where k.nbs=n8.r020;

         szn_:=0;
         begin
            select ost_nal + s into ost_nal  from rez_spn  where acc=k.acc;
         EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
         end;

         if ost_nal>0 then
            select NVL( sum (kos),0) into s_kos from saldoa  
            where fdat>=dat_nal and fdat<=dat31_ and acc=k.acc;
            if ost_nal >= s_kos then szn_:= ost_nal - s_kos;
            else                     szn_:=0;
            end if;
            sznq_:= gl.p_icurval (k.kv, szn_, dat31_);    szn_ := szn_ /100;    sznq_:= sznq_/100;
         else  szn_ := 0;    sznq_:= 0;
         end if;
      EXCEPTION  WHEN NO_DATA_FOUND  THEN      szn_ := 0;  sznq_:= 0;
      end;
*/
      begin
         select 1 into fl_ from nbu23_rez 
            where fdat=to_date('01-06-2015','dd-mm-yyyy') and acc=k.acc and ob22='09'
                  and nbs=k.nbs and nbs='2068' and rownum=1;   
            szn_   := -k.se_;  
            sznq_  := gl.p_icurval (k.kv, -k.se_ , dat31_);
            szn30_ := 0;
            sznq30_:= 0;
      EXCEPTION  WHEN NO_DATA_FOUND  THEN      

         begin
            select 1 into fl_ from srezerv_ob22 
            where nal not in (2,0) and r013=5 and nbs=k.nbs and ob22=k.ob22 and rownum=1; 
            szn_   := -k.se_;  
            sznq_  := gl.p_icurval (k.kv, -k.se_ , dat31_);
            szn30_ := 0;
            sznq30_:= 0;
         EXCEPTION  WHEN NO_DATA_FOUND  THEN      
            szn_   := 0     ;  sznq_   := 0;
            szn30_ := -k.se_;  sznq30_ := gl.p_icurval (k.kv, -k.se_ , dat31_);

         end;
      end;
  
      p_analiz_r013_new(mfo_,mfou_,dat01_,k.acc,k.tip,k.nbs,k.kv,k.r013,se1_,k.nd,freq_,
                     --------
                     o_r013_1,  o_se_1,  o_comm_1,
                     --------
                     o_r013_2,  o_se_2,  o_comm_2);
      insert into acc_30 (rnk,nmk,branch,acc,nls,kv,s_ob22_30,sq_ob22_30,s_ob22_31,sq_ob22_31,
                          s30,s31,sq30,sq31,comm_1,comm_2) 
      values ( k.rnk,k.nmk,k.branch,k.acc,k.nls,k.kv,szn30_,sznq30_,szn_,sznq_,-o_se_1,-o_se_2,
              gl.p_icurval (k.kv,-o_se_1, dat31_),
              gl.p_icurval (k.kv,-o_se_2, dat31_),o_comm_1,o_comm_2);                    
   end LOOP;
end;
/
show err;

PROMPT *** Create  grants  P_ACC_D30 ***
grant EXECUTE                                                                on P_ACC_D30       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ACC_D30       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ACC_D30.sql =========*** End ***
PROMPT ===================================================================================== 
