prompt create table bars_intgr.client_address

begin
    execute immediate q'[
create table bars_intgr.client_address
(
CHANGENUMBER NUMBER,
KF VARCHAR2(6),
RNK NUMBER(22),
J_COUNTRY NUMBER(22),
J_ZIP VARCHAR2(20),
J_DOMAIN VARCHAR2(30),
J_REGION VARCHAR2(30),
J_LOCALITY VARCHAR2(30),
J_ADDRESS VARCHAR2(100),
J_TERRITORY_ID NUMBER(22),
J_LOCALITY_TYPE NUMBER(22),
J_STREET_TYPE NUMBER(22),
J_STREET VARCHAR2(100),
J_HOME_TYPE NUMBER(22),
J_HOME VARCHAR2(100),
J_HOMEPART_TYPE NUMBER(22),
J_HOMEPART VARCHAR2(100),
J_ROOM_TYPE NUMBER(22),
J_ROOM VARCHAR2(100),
J_KOATUU VARCHAR2(15),
J_REGION_ID NUMBER(10),
J_AREA_ID NUMBER(10),
J_SETTLEMENT_ID NUMBER(10),
J_STREET_ID NUMBER(10),
J_HOUSE_ID NUMBER(10),
F_COUNTRY NUMBER(22),
F_ZIP VARCHAR2(20),
F_DOMAIN VARCHAR2(30),
F_REGION VARCHAR2(30),
F_LOCALITY VARCHAR2(30),
F_ADDRESS VARCHAR2(100),
F_TERRITORY_ID NUMBER(22),
F_LOCALITY_TYPE NUMBER(22),
F_STREET_TYPE NUMBER(22),
F_STREET VARCHAR2(100),
F_HOME_TYPE NUMBER(22),
F_HOME VARCHAR2(100),
F_HOMEPART_TYPE NUMBER(22),
F_HOMEPART VARCHAR2(100),
F_ROOM_TYPE NUMBER(22),
F_ROOM VARCHAR2(100),
F_KOATUU VARCHAR2(15),
F_REGION_ID NUMBER(10),
F_AREA_ID NUMBER(10),
F_SETTLEMENT_ID NUMBER(10),
F_STREET_ID NUMBER(10),
F_HOUSE_ID NUMBER(10),
P_COUNTRY NUMBER(22),
P_ZIP VARCHAR2(20),
P_DOMAIN VARCHAR2(30),
P_REGION VARCHAR2(30),
P_LOCALITY VARCHAR2(30),
P_ADDRESS VARCHAR2(100),
P_TERRITORY_ID NUMBER(22),
P_LOCALITY_TYPE NUMBER(22),
P_STREET_TYPE NUMBER(22),
P_STREET VARCHAR2(100),
P_HOME_TYPE NUMBER(22),
P_HOME VARCHAR2(100),
P_HOMEPART_TYPE NUMBER(22),
P_HOMEPART VARCHAR2(100),
P_ROOM_TYPE NUMBER(22),
P_ROOM VARCHAR2(100),
P_KOATUU VARCHAR2(15),
P_REGION_ID NUMBER(10),
P_AREA_ID NUMBER(10),
P_SETTLEMENT_ID NUMBER(10),
P_STREET_ID NUMBER(10),
P_HOUSE_ID NUMBER(10)
)
tablespace BRSDMIMP
PARTITION by list (KF)
 (  
 PARTITION KF_300465 VALUES ('300465'),
 PARTITION KF_302076 VALUES ('302076'),
 PARTITION KF_303398 VALUES ('303398'),
 PARTITION KF_304665 VALUES ('304665'),
 PARTITION KF_305482 VALUES ('305482'),
 PARTITION KF_311647 VALUES ('311647'),
 PARTITION KF_312356 VALUES ('312356'),
 PARTITION KF_313957 VALUES ('313957'),
 PARTITION KF_315784 VALUES ('315784'),
 PARTITION KF_322669 VALUES ('322669'),
 PARTITION KF_323475 VALUES ('323475'),
 PARTITION KF_324805 VALUES ('324805'),
 PARTITION KF_325796 VALUES ('325796'),
 PARTITION KF_326461 VALUES ('326461'),
 PARTITION KF_328845 VALUES ('328845'),
 PARTITION KF_331467 VALUES ('331467'),
 PARTITION KF_333368 VALUES ('333368'),
 PARTITION KF_335106 VALUES ('335106'),
 PARTITION KF_336503 VALUES ('336503'),
 PARTITION KF_337568 VALUES ('337568'),
 PARTITION KF_338545 VALUES ('338545'),
 PARTITION KF_351823 VALUES ('351823'),
 PARTITION KF_352457 VALUES ('352457'),
 PARTITION KF_353553 VALUES ('353553'),
 PARTITION KF_354507 VALUES ('354507'),
 PARTITION KF_356334 VALUES ('356334')
 )]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

comment on column bars_intgr.client_address.KF is '���';
comment on column bars_intgr.client_address.RNK is '���';
comment on column bars_intgr.client_address.J_COUNTRY is '��. ���. �����';
comment on column bars_intgr.client_address.J_ZIP is '��. ���. ������';
comment on column bars_intgr.client_address.J_DOMAIN is '��. ���. �������';
comment on column bars_intgr.client_address.J_REGION is '��. ���. �����';
comment on column bars_intgr.client_address.J_LOCALITY is '��. ���. ���. �����';
comment on column bars_intgr.client_address.J_ADDRESS is '��. ���. ������';
comment on column bars_intgr.client_address.J_TERRITORY_ID is '��. ���. ��� ������';
comment on column bars_intgr.client_address.J_LOCALITY_TYPE is '��. ���. ��� ���. ������';
comment on column bars_intgr.client_address.J_STREET_TYPE is '��. ���. ��� ������';
comment on column bars_intgr.client_address.J_STREET is '��. ���. ������';
comment on column bars_intgr.client_address.J_HOME_TYPE is '��. ���. ��� �������';
comment on column bars_intgr.client_address.J_HOME is '��. ���. �������';
comment on column bars_intgr.client_address.J_HOMEPART_TYPE is '��. ���. ��� ������� ���.';
comment on column bars_intgr.client_address.J_HOMEPART is '��. ���. ������� �������';
comment on column bars_intgr.client_address.J_ROOM_TYPE is '��. ���. ��� ����. �����.';
comment on column bars_intgr.client_address.J_ROOM is '��. ���. ����. ���������';
comment on column bars_intgr.client_address.J_KOATUU is '��. ���. ��� ������';
comment on column bars_intgr.client_address.J_REGION_ID is '��. ���. ��� ������';
comment on column bars_intgr.client_address.J_AREA_ID is '��. ���. ��� ������';
comment on column bars_intgr.client_address.J_SETTLEMENT_ID is '��. ���. ��� ���������� ������';
comment on column bars_intgr.client_address.J_STREET_ID is '��. ���. ��� ������';
comment on column bars_intgr.client_address.J_HOUSE_ID is '��. ���. ��� �������';
comment on column bars_intgr.client_address.F_COUNTRY is '����. ���. �����';
comment on column bars_intgr.client_address.F_ZIP is '����. ���. ������';
comment on column bars_intgr.client_address.F_DOMAIN is '����. ���. �������';
comment on column bars_intgr.client_address.F_REGION is '����. ���. �����';
comment on column bars_intgr.client_address.F_LOCALITY is '����. ���. ���. �����';
comment on column bars_intgr.client_address.F_ADDRESS is '����. ���. ������';
comment on column bars_intgr.client_address.F_TERRITORY_ID is '����. ���. ��� ������';
comment on column bars_intgr.client_address.F_LOCALITY_TYPE is '����. ���. ��� ���. ������';
comment on column bars_intgr.client_address.F_STREET_TYPE is '����. ���. ��� ������';
comment on column bars_intgr.client_address.F_STREET is '����. ���. ������';
comment on column bars_intgr.client_address.F_HOME_TYPE is '����. ���. ��� �������';
comment on column bars_intgr.client_address.F_HOME is '����. ���. �������';
comment on column bars_intgr.client_address.F_HOMEPART_TYPE is '����. ���. ��� ����. �������';
comment on column bars_intgr.client_address.F_HOMEPART is '����. ���. ������� �������';
comment on column bars_intgr.client_address.F_ROOM_TYPE is '����. ���. ��� ����. �����.';
comment on column bars_intgr.client_address.F_ROOM is '����. ���. ����. �����.';
comment on column bars_intgr.client_address.F_KOATUU is '����. ���. ��� ������';
comment on column bars_intgr.client_address.F_REGION_ID is '����. ���. ��� ������';
comment on column bars_intgr.client_address.F_AREA_ID is '����. ���. ��� ������';
comment on column bars_intgr.client_address.F_SETTLEMENT_ID is '����. ���. ��� ���������� ������';
comment on column bars_intgr.client_address.F_STREET_ID is '����. ���. ��� ������';
comment on column bars_intgr.client_address.F_HOUSE_ID is '����. ���. ��� �������';
comment on column bars_intgr.client_address.P_COUNTRY is '����. ���. �����';
comment on column bars_intgr.client_address.P_ZIP is '����. ���. ������';
comment on column bars_intgr.client_address.P_DOMAIN is '����. ���. �������';
comment on column bars_intgr.client_address.P_REGION is '����. ���. �����';
comment on column bars_intgr.client_address.P_LOCALITY is '����. ���. �����. �����';
comment on column bars_intgr.client_address.P_ADDRESS is '����. ���. ������';
comment on column bars_intgr.client_address.P_TERRITORY_ID is '����. ���. ��� ������';
comment on column bars_intgr.client_address.P_LOCALITY_TYPE is '����. ���. ��� ���. ������';
comment on column bars_intgr.client_address.P_STREET_TYPE is '����. ���. ��� ������';
comment on column bars_intgr.client_address.P_STREET is '����. ���. ������';
comment on column bars_intgr.client_address.P_HOME_TYPE is '����. ���. ��� �������';
comment on column bars_intgr.client_address.P_HOME is '����. ���. �������';
comment on column bars_intgr.client_address.P_HOMEPART_TYPE is '����. ���. ��� ������� �������';
comment on column bars_intgr.client_address.P_HOMEPART is '����. ���. ������� �������';
comment on column bars_intgr.client_address.P_ROOM_TYPE is '����. ���. ��� ����. �����.';
comment on column bars_intgr.client_address.P_ROOM is '����. ���. ����. �����.';
comment on column bars_intgr.client_address.P_KOATUU is '����. ���. ��� ������';
comment on column bars_intgr.client_address.P_REGION_ID is '����. ���. ��� ������';
comment on column bars_intgr.client_address.P_AREA_ID is '����. ���. ��� ������';
comment on column bars_intgr.client_address.P_SETTLEMENT_ID is '����. ���. ��� ���������� ������';
comment on column bars_intgr.client_address.P_STREET_ID is '����. ���. ��� ������';
comment on column bars_intgr.client_address.P_HOUSE_ID is '����. ���. ��� �������';


prompt create unique index XPK_CLIENT_ADDRESS

begin
    execute immediate 'create unique index XPK_CLIENT_ADDRESS on bars_intgr.client_address(KF, RNK) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

prompt create index I_CLIENT_ADDRESS_CHANGENUMBER

begin
    execute immediate 'create index I_CLIENT_ADDRESS_CHANGENUMBER on bars_intgr.client_address(KF, CHANGENUMBER) tablespace BRSDYNI local';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

prompt create error log
begin
    dbms_errlog.create_error_log(dml_table_name => 'CLIENT_ADDRESS', err_log_table_space => 'BRSDMIMP');
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

grant select on bars_intgr.client_address to IBMESB;