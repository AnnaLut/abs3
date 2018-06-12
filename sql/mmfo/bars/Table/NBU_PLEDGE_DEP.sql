BEGIN
    bpa.alter_policy_info('NBU_PLEDGE_DEP', 'FILIAL', 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_PLEDGE_DEP', 'WHOLE', null, 'E', 'E', 'E');
END;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin 
    execute immediate
    'CREATE TABLE BARS.NBU_PLEDGE_DEP 
    (
        rnk                 NUMBER(38),
        acc                 NUMBER(38),
        ordernum            NUMBER(2),
        numberpledge        VARCHAR2(30),
        pledgeday           DATE,
        s031                VARCHAR2(2),
        r030                VARCHAR2(3),
        sumpledge           NUMBER(32),
        pricepledge         NUMBER(32),
        lastpledgeday       DATE,
        codrealty           NUMBER(1),
        ziprealty           VARCHAR2(10),
        squarerealty        NUMBER(16,4),
        real6income         NUMBER(32),
        noreal6income       NUMBER(32),
        flaginsurancepledge NUMBER(1),
        numdogdp            VARCHAR2(50),
        dogdaydp            DATE,
        r030dp              VARCHAR2(3),
        sumdp               NUMBER(32),
        status              VARCHAR2(30),
	status_message 		VARCHAR2(4000),
        kf                  VARCHAR2(6)
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_PLEDGE_DEP_304665 values (304665),
       partition NBU_PLEDGE_DEP_338545 values (338545),
       partition NBU_PLEDGE_DEP_305482 values (305482),
       partition NBU_PLEDGE_DEP_356334 values (356334),
       partition NBU_PLEDGE_DEP_326461 values (326461),
       partition NBU_PLEDGE_DEP_354507 values (354507),
       partition NBU_PLEDGE_DEP_322669 values (322669),
       partition NBU_PLEDGE_DEP_323475 values (323475),
       partition NBU_PLEDGE_DEP_353553 values (353553),
       partition NBU_PLEDGE_DEP_312356 values (312356),
       partition NBU_PLEDGE_DEP_302076 values (302076),
       partition NBU_PLEDGE_DEP_328845 values (328845),
       partition NBU_PLEDGE_DEP_335106 values (335106),
       partition NBU_PLEDGE_DEP_311647 values (311647),
       partition NBU_PLEDGE_DEP_352457 values (352457),
       partition NBU_PLEDGE_DEP_333368 values (333368),
       partition NBU_PLEDGE_DEP_325796 values (325796),
       partition NBU_PLEDGE_DEP_313957 values (313957),
       partition NBU_PLEDGE_DEP_336503 values (336503),
       partition NBU_PLEDGE_DEP_303398 values (303398),
       partition NBU_PLEDGE_DEP_331467 values (331467),
       partition NBU_PLEDGE_DEP_351823 values (351823),
       partition NBU_PLEDGE_DEP_337568 values (337568),
       partition NBU_PLEDGE_DEP_315784 values (315784),
       partition NBU_PLEDGE_DEP_324805 values (324805),
       partition NBU_PLEDGE_DEP_300465 values (300465)
    )';
exception
    when name_already_used then
         null;
end;
/

COMMENT ON TABLE BARS.NBU_PLEDGE_DEP IS '������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.rnk IS '��������������� �����.';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.acc IS 'ACC ��.�����������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.ordernum IS '���������� �����  ������ � ���������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.numberpledge IS '����� �������� �������/�������, ������, ������, ��������� ��������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.pledgeday IS '���� ��������� �������� �������/�������, ������, ������, ��������� ��������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.s031 IS '��� ���� ������������ �� ���������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.r030 IS '��� ������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.sumpledge IS '���� ������������ ����� � ���������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.pricepledge IS '������� ������������ ����� � ��������� ��ᒺ��� �������� ��������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.lastpledgeday IS '���� �������� ������ ������������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.codrealty IS '��� ���������� �����';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.ziprealty IS '�������� ������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.squarerealty IS '�������� ����� ���������� �����';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.real6income IS '������� ������������ ����� �����, �� ������ ��������� ������ (�������)';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.noreal6income IS '���������� �������������� ����� �����, �� ������ ��������� ������ (�������)';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.flaginsurancepledge IS '���� �����������  ������������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.numdogdp IS '����� ����������� ��������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.dogdaydp IS '���� ��������� ����������� ��������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.r030dp IS '��� ������ �� ���������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.sumdp IS '���� ��������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.status IS '������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.status_message IS '������ �������';
COMMENT ON COLUMN BARS.NBU_PLEDGE_DEP.kf IS '��� �������';

exec bpa.alter_policies('NBU_PLEDGE_DEP');

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index UI_NBU_PLEDGE_DEP on NBU_PLEDGE_DEP (KF, ACC) TABLESPACE BRSMDLI local';
exception
    when name_already_used then
         null;
end;
/

begin 
execute immediate 'alter table NBU_PLEDGE_DEP add sumBail NUMBER(32)'; 
exception 
	when others then if sqlcode=-955 then null; end if;
end;
/	

begin 
execute immediate 'alter table NBU_PLEDGE_DEP add sumGuarantee NUMBER(32)'; 
exception 
	when others then if sqlcode=-955 then null; end if;
end;
/	
grant all on NBU_PLEDGE_DEP to BARS_ACCESS_DEFROLE;