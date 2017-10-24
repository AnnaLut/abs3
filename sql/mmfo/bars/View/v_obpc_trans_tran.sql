

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_OBPC_TRANS_TRAN.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_OBPC_TRANS_TRAN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_OBPC_TRANS_TRAN ("TRAN_TYPE", "TIP", "T980", "T840", "V840", "T980_F_SHORT", "T840_F_SHORT", "V840_F_SHORT", "T980_F_LONG", "T840_F_LONG", "V840_F_LONG", "T980_U_SHORT", "T840_U_SHORT", "V840_U_SHORT", "T980_U_LONG", "T840_U_LONG", "V840_U_LONG") AS 
  select tran_type, tip,
       max(decode(kv,980,nls,null)) t980,
       max(decode(kv,840,nls,null)) t840,
       max(decode(kv,840,val_tr,null)) v840,
       max(decode(kv,980,nls_fs,null)) t980_fs,
       max(decode(kv,840,nls_fs,null)) t840_fs,
       max(decode(kv,840,val_fs,null)) v840_fs,
       max(decode(kv,980,nls_fl,null)) t980_fl,
       max(decode(kv,840,nls_fl,null)) t840_fl,
       max(decode(kv,840,val_fl,null)) v840_fl,
       max(decode(kv,980,nls_us,null)) t980_us,
       max(decode(kv,840,nls_us,null)) t840_us,
       max(decode(kv,840,val_us,null)) v840_us,
       max(decode(kv,980,nls_ul,null)) t980_ul,
       max(decode(kv,840,nls_ul,null)) t840_ul,
       max(decode(kv,840,val_ul,null)) v840_ul
  from ( select t.tran_type, t.tip, t.kv, a.nls, null val_tr,
                afs.nls nls_fs, null val_fs, afl.nls nls_fl, null val_fl,
                aus.nls nls_us, null val_us, aul.nls nls_ul, null val_ul
           from obpc_trans_tran t, accounts a, accounts afs, accounts afl, accounts aus, accounts aul
          where t.transit_acc = a.acc(+) and t.kv = 980 and t.branch = sys_context('bars_context','user_branch')
            and t.acc_f_short = afs.acc(+)
            and t.acc_f_long  = afl.acc(+)
            and t.acc_u_short = aus.acc(+)
            and t.acc_u_long  = aul.acc(+)
          union all
         select t.tran_type, t.tip, t.kv, a.nls, a.kv,
                afs.nls, afs.kv val_fs, afl.nls, afl.kv val_fl,
                aus.nls, aus.kv val_us, aul.nls, aul.kv val_ul
           from obpc_trans_tran t, accounts a, accounts afs, accounts afl, accounts aus, accounts aul
          where t.transit_acc = a.acc(+) and t.kv = 840 and t.branch = sys_context('bars_context','user_branch')
            and t.acc_f_short = afs.acc(+)
            and t.acc_f_long  = afl.acc(+)
            and t.acc_u_short = aus.acc(+)
            and t.acc_u_long  = aul.acc(+) )
 group by tran_type, tip
 union all
select g.tran_type, t.tip, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null
  from obpc_trans g, (select unique tip from obpc_tips) t
 where (g.tran_type, t.tip) not in
       (select tran_type, tip from obpc_trans_tran where branch = sys_context('bars_context','user_branch'));

PROMPT *** Create  grants  V_OBPC_TRANS_TRAN ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_TRANS_TRAN to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_OBPC_TRANS_TRAN to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_OBPC_TRANS_TRAN to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_OBPC_TRANS_TRAN to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_OBPC_TRANS_TRAN.sql =========*** End 
PROMPT ===================================================================================== 
