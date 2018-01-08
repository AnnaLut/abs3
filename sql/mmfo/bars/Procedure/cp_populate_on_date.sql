

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_POPULATE_ON_DATE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_POPULATE_ON_DATE ***

  CREATE OR REPLACE PROCEDURE BARS.CP_POPULATE_ON_DATE (p_date date, p_o_c number)
/* Процедура для населення даними для функції ЦП Портфель на дату
   p_o_c =NULL або 0 - відкриті угоди
   p_o_c =1 - закриті
*/
is
  l_date date := nvl(p_date, gl.bd);
begin
  delete from cp_on_date where user_id = user_id();
  /*
     Set MO_PR = SalNumberPower( ( NO_PR(IR) + 100 ) / 100, 1/12 ) * 100  - 100
  */
  if nvl(p_o_c, 0) = 0 then
    insert into cp_on_date(id,             cp_id,              ryn,               ryn_name,
                           ref,             erat,              dox,               emi,           kv,
                           mdate,             osta,              pf,               pf_name,
                           datd,             nd,              rnk,               sumb,
                           vidd,             ir,              mo_pr,               ostd,
                           ostp,             ostr,              ostr2,               osts,
                           ostab,             ostaf,              p_date)
    select v.id, v.cp_id,v.ryn, r.name,
           v.REF, v.erat, v.dox, v.emi, v.kv,
           v.mdate, v.osta, v.pf, v.pfname,
           v.datd, v.nd, v.rnk, v.sumb,
           v.vidd, v.ir, round(power((v.ir + 100)/100, 1/12) * 100 -100, 12), v.ostd,
           v.ostp, v.ostr, v.ostr2, v.osts,
           v.ostab, v.ostaf, l_date
    from cp_v v, cp_ryn r
    where v.ryn = r.ryn
          and (FOST_H(acc, l_date) <> 0 or
               FOST_H(acc, l_date) = 0 and datP <= l_date and datd >= l_date) and id in (select id from cp_kod where id > 0)
    order by ref desc;
    elsif p_o_c = 1 then
      insert into cp_on_date(id,             cp_id,              ryn,               ryn_name,
                           ref,             erat,              dox,               emi,           kv,
                           mdate,             osta,              pf,               pf_name,
                           datd,             nd,              rnk,               sumb,
                           vidd,             ir,              mo_pr,               ostd,
                           ostp,             ostr,              ostr2,               osts,
                           ostab,             ostaf,              p_date)
      select  v.id, v.cp_id,v.ryn, r.name,
           v.REF, v.erat, v.dox, v.emi, v.kv,
           v.mdate, fost_h(v.acc, l_date)/100 as osta, v.pf, v.pfname,
           v.datd, v.nd, v.rnk, v.sumb,
           v.vidd, v.ir, round(power((v.ir + 100)/100, 1/12) * 100 -100, 12) as mo_pr, fost_h(v.accd, l_date)/100 as ostd,
           fost_h(v.accp, l_date)/100 as ostp, fost_h(v.accr, l_date)/100 as ostr, fost_h(v.accr2, l_date)/100 as ostr2, fost_h(v.accs, l_date)/100 as osts,
           v.ostab, v.ostaf, l_date
      from cp_v v, cp_ryn r
      where v.ryn = r.ryn
        and v.datd <= l_date
        and (v.OSTAB = 0 and v.OSTAF = 0)
        and v.ID in (select id from cp_kod where id > 0)
      order by ref desc;
  end if;
end;
/
show err;

PROMPT *** Create  grants  CP_POPULATE_ON_DATE ***
grant EXECUTE                                                                on CP_POPULATE_ON_DATE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_POPULATE_ON_DATE.sql =========*
PROMPT ===================================================================================== 
