

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_AGREEMENTS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_AGREEMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_AGREEMENTS ("AGRMNT_ID", "AGRMNT_DATE", "AGRMNT_NUM", "AGRMNT_TYPE", "AGRMNT_TYPENAME", "DPT_ID", "BRANCH", "OWNER_ID", "BANKDATE", "TEMPLATE_ID", "TRUST_ID", "TRUSTEE_ID", "TRUSTEE_NAME", "AGRMNT_STATE", "FL_ACTIVITY", "COMMENTS") AS 
  select /* все доп.соглашения о 3-их лицах */
       x.agrmnt_id, x.agrmnt_date, x.agrmnt_num, x.agrmnt_type, f.name,
       x.dpt_id, x.branch, x.cust_id, x.bankdate, x.template_id,
       x.trustee_id, x.rnk_tr, c.nmk, x.agrmnt_state,
       (case
        when x.agrmnt_term_state in (8, 9) then 0
        else x.agrmnt_state
        end),
         (case
          when x.agrmnt_state = 1 then 'активна'
          when x.agrmnt_state = 0 then 'закрита'|| x.undocomm
          else 'сторнована'
          end)
       ||
         (case
          when x.dates is not null
          then ', термін дії'||x.dates||
               (case
                when x.agrmnt_term_state = 8 then ' - ще не настав'
                when x.agrmnt_term_state = 9 then ' - вже минув'
                else                              ' - триває'
                end)
          end)
  from dpt_vidd_flags  f,
       customer        c,
       (select da.agrmnt_id, da.agrmnt_date, da.agrmnt_num, da.agrmnt_type,
               da.dpt_id, da.branch, da.cust_id, da.bankdate, da.template_id,
               da.trustee_id, t.rnk_tr, da.agrmnt_state,
               (case
                when u.add_num is not null
                then ', анульована дод. угодою №'||u.add_num
                end) undocomm,
               (case
                when da.agrmnt_type = 12
                then nvl2(da.date_begin, ' з ',  null) || to_char(da.date_begin, 'dd.mm.yyyy') ||
                     nvl2(da.date_end,   ' по ', null) || to_char(da.date_end,   'dd.mm.yyyy')
                else null
                end) dates,
               (case
                when da.agrmnt_type = 12 and da.date_begin > trunc(sysdate)
                then 8
                when da.agrmnt_type = 12 and da.date_end   < trunc(sysdate)
                then 9
                else da.agrmnt_state
                end) agrmnt_term_state
         from dpt_agreements  da,
              dpt_trustee     t,
              dpt_trustee     u
        where da.trustee_id   = t.id
          and t.id            = u.undo_id (+)
          and da.agrmnt_type != 7) x
 where x.agrmnt_type  = f.id
   and x.rnk_tr       = c.rnk
 union all
select /* все остальные доп.соглашения */
       da.agrmnt_id, da.agrmnt_date, da.agrmnt_num, da.agrmnt_type, f.name,
       da.dpt_id, da.branch, da.cust_id, da.bankdate, da.template_id,
       null, null, null, da.agrmnt_state, da.agrmnt_state,
       decode(da.agrmnt_state, 1, 'активна', 0, 'закрита', 'сторнована')
  from dpt_agreements da,
       dpt_vidd_flags f
 where da.agrmnt_type = f.id
   and (da.trustee_id is null or da.agrmnt_type = 7);

PROMPT *** Create  grants  V_DPT_AGREEMENTS ***
grant SELECT                                                                 on V_DPT_AGREEMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_AGREEMENTS to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_AGREEMENTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_AGREEMENTS.sql =========*** End *
PROMPT ===================================================================================== 
