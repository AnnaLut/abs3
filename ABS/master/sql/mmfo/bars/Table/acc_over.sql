

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_OVER'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACC_OVER'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER 
   (	ACC NUMBER(*,0), 
	ACCO NUMBER(*,0), 
	TIPO NUMBER(*,0), 
	FLAG NUMBER(*,0), 
	ND NUMBER, 
	DAY NUMBER(*,0), 
	SOS NUMBER(*,0), 
	DATD DATE, 
	SD NUMBER(24,0), 
	NDOC VARCHAR2(30), 
	VIDD NUMBER, 
	DATD2 DATE, 
	KRL NUMBER DEFAULT 0, 
	USEOSTF NUMBER DEFAULT 0, 
	USELIM NUMBER DEFAULT 0, 
	ACC_9129 NUMBER(*,0), 
	ACC_8000 NUMBER(*,0), 
	OBS NUMBER(*,0), 
	TXT VARCHAR2(100), 
	USERID NUMBER, 
	DELETED NUMBER DEFAULT 0, 
	PR_2600A NUMBER DEFAULT 0, 
	PR_KOMIS NUMBER DEFAULT 0, 
	PR_9129 NUMBER DEFAULT 0, 
	PR_2069 NUMBER DEFAULT 0, 
	ACC_2067 NUMBER DEFAULT 0, 
	ACC_2069 NUMBER DEFAULT 0, 
	ACC_2096 NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ACC_3739 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	K23 NUMBER, 
	FIN NUMBER(*,0), 
	ACC_3600 NUMBER(*,0), 
	S_3600 NUMBER(24,0), 
	FLAG_3600 NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_OVER ***
 exec bpa.alter_policies('ACC_OVER');


COMMENT ON TABLE BARS.ACC_OVER IS '';
COMMENT ON COLUMN BARS.ACC_OVER.ACC IS '';
COMMENT ON COLUMN BARS.ACC_OVER.ACCO IS '';
COMMENT ON COLUMN BARS.ACC_OVER.TIPO IS '';
COMMENT ON COLUMN BARS.ACC_OVER.FLAG IS '';
COMMENT ON COLUMN BARS.ACC_OVER.ND IS '';
COMMENT ON COLUMN BARS.ACC_OVER.DAY IS '';
COMMENT ON COLUMN BARS.ACC_OVER.SOS IS '';
COMMENT ON COLUMN BARS.ACC_OVER.DATD IS '';
COMMENT ON COLUMN BARS.ACC_OVER.SD IS '';
COMMENT ON COLUMN BARS.ACC_OVER.NDOC IS '';
COMMENT ON COLUMN BARS.ACC_OVER.VIDD IS '';
COMMENT ON COLUMN BARS.ACC_OVER.DATD2 IS '';
COMMENT ON COLUMN BARS.ACC_OVER.KRL IS '';
COMMENT ON COLUMN BARS.ACC_OVER.USEOSTF IS '';
COMMENT ON COLUMN BARS.ACC_OVER.USELIM IS '';
COMMENT ON COLUMN BARS.ACC_OVER.ACC_9129 IS '';
COMMENT ON COLUMN BARS.ACC_OVER.ACC_8000 IS '';
COMMENT ON COLUMN BARS.ACC_OVER.OBS IS '';
COMMENT ON COLUMN BARS.ACC_OVER.TXT IS '';
COMMENT ON COLUMN BARS.ACC_OVER.USERID IS '';
COMMENT ON COLUMN BARS.ACC_OVER.DELETED IS '';
COMMENT ON COLUMN BARS.ACC_OVER.PR_2600A IS '';
COMMENT ON COLUMN BARS.ACC_OVER.PR_KOMIS IS '';
COMMENT ON COLUMN BARS.ACC_OVER.PR_9129 IS '';
COMMENT ON COLUMN BARS.ACC_OVER.PR_2069 IS '';
COMMENT ON COLUMN BARS.ACC_OVER.ACC_2067 IS '';
COMMENT ON COLUMN BARS.ACC_OVER.ACC_2069 IS '';
COMMENT ON COLUMN BARS.ACC_OVER.ACC_2096 IS '';
COMMENT ON COLUMN BARS.ACC_OVER.KF IS '';
COMMENT ON COLUMN BARS.ACC_OVER.ACC_3739 IS 'Счет гашения';
COMMENT ON COLUMN BARS.ACC_OVER.KAT23 IS 'Категорiя якостi за кредитом по НБУ-23';
COMMENT ON COLUMN BARS.ACC_OVER.FIN23 IS 'ФiнКлас по НБУ-23';
COMMENT ON COLUMN BARS.ACC_OVER.OBS23 IS 'Обсл.долга по НБУ-23';
COMMENT ON COLUMN BARS.ACC_OVER.K23 IS 'Коеф.Показник ризику по НБУ-23';
COMMENT ON COLUMN BARS.ACC_OVER.FIN IS '';
COMMENT ON COLUMN BARS.ACC_OVER.ACC_3600 IS '';
COMMENT ON COLUMN BARS.ACC_OVER.S_3600 IS '';
COMMENT ON COLUMN BARS.ACC_OVER.FLAG_3600 IS '';




PROMPT *** Create  constraint XPK_ACC_OVER ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER ADD CONSTRAINT XPK_ACC_OVER PRIMARY KEY (ACC, ACCO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ACC_OVER_DELETED ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER MODIFY (DELETED CONSTRAINT NK_ACC_OVER_DELETED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ACC_OVER_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER MODIFY (ACC CONSTRAINT NK_ACC_OVER_ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ACC_OVER_ACCO ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER MODIFY (ACCO CONSTRAINT NK_ACC_OVER_ACCO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ACC_OVER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ACC_OVER ON BARS.ACC_OVER (ACC, ACCO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_OVER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER        to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER        to BARS009;
grant SELECT                                                                 on ACC_OVER        to BARSREADER_ROLE;
grant SELECT                                                                 on ACC_OVER        to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_OVER        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_OVER        to BARS_DM;
grant SELECT                                                                 on ACC_OVER        to CC_DOC;
grant SELECT                                                                 on ACC_OVER        to RCC_DEAL;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER        to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER        to TECH006;
grant SELECT                                                                 on ACC_OVER        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_OVER        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ACC_OVER        to WR_REFREAD;



PROMPT *** Create SYNONYM  to ACC_OVER ***

  CREATE OR REPLACE PUBLIC SYNONYM ACC_OVER FOR BARS.ACC_OVER;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER.sql =========*** End *** ====
PROMPT ===================================================================================== 
