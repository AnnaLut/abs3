create or replace view v_zp_payroll as
select   id,
   payroll_num,
   zp_id,
   zp_deal_id,
   rnk,
   deal_name,
   nmk,
   pr_date,
   cnt,
   s,
   cms,
   sos_name,
   sos,
   src_name,
   src,
   comm_reject,
    case when (ostc_2909>=s+cms+case when sign(ostc_3570)=-1 then -ostc_3570 else 0 end) or (deal_premium=1 and ostc_2909>=s+case when sign(ostc_3570)=-1 then -ostc_3570 else 0 end) then 1 else 0 end not_enogh_money,
    case when (ostc_2909>=s+cms+case when sign(ostc_3570)=-1 then -ostc_3570 else 0 end) then 0 when  (deal_premium=1 and ostc_2909>=s+case when sign(ostc_3570)=-1 then -ostc_3570 else 0 end) then 0 else abs(ostc_2909-s-cms+ostc_3570) end not_enogh_sum,
    fio,
    signed,
    cnt_on_visa,
    signed_fio,
    ostc_2909,
    reject_fio,
    crt_date,
    imp_date
from
 (select r.id,
          r.payroll_num,
          r.zp_id,
          r.zp_deal_id,
          d.rnk,
          d.deal_name,
          c.nmk,
          r.pr_date,
          (select count (s)
             from zp_payroll_doc z
            where z.id_pr = r.id)
             cnt,
          nvl (  (select sum (s)
                    from zp_payroll_doc z
                   where z.id_pr = r.id)
               / 100,
               0)
             s,
          case when r.ref_cms is not null 
                 then coalesce(o.s,0)*0.01
               else
                 nvl (  f_tarif (d.kod_tarif, -- добавить поле сумы в zp_payroll , писать тудв,когда ведомость оплачена
                                 980,
                                 a2.nls,
                                 (select sum (s)
                                    from zp_payroll_doc z
                                   where z.id_pr = r.id))
                      / 100,
                      0)
                      end cms,
          s.name sos_name,
          s.sos,
          case
             when r.source = 1 then 'Ручне введення'
             when r.source = 2 then 'Імпорт файлу'
             when r.source = 3 then 'Ручне введення'--'Клонування відомості'
             when r.source = 4 then 'Змішаний тип'
             when r.source = 5 then 'Інтернет банк'

          end
             src_name,
             r.source src,
             r.comm_reject,
             a2.ostc/100 ostc_2909,
             d.deal_premium,
             ss.fio,
             a3.ostc/100 ostc_3570,
             r.signed,
             (select count (*)
             from zp_payroll_doc z,oper o
            where z.id_pr = r.id and o.ref=z.ref and o.sos = 1 )
             cnt_on_visa,
             f.fio signed_fio,
             rj.fio reject_fio,
             r.crt_date,
             case when r.source not in (2) then r.crt_date else (select max(f.imp_date) from zp_payroll_imp_files f where f.id_pr = r.id) end imp_date
     from zp_payroll r, zp_payroll_sos s, zp_deals d, staff$base ss , staff$base f ,staff$base rj,customer c, accounts a2, accounts a3, oper o
    where     r.sos = s.sos
          and d.id = r.zp_id
          and ss.id=r.user_id
          and c.rnk=d.rnk
          and d.acc_2909=a2.acc
          and d.acc_3570=a3.acc(+)
          and r.signed_user=f.id(+)
          and r.reject_user=rj.id(+)
          and r.ref_cms=o.ref(+)
          and r.branch like sys_context ('bars_context', 'user_branch_mask')) t;
/
grant delete, insert, select, update on bars.v_zp_payroll to bars_access_defrole;
/

