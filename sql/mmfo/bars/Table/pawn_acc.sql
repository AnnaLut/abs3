

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PAWN_ACC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PAWN_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PAWN_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PAWN_ACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PAWN_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PAWN_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.PAWN_ACC 
   (	ACC NUMBER(*,0), 
	PAWN NUMBER(*,0), 
	MPAWN NUMBER(*,0), 
	NREE VARCHAR2(45), 
	IDZ NUMBER(*,0), 
	NDZ NUMBER(*,0), 
	DEPOSIT_ID NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	SV NUMBER(38,0), 
	CC_IDZ VARCHAR2(20), 
	SDATZ DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PAWN_ACC ***
 exec bpa.alter_policies('PAWN_ACC');


COMMENT ON TABLE BARS.PAWN_ACC IS '���.��������� ������.��. �����������';
COMMENT ON COLUMN BARS.PAWN_ACC.NDZ IS '���.�������� ������, ���� �� �������.';
COMMENT ON COLUMN BARS.PAWN_ACC.DEPOSIT_ID IS '';
COMMENT ON COLUMN BARS.PAWN_ACC.KF IS '';
COMMENT ON COLUMN BARS.PAWN_ACC.SV IS '����������� ����i��� ������������ (� ���.)';
COMMENT ON COLUMN BARS.PAWN_ACC.CC_IDZ IS '����� �������� ������';
COMMENT ON COLUMN BARS.PAWN_ACC.SDATZ IS '���� �������� ������';
COMMENT ON COLUMN BARS.PAWN_ACC.ACC IS 'ACC ��.�����������';
COMMENT ON COLUMN BARS.PAWN_ACC.PAWN IS '��� �����������';
COMMENT ON COLUMN BARS.PAWN_ACC.MPAWN IS '����� ���.�����������';
COMMENT ON COLUMN BARS.PAWN_ACC.NREE IS '����� � ���������� �������';
COMMENT ON COLUMN BARS.PAWN_ACC.IDZ IS '����� ������������ ���-����������';




PROMPT *** Create  constraint XPK_PAWN_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAWN_ACC ADD CONSTRAINT XPK_PAWN_ACC PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_PAWN_ACC_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAWN_ACC MODIFY (ACC CONSTRAINT NK_PAWN_ACC_ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PAWNACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAWN_ACC MODIFY (KF CONSTRAINT CC_PAWNACC_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PAWN_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PAWN_ACC ON BARS.PAWN_ACC (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PAWN_ACC ***
grant SELECT                                                                 on PAWN_ACC        to BARSREADER_ROLE;
grant SELECT                                                                 on PAWN_ACC        to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on PAWN_ACC        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PAWN_ACC        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on PAWN_ACC        to RCC_DEAL;
grant SELECT                                                                 on PAWN_ACC        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PAWN_ACC        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PAWN_ACC.sql =========*** End *** ====
PROMPT ===================================================================================== 
