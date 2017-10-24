

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_TRANS_BY_TODAY_BARS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TRANS_BY_TODAY_BARS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_TRANS_BY_TODAY_BARS ("REF", "KF", "NLS", "KV", "NAME", "FDAT", "STMT", "ND", "DAT", "TYPE_ID", "D", "SQ", "CORR_BANK_ID", "CORR_BANK_NAME", "CORR_IDENT_CODE", "CORR_ACC_NUM", "CORR_NAME", "NAZN", "IBANK_DOCID") AS 
  select p.ref, c.kf, a.nls, a.kv,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nam_a
               else d.nam_b
               end
               as name,
               p.fdat, to_char(p.stmt) stmt, nvl(d.nd, substr(to_char(p.ref),1,10)) nd, nvl(v.dat,d.pdat) dat,
               case when p.dk=0 then 'D' else 'C' end as type_id, p.s/t.denom d, p.sq/980 sq,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.mfob
               else d.mfoa
               end
               as corr_bank_id,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then
                    (select nb from bars.banks  where mfo=d.mfob)
               else
                    (select nb from bars.banks  where mfo=d.mfoa)
               end
               as corr_bank_name,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.id_b
               else d.id_a
               end
               as corr_ident_code,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nlsb
               else d.nlsa
               end
               as corr_acc_num,
               case
               when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nam_b
               else d.nam_a
               end
               as corr_name,
               d.nazn,
               (select to_number(value) from bars.operw  where tag='EXREF' and ref=d.ref)
               as ibank_docid
          from ibank_acc c,
               bars.accounts a,
               bars.opldok p,
               bars.oper  d,
               bars.tabval t,
               bars.oper_visa  v
         where
           c.acc = a.acc
           and p.acc = c.acc
           and p.fdat >= trunc(sysdate)
           and p.sos = 5
           and p.ref = d.ref
           and a.kv = t.kv
           and (  not (d.kv is not null and d.kv2 is not null and d.kv<>d.kv2) -- не разновалютные
                  and p.tt=d.tt and p.s=d.s -- код операции и сумма совпадают
                  or p.tt='R01' -- или проводка типа R01
               )
           and d.ref = v.ref (+)
           and v.groupid (+) not in (77, 80, 81, 30,130)
           and v.status (+) = 2
union all
select p.ref, c.kf, a.nls, a.kv,
                case
                when p.dk=0 and d.dk=1 or p.dk=1 and d.dk=0 then d.nam_a
                else d.nam_b
               end
               as name,
               p.fdat as trans_date,
               to_char(p.stmt) as trans_id,
               nvl(d.nd, substr(to_char(p.ref),1,10)) as doc_number,
               nvl(v.dat,d.pdat) as doc_date,
               case when p.dk=0 then 'D' else 'C' end as type_id, p.s/t.denom, p.sq/890,
               a2.kf as corr_bank_id,
               b2.nb as corr_bank_name,
               c2.okpo as corr_ident_code,
               a2.nls as corr_acc_num,
               substr(a2.nms,1,38) as corr_name,
               trim(p.txt)||' '||trim(d.nazn),
               null as ibank_docid
          from ibank_acc c,
               bars.accounts a,
               bars.opldok p,
               bars.oper d,
               bars.tabval t,
               bars.opldok p2,
               v_kf_accounts a2,
               bars.banks b2,
               bars.customer c2,
               bars.oper_visa v
         where c.acc = a.acc
           and p.acc = c.acc
           and p.fdat >= trunc(sysdate)
           and p.sos = 5
           and p.ref = d.ref
           and a.kv = t.kv
           and (  d.kv is not null and d.kv2 is not null and d.kv<>d.kv2 -- разновалютные
               or p.tt<>d.tt or p.s<>d.s -- код операции или сумма не совпадают
             )
           and p.tt<>'R01' -- и проводка не R01
           and p.ref=p2.ref and p.stmt=p2.stmt and p.dk=1-p2.dk -- правая сторона проводки
           and p2.acc=a2.acc and a2.kf=b2.mfo and a2.rnk=c2.rnk
           and d.ref = v.ref (+)
           and v.groupid (+) not in (77, 80, 81, 30,130)
           and v.status (+) = 2
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_TRANS_BY_TODAY_BARS.sql =========**
PROMPT ===================================================================================== 
