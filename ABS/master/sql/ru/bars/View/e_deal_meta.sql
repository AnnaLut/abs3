create or replace force view bars.e_deal_meta
(
   nd,
   accs,
   sos,
   cc_id,
   dat1,
   rnk,
   user_id,
   nmk,
   sab,
   typ,
   nls36,
   osts36,
   nls26,
   kv26,
   osts26,
   dat4,
   acc_26,
   avans,
   ostp36,
   prz,
   nls_d,
   ost_d,
   branch,
   nls_p,
   ost_p,
   avto,
   tarif_check
)
as
  select nd,
         '�����������' as accs,
         sos,
         cc_id,
         sdate as dat1,
         rnk,
         user_id,
         nmk,
         sab,
         custtype as typ,
         nls36,
         ost36 as osts36,
         nls26,
         kv26,
         ost26 as osts26,
         wdate as dat4,
         acc26 as acc_26,
         sa as avans,
         pst36 as ostp36,
         prz_b as prz,
         nls_d,
         ost_d,
         branch,
         nls_p,
         ost_p,
         avto,
         tarif_check
    from (select e.nd,
                 e.sos,
                 e.cc_id,
                 e.sdate,
                 e.rnk,
                 e.user_id,
                 c.nmk,
                 c.sab,
                 c.custtype,
                 a26.acc as acc26,
                 a26.nls as nls26,
                 a26.kv as kv26,
                 a26.ostc/100 as ost26,
                 a36.nls as nls36,
                 a36.ostc/100 as ost36,
                 a36.ostb/100 as pst36,
                 ad.nls as nls_d,
                 ad.ostc/100 as ost_d,
                 ap.nls as nls_p,
                 ap.ostc/100 as ost_p,
                 e.wdate,
                 nvl(e.sa, 0)/100 as sa,
                 decode(a26.dazs,
                        null,
                        decode(a26.blkd, 0, a26.blkk, a26.blkd),
                        1) as prz_b,
                 a26.branch,
                 case nvl((select cw.value
                             from customerw cw
                            where c.rnk = cw.rnk(+)
                              and cw.tag = 'Y_ELT'
                              and rownum = 1),
                      'Y')
                   when 'N' then
                    0
                   else
                    1
                 end as avto,
                 nvl((select max(t.otm) from e_tar_nd t where t.nd = e.nd),0) as tarif_check
            from e_deal$base e,
                 customer c,
                 accounts a26,
                 accounts a36,
                 accounts ad,
                 accounts ap
           where e.rnk = c.rnk
             and e.acc26 = a26.acc
             AND e.acc36 = a36.acc(+)
             AND e.accd = ad.acc(+)
             AND e.accp = ap.acc(+));

show errors;

grant select on bars.e_deal_meta to bars_access_defrole;   


comment on table bars.e_deal_meta is '�������� ���� �� ��. ������� (������ ������)';
   
comment on column bars.e_deal_meta.rnk is '���';

comment on column bars.e_deal_meta.typ is '���~��.';

comment on column bars.e_deal_meta.nmk is '����� �볺���';

comment on column bars.e_deal_meta.sab is '��. ������';

comment on column bars.e_deal_meta.user_id is '���.';

comment on column bars.e_deal_meta.nd is '���. �����';

comment on column bars.e_deal_meta.accs is '�������~�����';

comment on column bars.e_deal_meta.cc_id is '�����.~�����';

comment on column bars.e_deal_meta.nls26 is '���.~��� �����~�����-�� �����';

comment on column bars.e_deal_meta.kv26 is '���~���.';

comment on column bars.e_deal_meta.dat1 is '���� �����';

comment on column bars.e_deal_meta.dat4 is '����~������������~����������';

comment on column bars.e_deal_meta.osts26 is '������� �� �������';

comment on column bars.e_deal_meta.nls36 is '�������~��� ������~���������';

comment on column bars.e_deal_meta.osts36 is '����. ���.~�� �������~���������';

comment on column bars.e_deal_meta.ostp36 is '����. ���.~�� �������~���������';

comment on column bars.e_deal_meta.avans is '����-��~���������';

comment on column bars.e_deal_meta.nls_d is '������� �����~��������� 3578/3579';

comment on column bars.e_deal_meta.ost_d is '�������~�����';

comment on column bars.e_deal_meta.nls_p is '�������-�������~(NLS_P)';

comment on column bars.e_deal_meta.ost_p is '������� ��~�������~NLS_P';

comment on column bars.e_deal_meta.branch is '(����)';

comment on column bars.e_deal_meta.tarif_check is '������~����������~������';

comment on column bars.e_deal_meta.prz is '������ ����������~������� ���������';

comment on column bars.e_deal_meta.avto is '���.';