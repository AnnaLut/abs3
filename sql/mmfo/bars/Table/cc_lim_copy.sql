

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_LIM_COPY.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_LIM_COPY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_LIM_COPY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_LIM_COPY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_LIM_COPY'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_LIM_COPY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_LIM_COPY 
   (	ID NUMBER, 
	ND NUMBER(38,0), 
	FDAT DATE, 
	LIM2 NUMBER(38,0), 
	ACC NUMBER(*,0), 
	NOT_9129 NUMBER(*,0), 
	SUMG NUMBER(38,0), 
	SUMO NUMBER(38,0), 
	OTM NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	SUMK NUMBER, 
	NOT_SN NUMBER(*,0), 
	OPER_DATE DATE DEFAULT sysdate, 
	USERID NUMBER DEFAULT sys_context(''userenv'', ''session_userid''), 
	COMMENTS VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_LIM_COPY ***
 exec bpa.alter_policies('CC_LIM_COPY');


COMMENT ON TABLE BARS.CC_LIM_COPY IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.ID IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.ND IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.FDAT IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.LIM2 IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.ACC IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.NOT_9129 IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.SUMG IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.SUMO IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.OTM IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.KF IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.SUMK IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.NOT_SN IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.OPER_DATE IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.USERID IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY.COMMENTS IS '';




PROMPT *** Create  constraint SYS_C00132479 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY MODIFY (USERID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CC_LIM_COPY ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY ADD CONSTRAINT PK_CC_LIM_COPY PRIMARY KEY (ID, ND, OPER_DATE, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132474 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132475 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY MODIFY (ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132476 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132477 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132478 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY MODIFY (OPER_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_LIM_COPY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_LIM_COPY ON BARS.CC_LIM_COPY (ID, ND, OPER_DATE, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_LIM_COPY ***
grant SELECT                                                                 on CC_LIM_COPY     to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CC_LIM_COPY     to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_LIM_COPY     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_LIM_COPY     to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_LIM_COPY     to FOREX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_LIM_COPY     to RCC_DEAL;
grant SELECT                                                                 on CC_LIM_COPY     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_LIM_COPY     to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_LIM_COPY     to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on CC_LIM_COPY     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_LIM_COPY.sql =========*** End *** =
PROMPT ===================================================================================== 
