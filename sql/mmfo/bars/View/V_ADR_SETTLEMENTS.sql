create or replace view v_adr_settlements
(setl_id, setl_nm, setl_tp_id, setl_tp_nm, region_id, region_name, area_id, area_name)
as
select s.SETTLEMENT_ID
     , s.SETTLEMENT_NAME
     , s.SETTLEMENT_TYPE_ID
     , t.SETTLEMENT_TP_NM
     , s.REGION_ID
     , r.region_name
     , s.AREA_ID
     , a.area_name
  from BARS.ADR_SETTLEMENTS s
  join BARS.ADR_SETTLEMENT_TYPES t on ( t.SETTLEMENT_TP_ID = s.SETTLEMENT_TYPE_ID )
  join BARS.ADR_REGIONS          R on ( r.region_id        = s.region_id )
  left join BARS.ADR_AREAS       A on ( a.area_id          = s.area_id)    
 where END_DT Is Null;
comment on table V_ADR_SETTLEMENTS is '������� ��������� ������';
comment on column V_ADR_SETTLEMENTS.SETL_ID is '������������� ���������� ������ (equal to "SPIU.SUMMARYSETTLEMENTS.SUMMARYSETTLEMENTID"';
comment on column V_ADR_SETTLEMENTS.SETL_NM is '����� ���������� ������';
comment on column V_ADR_SETTLEMENTS.SETL_TP_ID is '������������� ���� ���������� ������';
comment on column V_ADR_SETTLEMENTS.SETL_TP_NM is '����� ���� ���������� ������';
comment on column V_ADR_SETTLEMENTS.REGION_ID is '��. ������ (��� ��� ��������� ��������������)';
comment on column V_ADR_SETTLEMENTS.region_name is '����� ������';
comment on column V_ADR_SETTLEMENTS.AREA_ID is '��. ������';
comment on column V_ADR_SETTLEMENTS.area_name is '����� ������';


GRANT SELECT ON BARS.v_adr_settlements TO BARS_ACCESS_DEFROLE;
