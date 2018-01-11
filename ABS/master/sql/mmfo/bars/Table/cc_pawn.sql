

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_PAWN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_PAWN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_PAWN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_PAWN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_PAWN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_PAWN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_PAWN 
   (	PAWN NUMBER(38,0), 
	NAME VARCHAR2(250), 
	PR_REZ NUMBER(10,2), 
	NBSZ CHAR(4), 
	NBSZ1 CHAR(4), 
	NBSZ2 CHAR(4), 
	NBSZ3 CHAR(4), 
	S031 VARCHAR2(2), 
	KAT NUMBER(*,0), 
	D_CLOSE DATE DEFAULT null, 
	CODE VARCHAR2(20), 
	S031_279 VARCHAR2(2), 
	NAME_279 VARCHAR2(70), 
	PAWN_23 NUMBER, 
	GRP23 NUMBER(*,0), 
	OB22_FO CHAR(2), 
	OB22_UO CHAR(2), 
	OB22_U0 CHAR(2), 
	NAME_351 VARCHAR2(500), 
	KOD_351 VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_PAWN ***
 exec bpa.alter_policies('CC_PAWN');


COMMENT ON TABLE BARS.CC_PAWN IS '���� �����������';
COMMENT ON COLUMN BARS.CC_PAWN.NAME_351 IS '������������ ���� ������������ ����� ����.�351';
COMMENT ON COLUMN BARS.CC_PAWN.KOD_351 IS '��� ���� ������������ ����� ����.�351';
COMMENT ON COLUMN BARS.CC_PAWN.PAWN IS '��� ���� ����������� (���������� ����� ���������� �� ���� ���)';
COMMENT ON COLUMN BARS.CC_PAWN.NAME IS '������������ ���� ����������';
COMMENT ON COLUMN BARS.CC_PAWN.PR_REZ IS '�� ������������';
COMMENT ON COLUMN BARS.CC_PAWN.NBSZ IS '���������� ���� ������ 1 (��� ����������� ������ ������ � ��������� ��������)';
COMMENT ON COLUMN BARS.CC_PAWN.NBSZ1 IS '���������� ���� ������ 2 (��� ����������� ������ ������ � ��������� ��������)';
COMMENT ON COLUMN BARS.CC_PAWN.NBSZ2 IS '���������� ���� ������ 3 (��� ����������� ������ ������ � ��������� ��������)';
COMMENT ON COLUMN BARS.CC_PAWN.NBSZ3 IS '���������� ���� ������ 4 (��� ����������� ������ ������ � ��������� ��������)';
COMMENT ON COLUMN BARS.CC_PAWN.S031 IS '��� ���� ������ �� ������������� ���';
COMMENT ON COLUMN BARS.CC_PAWN.KAT IS '';
COMMENT ON COLUMN BARS.CC_PAWN.D_CLOSE IS '';
COMMENT ON COLUMN BARS.CC_PAWN.CODE IS '���������� ���';
COMMENT ON COLUMN BARS.CC_PAWN.S031_279 IS '';
COMMENT ON COLUMN BARS.CC_PAWN.NAME_279 IS '';
COMMENT ON COLUMN BARS.CC_PAWN.PAWN_23 IS '';
COMMENT ON COLUMN BARS.CC_PAWN.GRP23 IS '';
COMMENT ON COLUMN BARS.CC_PAWN.OB22_FO IS '�������� ��22 ��� ��';
COMMENT ON COLUMN BARS.CC_PAWN.OB22_UO IS '�������� ��22 ��� ��';
COMMENT ON COLUMN BARS.CC_PAWN.OB22_U0 IS '';




PROMPT *** Create  constraint XPK_CC_PAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN ADD CONSTRAINT XPK_CC_PAWN PRIMARY KEY (PAWN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_PAWN_PAWN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN MODIFY (PAWN CONSTRAINT NK_CC_PAWN_PAWN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_PAWN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_PAWN ON BARS.CC_PAWN (PAWN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_PAWN ***
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_PAWN         to BARS009;
grant SELECT                                                                 on CC_PAWN         to BARSREADER_ROLE;
grant SELECT                                                                 on CC_PAWN         to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_PAWN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_PAWN         to BARS_DM;
grant SELECT                                                                 on CC_PAWN         to FOREX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_PAWN         to RCC_DEAL;
grant SELECT                                                                 on CC_PAWN         to RPBN001;
grant INSERT,SELECT,UPDATE                                                   on CC_PAWN         to START1;
grant SELECT                                                                 on CC_PAWN         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_PAWN         to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_PAWN         to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on CC_PAWN         to WR_REFREAD;



PROMPT *** Create SYNONYM  to CC_PAWN ***

  CREATE OR REPLACE PUBLIC SYNONYM CC_PAWN FOR BARS.CC_PAWN;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_PAWN.sql =========*** End *** =====
PROMPT ===================================================================================== 
