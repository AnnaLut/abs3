exec bpa.alter_policy_info('V_SALDO_DSW', 'WHOLE' , null, null, null, null);
exec bpa.alter_policy_info('V_SALDO_DSW', 'FILIAL', null, null, null, null);

create or replace force view bars.v_saldo_dsw
(
   fdat,
   rnk,
   kv,
   short_s1,
   short_i1,
   long_s1,
   long_i1,
   short_s2,
   short_i2,
   long_s2,
   long_i2,
   short_s1_uah,
   long_s1_uah,
   short_s2_uah,
   long_s2_uah
)
as
   select fdat,
          rnk,
          kv,
          round (short_s1, 10) as short_s1,
          round (short_i1, 10) as short_i1,
          round (long_s1, 10) as long_s1,
          round (long_i1, 10) as long_i1,
          round (short_s2, 10) as short_s2,
          round (short_i2, 10) as short_i2,
          round (long_s2, 10) as long_s2,
          round (long_i2, 10) as long_i2,
          round (short_s1_uah, 10) as short_s1_uah,
          round (long_s1_uah, 10) as long_s1_uah,
          round (short_s2_uah, 10) as short_s2_uah,
          round (long_s2_uah, 10) as long_s2_uah
     from saldo_dsw;

comment on table bars.v_saldo_dsw is '������� �����-����� �� ����-������';

comment on column bars.v_saldo_dsw.fdat is '���� ����';

comment on column bars.v_saldo_dsw.rnk is '���.��~���=0';

comment on column bars.v_saldo_dsw.kv is '���~���.';

comment on column bars.v_saldo_dsw.short_s1 is '�����~�������~TOD+TO�~(�����)';

comment on column bars.v_saldo_dsw.short_i1 is '�����~�� % ��.~TOD+TO�~(�����)';

comment on column bars.v_saldo_dsw.long_s1 is '�����~�������~�������~(����.)';

comment on column bars.v_saldo_dsw.long_i1 is '�����:~�� % ��.~�������~(����.)';

comment on column bars.v_saldo_dsw.short_s2 is '�����.~�������~TOD+TO�~(�����)';

comment on column bars.v_saldo_dsw.short_i2 is '�����.~�� % ��.~TOD+TO�~(�����)';

comment on column bars.v_saldo_dsw.long_s2 is '�����.~�������~�������~(����.)';

comment on column bars.v_saldo_dsw.long_i2 is '�����.~�� % ��.~�������~(����.)';

comment on column bars.v_saldo_dsw.short_s1_uah is '����� ���:������� TOD+TO� (�����)';

comment on column bars.v_saldo_dsw.long_s1_uah is '�����. ���:������� TOD+TO� (�����)';

comment on column bars.v_saldo_dsw.short_s2_uah is '����� ���:������� ������� (����.)';

comment on column bars.v_saldo_dsw.long_s2_uah is '�����. ���:������� ������� (����.)';


grant select on bars.v_saldo_dsw to bars_access_defrole;


exec  bpa.alter_policies('V_SALDO_DSW');
