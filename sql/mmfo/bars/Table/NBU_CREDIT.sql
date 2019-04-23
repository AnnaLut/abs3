BEGIN 
    bpa.alter_policy_info('NBU_CREDIT', 'FILIAL' , 'M', 'M', 'M', 'M');
    bpa.alter_policy_info('NBU_CREDIT', 'WHOLE' , null, 'E', 'E', 'E');
END; 
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin 
    execute immediate
    'CREATE TABLE BARS.NBU_CREDIT
    (
        rnk        NUMBER(38),
        nd         NUMBER(30),
        orderNum   NUMBER(2),
        flagOsoba  VARCHAR2(5),
        typeCredit NUMBER(2), 
        numdog   VARCHAR2(50),
        dogday   DATE,
        endDay     DATE,
        sumZagal   NUMBER(32),
        r030       VARCHAR2(3),
        procCredit NUMBER(5,2),
        sumPay     NUMBER(32),
        periodBase NUMBER(1),
        periodProc NUMBER(1),
        sumArrears NUMBER(32),
        arrearBase NUMBER(32),
        arrearProc NUMBER(32),
        dayBase    NUMBER(5),
        dayProc    NUMBER(5),
        factEndDay DATE,
        flagZ      VARCHAR2(5),
        klass      VARCHAR2(2),
        risk       NUMBER(32),
        flagInsurance VARCHAR2(5),  
        status     VARCHAR2(30),
	status_message VARCHAR(4000),
        kf         VARCHAR2(6) 
    )
    TABLESPACE BRSMDLD
    partition by list (kf)
    (
       partition NBU_CREDIT_304665 values (304665),
       partition NBU_CREDIT_338545 values (338545),
       partition NBU_CREDIT_305482 values (305482),
       partition NBU_CREDIT_356334 values (356334),
       partition NBU_CREDIT_326461 values (326461),
       partition NBU_CREDIT_354507 values (354507),
       partition NBU_CREDIT_322669 values (322669),
       partition NBU_CREDIT_323475 values (323475),
       partition NBU_CREDIT_353553 values (353553),
       partition NBU_CREDIT_312356 values (312356),
       partition NBU_CREDIT_302076 values (302076),
       partition NBU_CREDIT_328845 values (328845),
       partition NBU_CREDIT_335106 values (335106),
       partition NBU_CREDIT_311647 values (311647),
       partition NBU_CREDIT_352457 values (352457),
       partition NBU_CREDIT_333368 values (333368),
       partition NBU_CREDIT_325796 values (325796),
       partition NBU_CREDIT_313957 values (313957),
       partition NBU_CREDIT_336503 values (336503),
       partition NBU_CREDIT_303398 values (303398),
       partition NBU_CREDIT_331467 values (331467),
       partition NBU_CREDIT_351823 values (351823),
       partition NBU_CREDIT_337568 values (337568),
       partition NBU_CREDIT_315784 values (315784),
       partition NBU_CREDIT_324805 values (324805),
       partition NBU_CREDIT_300465 values (300465)
    )';
exception
    when name_already_used then
         null;
end; 
/

COMMENT ON TABLE BARS.NBU_CREDIT IS '������� ��������';
COMMENT ON COLUMN BARS.NBU_CREDIT.rnk IS '��������������� �����.';
COMMENT ON COLUMN BARS.NBU_CREDIT.nd IS '������ �����';
COMMENT ON COLUMN BARS.NBU_CREDIT.ordernum IS '���������� ����� �������� �������� � ���������';
COMMENT ON COLUMN BARS.NBU_CREDIT.flagOsoba IS '������ �����';
COMMENT ON COLUMN BARS.NBU_CREDIT.typeCredit IS '��� �������/�������� ����������� �����������';
COMMENT ON COLUMN BARS.NBU_CREDIT.numdog IS '����� ��������';
COMMENT ON COLUMN BARS.NBU_CREDIT.dogday IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.NBU_CREDIT.endDay IS 'ʳ����� ���� ��������� �������/�������� ����������� �����������';
COMMENT ON COLUMN BARS.NBU_CREDIT.sumZagal IS '�������� ���� (��� �������� ��/����������) �������� ����������� �����������';
COMMENT ON COLUMN BARS.NBU_CREDIT.r030 IS '��� ������';
COMMENT ON COLUMN BARS.NBU_CREDIT.procCredit IS '��������� ��������� ������';
COMMENT ON COLUMN BARS.NBU_CREDIT.sumPay IS '���� ������� �� ��������� ���������';
COMMENT ON COLUMN BARS.NBU_CREDIT.periodBase IS '����������� ������ ��������� �����';
COMMENT ON COLUMN BARS.NBU_CREDIT.periodProc IS '����������� ������ �������';
COMMENT ON COLUMN BARS.NBU_CREDIT.sumArrears IS '������� ������������� �� ��������� ���������';
COMMENT ON COLUMN BARS.NBU_CREDIT.arrearBase IS '����������� ������������� �� �������� ������';
COMMENT ON COLUMN BARS.NBU_CREDIT.arrearProc IS '����������� �������������  �� ����������';
COMMENT ON COLUMN BARS.NBU_CREDIT.dayBase IS 'ʳ������ ��� ������������ �� �������� ������';
COMMENT ON COLUMN BARS.NBU_CREDIT.dayProc IS 'ʳ������ ��� ������������  �� ����������';
COMMENT ON COLUMN BARS.NBU_CREDIT.factEndDay IS '���� ���������� ��������� �������';
COMMENT ON COLUMN BARS.NBU_CREDIT.flagZ IS '�������� ��������� ������ �� ����������� ��������� �����';
COMMENT ON COLUMN BARS.NBU_CREDIT.klass IS '���� ��������';
COMMENT ON COLUMN BARS.NBU_CREDIT.risk IS '�������� ���������� ������';
COMMENT ON COLUMN BARS.NBU_CREDIT.flagInsurance IS '���� �����������  �������';
COMMENT ON COLUMN BARS.NBU_CREDIT.status IS '������';
COMMENT ON COLUMN BARS.NBU_CREDIT.status_message IS '������ �������';
COMMENT ON COLUMN BARS.NBU_CREDIT.kf IS '��� �������';

exec bpa.alter_policies('NBU_CREDIT');

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index NBU_CREDIT_PK on NBU_CREDIT (KF, ND) TABLESPACE BRSMDLI local';
exception
    when name_already_used then
         null;
end;
/

begin   
   execute immediate 'alter table NBU_CREDIT add vidd INTEGER';
     exception when others then 
       if sqlcode=-955 then null; end if; 
end;
/

grant all on NBU_CREDIT to BARS_ACCESS_DEFROLE;