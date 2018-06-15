PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/function/F_GET_ACC_TRANSACTION.sql =========*** Run 
PROMPT ===================================================================================== 

CREATE OR REPLACE FUNCTION F_GET_ACC_TRANSACTION (
                                               p_acc_id          number --Внутренний идентифкатор счета
                                               , p_begin_dt       date   --Операции с какой даты
                                               , p_end_dt         date   --До какой даты операции интересуют
                                             )
return t_acc_transactions pipelined
is
    l_row       t_acc_transaction;
begin
   for c in (
               select /* PARALLEL(8) */
                      p.pdat
                      , p.mfoa
                      , r1.nb as namb_a
                      , r1.k040 k040b_a
                      , p.accd
                      , p.nlsa
                      , p.nam_a
                      , p.id_a as okpo_a
                      , p.mfob
                      , r2.nb as namb_b
                      , r2.k040 k040b_b
                      , p.acck
                      , p.nlsb
                      , p.nam_b
                      , p.id_b as okpo_b
                      , p.kv
                      , p.s
                      , p.sq
                      , p.ref
                      , p.nazn
                      , p.SOS_OPERATION
                      , p.stmt
                      , p.tt
                      , p.txt
                      , p.nbsd
                      , p.nbsk
               from   rcukru r1
                      , rcukru r2
                      , (
                                 SELECT p.userid isp
                                      , p.branch
                                      , p.mfoa
                                      , p.mfob
                                      , p.nam_a
                                      , p.nam_b
                                      , p.sos as SOS_OPERATION
                                      , DECODE (o.tt, p.tt, p.nazn, DECODE (o.tt, 'PO3', p.nazn, t.NAME)) nazn
                                      , o.tt
                                      , o.REF
                                      , ad.kv
                                      , o.s
                                      , o.sq
                                      , o.fdat
                                      , o.stmt
                                      , o.txt
                                      , o.accd
                                      , ad.nls as nlsd
                                      , ad.NBS nbsd
                                      , ad.branch as branch_a
                                      , ad.rnk rnkd
                                      , ad.ob22 ob22d
                                      , o.acck
                                      , ak.nls nlsk
                                      , ak.NBS nbsk
                                      , ak.branch branch_b
                                      , ak.rnk rnkk
                                      , ak.ob22 ob22k
                                      , p.vob
                                      , p.nlsa
                                      , p.nlsb
                                      , p.kv as kv_o
                                      , p.kv2 kv2_o
                                      , p.dk dk_o
                                      , p.pdat
                                      , p.datd pdatd
                                      , p.nazn pnazn
                                      , p.tt ptt
                                      , p.s ps
                                      , p.id_a
                                      , p.id_b
                                FROM  oper p
                                      , tts t
                                      , accounts ad
                                      , accounts ak
                                      , (
                                           SELECT o1.fdat
                                                  , o1.REF
                                                  , o1.stmt
                                                  , o1.tt
                                                  , o1.s
                                                  , o1.sq
                                                  , o1.txt
                                                  , (case when o1.dk = 0 then o1.acc else o2.acc end) accd
                                                  ,  (case when o1.dk = 1 then o1.acc else o2.acc end) acck
                                           FROM   opldok o1
                                                  JOIN opldok o2 ON (o1.KF  = o2.kf)
                                                                    AND (o1.REF = o2.REF)
                                                                    AND (o1.stmt= o2.stmt)
                                                                    AND (o1.dk <> o2.dk)
                                           WHERE  o1.fdat between p_begin_dt and p_end_dt
                                                  AND o1.acc = p_acc_id
                                       ) o
                               WHERE   p.REF = o.REF
                                       AND t.tt = o.tt
                                       AND o.accd = ad.acc
                                       AND o.acck = ak.acc
                            ) p
                      where p.mfoa = r1.mfo
                        and p.mfob = r2.mfo
            )
   loop
     l_row := t_acc_transaction(
                                 c.ref                                    --REF
                                 , c.SOS_OPERATION                        --SOS
                                 , c.STMT                                 --STMT
                                 , c.Tt                                   --TT
                                 , c.TXT                                  --TXT
                                 , c.kv                                   --KV
                                 , c.s                                    --BAL
                                 , c.sq                                   --BAL_UAH
                                 , null                                   --CUST_ID_DB
                                 , c.nam_a                                --CUST_NAME_DB
                                 , c.okpo_a                               --CUST_OKPO_DB
                                 , c.accd                                 --ACC_ID_DB
                                 , c.nlsa                                 --ACC_NUM_DB
                                 , nvl(c.nbsd, substr(c.nlsa, 1, 4))      --R020_DB
                                 , null                                   --CUST_ID_CR
                                 , c.nam_b                                --CUST_NAME_CR
                                 , c.okpo_b                               --OKPO_CR
                                 , c.acck                                 --ACC_ID_CR
                                 , c.nlsb                                 --ACC_NUM_CR
                                 , nvl(c.nbsk, substr(c.nlsb, 1, 4))      --R020_CR
                                 , c.mfoa                                 --MFO_DB
                                 , c.namb_a                               --BANK_NAME_DB
                                 , c.mfob                                 --MFO_CR
                                 , c.namb_b                               --BANK_NAME_CR
                                 , c.nazn                                 --PURPOSE_OF_PAYMENT
                                 , c.pdat                                 --OPERATION_DATE
                               );  
   
     pipe row (l_row);     
   end loop;


   return;
end;
/
show err;
 
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/function/F_GET_ACC_TRANSACTION.sql =========*** End 
PROMPT ===================================================================================== 