PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_paym_fields.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_paym_fields ***

create or replace view v_msp_paym_fields as
select (select acc.acc_num
        from msp_acc_trans_2909 acc
        where acc.kf = ltrim(mf.receiver_mfo,'0')) acc_2909,
       nvl((select nvl(cu.okpo,'123456789')
            from bars.accounts ac,
                 bars.customer cu
            where ac.rnk = cu.rnk
                  and ac.kf = '300465'
                  and ac.kv = '980'
                  and ac.nls = (select acc.acc_num
                                from msp_acc_trans_2909 acc
                                where acc.kf = ltrim(mf.receiver_mfo,'0'))),'123456789') okpo_2909,
       '300465' mfo_2909,
       nvl((select nvl(ac.nms,'���������� ������� 2909')
            from bars.accounts ac
            where ac.kf = '300465'
                  and ac.kv = '980'
                  and ac.nls = (select acc.acc_num
                                from msp_acc_trans_2909 acc
                                where acc.kf = ltrim(mf.receiver_mfo,'0'))),'���������� ������� 2909') name_2909,
       (select acc.acc_num
          from msp_acc_trans_2560 acc
         where acc.kf = ltrim(mf.receiver_mfo,'0')) acc_2560,
       (select acc.edrpu
          from msp_acc_trans_2560 acc
         where acc.kf = ltrim(mf.receiver_mfo,'0')) okpo_2560,
       ltrim(mf.receiver_mfo,'0') mfo_2560,
       '���������� ������� 2560' name_2560,
       case ltrim(mf.receiver_mfo,'0') when '300465' then 'PFX'
                                         else('PFD'/*select pp.value
                                                from pfu_parameter pp
                                               where pp.key = 'PFU_DEBET_TTS'*/) end debet_tts,
       (select sum(mfr.pay_sum/**0.01*/)
          from msp_file_records mfr
         where mfr.file_id = mf.id
           and mfr.state_id = 0) sum,
         '������������� �������� ���� �� ������ �{0}' nazn,
       mf.id   
from msp_files mf;

PROMPT *** Create comments on v_msp_paym_fields ***

comment on table v_msp_paym_fields is '��������� ����������� ���������� �������';
comment on column v_msp_paym_fields.ACC_2909 is '���������� ������� 2909 ���������� � ��';
comment on column v_msp_paym_fields.OKPO_2909 is '������ ����������';
comment on column v_msp_paym_fields.MFO_2909 is '��� ����������';
comment on column v_msp_paym_fields.NAME_2909 is '����� ����������� ������� 2909 ���������� � ��';
comment on column v_msp_paym_fields.ACC_2560 is '������� 2560 ��� �������� � ��';
comment on column v_msp_paym_fields.OKPO_2560 is '������ ��';
comment on column v_msp_paym_fields.MFO_2560 is '��� ��';
comment on column v_msp_paym_fields.NAME_2560 is '����� ������� 2560 ��';
comment on column v_msp_paym_fields.DEBET_TTS is '��� ��������';
comment on column v_msp_paym_fields.SUM is '���� �������';
comment on column v_msp_paym_fields.NAZN is '����������� �������';
comment on column v_msp_paym_fields.ID is 'id ������';


PROMPT *** Create  grants  v_msp_paym_fields ***

grant select on v_msp_paym_fields to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_paym_fields.sql =========*** End *** =
PROMPT ===================================================================================== 
