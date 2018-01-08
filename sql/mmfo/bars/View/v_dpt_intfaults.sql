

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_INTFAULTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_INTFAULTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_INTFAULTS ("FAULT_TYPEID", "FAULT_TYPENAME", "FAULT_DETAILS", "BRANCH", "DPTYPE_ID", "DPT_NUM", "ACC_NUM", "CUR_ID") AS 
  select 1, '�����-�� ������� �������', f.name, a.branch, d.vidd, d.nd, a.nls, a.kv
  from dpt_deposit d,
       accounts    a,
       freq        f
 where d.acc       = a.acc
   and d.freq      = f.freq
   and d.branch    like sys_context('bars_context','user_branch')||'%'
   and d.freq      < 5
 union all
select /*+ index(a) index(i)*/
       2, '���� ���������� �����������',
       to_char(i.acr_dat, 'dd.mm.yyyy') ||' << ' || to_char(add_months(last_day(bankdate), -1), 'dd.mm.yyyy'),
       a.branch, d.vidd, d.nd, a.nls, a.kv
  from dpt_deposit d,
       accounts    a,
       int_accn    i
 where d.acc       = a.acc
   and d.acc       = i.acc
   and i.id        = 1
   and d.branch    like sys_context('bars_context','user_branch')||'%'
   and i.acr_dat   < add_months(last_day(bankdate), -1)
   and (i.stp_dat  is null or i.stp_dat > i.acr_dat)
 union all
select /*+ ordered index(a) index(i)*/
       3, '����-���� �� �����������',
       to_char(i.stp_dat, 'dd.mm.yyyy') ||' ������ ' || to_char(d.dat_end - 1, 'dd.mm.yyyy'),
       a.branch, d.vidd, d.nd, a.nls, a.kv
  from dpt_deposit d,
       accounts    a,
       int_accn    i
 where d.acc       = a.acc
   and d.acc       = i.acc
   and i.id        = 1
   and d.branch    like sys_context('bars_context','user_branch')||'%'
   and ((i.stp_dat is not null and d.dat_end is null)      or
        (i.stp_dat is null     and d.dat_end is not null)  or
        (i.stp_dat != d.dat_end - 1))
 union all
select 4, '��������� ������',
       to_char(fact_rate)||'% ������ '||to_char(plan_rate)||'% ( ���.������ � '||to_char(br_id)||')',
       branch, vidd, nd, nls, kv
  from
       (select d.branch, d.nd, a.nls, a.kv, v.br_id, v.vidd,
               nvl(getbrat (d.dat_begin, v.br_id, d.kv, d.limit), 0) plan_rate,
               nvl(acrn.fproc(a.acc, bankdate), 0) fact_rate
          from dpt_deposit  d,
               accounts     a,
               dpt_vidd     v,
               brates       b
         where d.acc        = a.acc
           and d.vidd       = v.vidd
           and v.br_id      = b.br_id
           and d.branch like sys_context('bars_context','user_branch')||'%'
           and d.vidd not in (select vidd from dpt_rate_rise) -- �������������
           and d.nd not like '%/_%/_%/_%/_%' escape '/'       -- ������ � �����
           and d.cnt_dubl   is null                           -- �����������������
           and b.br_type    in (1, 2)                         -- ������� ��� ����������� ������� ������
           and v.basem      = 1 )                             -- ������� ������������� ������
 where plan_rate != fact_rate;

PROMPT *** Create  grants  V_DPT_INTFAULTS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_INTFAULTS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_INTFAULTS to DPT_ADMIN;
grant FLASHBACK,SELECT                                                       on V_DPT_INTFAULTS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_INTFAULTS.sql =========*** End **
PROMPT ===================================================================================== 
