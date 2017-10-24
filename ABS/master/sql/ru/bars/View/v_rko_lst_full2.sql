create or replace force view bars.v_rko_lst_full2
(
   acc,
   nls,
   kv,
   nms,
   isp,
   dat0a,
   dat0b,
   rko_s0,
   koldok,
   dat1b,
   a1_ostc,
   dat2b,
   a2_ostc,
   nls_sp,
   kv_sp,
   accd,
   comm,
   acc1,
   r1,
   acc2,
   r2
)
as
     select a.acc,
            a.nls,
            a.kv,
            a.nms,
            a.isp,
            r.dat0a,
            r.dat0b,
            r.s0 / 100 as rko_s0,
            r.koldok,
            dat1b,
            -a1.ostc / 100 as a1_ostc,
            dat2b,
            -a2.ostc / 100 as a2_ostc,
            nvl (a0.nls, a.nls) as nls_sp,
            nvl (a0.kv, a.kv) as kv_sp,
            r.accd,
            r.comm,
            r.acc1,
            row_number () over (partition by r.acc1 order by r.acc1) r1,
            r.acc2,
            row_number () over (partition by r.acc2 order by r.acc2) r2
       from rko_lst  r,
            accounts a,
            accounts a0,
            accounts a1,
            accounts a2
      where     r.acc = a.acc
            and r.accd = a0.acc(+)
            and r.acc1 = a1.acc(+)
            and r.acc2 = a2.acc(+)
   order by substr (a.nls, 1, 4) || substr (a.nls, 6), a.kv;

show errors;

grant select on bars.v_rko_lst_full2 to bars_access_defrole;

comment on table bars.v_rko_lst_full2 is '����������� ���';

comment on column bars.v_rko_lst_full2.acc is '������������� ������� �����������';

comment on column bars.v_rko_lst_full2.nls is '�������';

comment on column bars.v_rko_lst_full2.kv is '���.';

comment on column bars.v_rko_lst_full2.nms is '�����';

comment on column bars.v_rko_lst_full2.isp is '���������� �� ���.';

comment on column bars.v_rko_lst_full2.dat0a is '���� �����������~�';

comment on column bars.v_rko_lst_full2.dat0b is '���� �����������~��';

comment on column bars.v_rko_lst_full2.rko_s0 is '����������';

comment on column bars.v_rko_lst_full2.koldok is '�-��� ���.';

comment on column bars.v_rko_lst_full2.acc1 is '������� ����� 3570';

comment on column bars.v_rko_lst_full2.a1_ostc is '���� 3570';

comment on column bars.v_rko_lst_full2.acc2 is '������� ������������ ����� 3579';

comment on column bars.v_rko_lst_full2.a2_ostc is '���� 3579';

comment on column bars.v_rko_lst_full2.accd is '������������� ������� ��������';

comment on column bars.v_rko_lst_full2.nls_sp is '������� ��������';

comment on column bars.v_rko_lst_full2.kv_sp is '������ ��������';

comment on column bars.v_rko_lst_full2.comm is '��������';
