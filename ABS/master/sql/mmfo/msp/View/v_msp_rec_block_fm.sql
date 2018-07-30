PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/msp/view/v_msp_rec_block_fm.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create view v_msp_rec_block_fm ***

create or replace view v_msp_rec_block_fm as
select o.ref,
          o.tt,
          to_char (o.pdat, 'dd.mm.yyyy hh:mm:ss') as doc_date,
          mr.file_id,
          mr.id,
          mr.filia_num as mfo,
          mr.deposit_acc as nls,
          mr.numident as okpo,
          mr.full_name as fio,
          o.s / 100 as suma,
          o.sos,
          ov.groupid,
          ov.username,
          ov.groupname
     from bars.oper_visa ov
          left join bars.oper o on (o.ref = ov.ref)
          inner join msp_file_records mr on (mr.ref = o.ref)
    where ov.groupid = 44 and mr.ref is not null and o.sos = 1;

PROMPT *** Create comments on v_msp_rec_block_fm ***
comment on table v_msp_rec_block_fm is '������������� ��� ��������� ��������� ������������ ���. �����������';
comment on column v_msp_rec_block_fm.ref is '�������� ���������';
comment on column v_msp_rec_block_fm.tt is '��� ��������';
comment on column v_msp_rec_block_fm.doc_date is '���� ���������';
comment on column v_msp_rec_block_fm.file_id is 'ID ������';
comment on column v_msp_rec_block_fm.mfo is '���';
comment on column v_msp_rec_block_fm.nls is '����� ������� ����������';
comment on column v_msp_rec_block_fm.okpo is '���';
comment on column v_msp_rec_block_fm.fio is 'ϲ�';
comment on column v_msp_rec_block_fm.suma is '����';
comment on column v_msp_rec_block_fm.sos is '���� ������ ���������';
comment on column v_msp_rec_block_fm.groupid is '����� ��������';
comment on column v_msp_rec_block_fm.username is '����������';
comment on column v_msp_rec_block_fm.groupname is '����� ����� ��������';
comment on column v_msp_rec_block_fm.id is 'id �������������� ����� �����';

PROMPT *** Create  grants  v_msp_rec_block_fm ***

grant select on v_msp_rec_block_fm to bars_access_defrole;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/msp/view/v_msp_rec_block_fm.sql =========*** End *** =
PROMPT ===================================================================================== 
