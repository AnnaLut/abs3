

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_LIM_COPY_BODY.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_LIM_COPY_BODY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_LIM_COPY_BODY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_LIM_COPY_BODY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_LIM_COPY_BODY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_LIM_COPY_BODY ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_LIM_COPY_BODY 
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
	NOT_SN NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_LIM_COPY_BODY ***
 exec bpa.alter_policies('CC_LIM_COPY_BODY');


COMMENT ON TABLE BARS.CC_LIM_COPY_BODY IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_BODY.ID IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_BODY.ND IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_BODY.FDAT IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_BODY.LIM2 IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_BODY.ACC IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_BODY.NOT_9129 IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_BODY.SUMG IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_BODY.SUMO IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_BODY.OTM IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_BODY.KF IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_BODY.SUMK IS '';
COMMENT ON COLUMN BARS.CC_LIM_COPY_BODY.NOT_SN IS '';




PROMPT *** Create  constraint SYS_C00136941 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_LIM_COPY_BODY MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CC_LIM_COPY_ID ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CC_LIM_COPY_ID ON BARS.CC_LIM_COPY_BODY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_LIM_COPY_BODY ***
grant SELECT                                                                 on CC_LIM_COPY_BODY to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CC_LIM_COPY_BODY to BARSREADER_ROLE;
grant SELECT                                                                 on CC_LIM_COPY_BODY to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_LIM_COPY_BODY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_LIM_COPY_BODY to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_LIM_COPY_BODY to FOREX;
grant SELECT                                                                 on CC_LIM_COPY_BODY to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_LIM_COPY_BODY to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_LIM_COPY_BODY to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on CC_LIM_COPY_BODY to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_LIM_COPY_BODY.sql =========*** End 
PROMPT ===================================================================================== 
