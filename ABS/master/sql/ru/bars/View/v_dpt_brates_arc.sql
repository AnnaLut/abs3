create or replace view V_DPT_BRATES_ARC as
  SELECT MOD_CODE,
         db.VIDD,
         v.TYPE_NAME,
         db.BR_ID,
         br.NAME,
         DATE_ENTRY,
         db.BASEY
    FROM DPT_BRATES db, BRATES br, DPT_VIDD v
   WHERE db.BR_ID = br.BR_ID AND db.VIDD = v.VIDD
ORDER BY MOD_CODE, DATE_ENTRY, VIDD DESC;
/
comment on table V_DPT_BRATES_ARC is '������ ��� ������� ������ �� ����� �������� ��';
comment on column V_DPT_BRATES_ARC.mod_code is '��� ������';
comment on column V_DPT_BRATES_ARC.VIDD is '��� ������';
comment on column V_DPT_BRATES_ARC.TYPE_NAME is '�����';
comment on column V_DPT_BRATES_ARC.BR_ID is '��� ������';
comment on column V_DPT_BRATES_ARC.NAME is '����� ������';
comment on column V_DPT_BRATES_ARC.DATE_ENTRY is '���� ������������';
comment on column V_DPT_BRATES_ARC.BASEY is '��� �������� ����';
/
grant select on v_dpt_brates_arc to bars_access_defrole;
/ 



