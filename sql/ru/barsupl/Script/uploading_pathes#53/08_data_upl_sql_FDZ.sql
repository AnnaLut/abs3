--закрытые договора
select 17 as ND_TYPE,
       substr(fa.ACC_SS, 1, length(fa.ACC_SS) - 2) as ND,
       fa.KF,
       a.DAOS  as SDATE,
       a.MDATE as WDATE,
       fa.CLS_DT  as DATE_CLOSE,
       15         as SOS,
       a.NLS   as CC_ID,
       substr(a.RNK, 1, length(a.RNK) - 2) RNK,
       a.BRANCH
  from BARS.PRVN_FIN_DEB_ARCH fa
       left join BARS.PRVN_FIN_DEB fd on (fa.acc_ss = fd.acc_ss)
       left join bars.accounts a on (fa.acc_ss = a.acc)
 where fd.acc_ss is null;



-- закрытые связки
select substr(fa.ACC_SS, 1, length(fa.ACC_SS) - 2) as ND,
       17 as ND_TYPE,
       fa.KF,
       'D' as CHGACTION,
       substr(fa.ACC_SS, 1, length(fa.ACC_SS) - 2) as ACC1,
       substr(fa.ACC_SP, 1, length(fa.ACC_SP) - 2) as ACC2,
       null, null, null, null, null, null, null, null, null, null, null, null, null
  from BARS.PRVN_FIN_DEB_ARCH fa
       left join BARS.PRVN_FIN_DEB fd on (fa.acc_ss = fd.acc_ss and fa.acc_sp = fd.acc_sp)
 where fd.acc_ss is null;