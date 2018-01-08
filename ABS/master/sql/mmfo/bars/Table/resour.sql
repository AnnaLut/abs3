

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RESOUR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RESOUR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RESOUR'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RESOUR'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''RESOUR'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RESOUR ***
begin 
  execute immediate '
  CREATE TABLE BARS.RESOUR 
   (	MFO VARCHAR2(12), 
	DATE_TIME DATE, 
	LIM_O NUMBER(24,0), 
	LIM_Z NUMBER(24,0), 
	LIM_R NUMBER(24,0), 
	RESERVE NUMBER(24,0), 
	SAD NUMBER(9,0), 
	SBD NUMBER(9,0), 
	SBK NUMBER(9,0), 
	NBD CHAR(27), 
	NBK CHAR(27), 
	SAK NUMBER(9,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RESOUR ***
 exec bpa.alter_policies('RESOUR');


COMMENT ON TABLE BARS.RESOUR IS 'Ресурсы банка';
COMMENT ON COLUMN BARS.RESOUR.MFO IS 'Код МФО банка';
COMMENT ON COLUMN BARS.RESOUR.DATE_TIME IS '';
COMMENT ON COLUMN BARS.RESOUR.LIM_O IS '';
COMMENT ON COLUMN BARS.RESOUR.LIM_Z IS '';
COMMENT ON COLUMN BARS.RESOUR.LIM_R IS '';
COMMENT ON COLUMN BARS.RESOUR.RESERVE IS '';
COMMENT ON COLUMN BARS.RESOUR.SAD IS '';
COMMENT ON COLUMN BARS.RESOUR.SBD IS '';
COMMENT ON COLUMN BARS.RESOUR.SBK IS '';
COMMENT ON COLUMN BARS.RESOUR.NBD IS '';
COMMENT ON COLUMN BARS.RESOUR.NBK IS '';
COMMENT ON COLUMN BARS.RESOUR.SAK IS '';
COMMENT ON COLUMN BARS.RESOUR.KF IS '';




PROMPT *** Create  constraint PK_RESOUR ***
begin   
 execute immediate '
  ALTER TABLE BARS.RESOUR ADD CONSTRAINT PK_RESOUR PRIMARY KEY (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RESOUR_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RESOUR MODIFY (MFO CONSTRAINT CC_RESOUR_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RESOUR_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RESOUR MODIFY (KF CONSTRAINT CC_RESOUR_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RESOUR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RESOUR ON BARS.RESOUR (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RESOUR ***
grant SELECT                                                                 on RESOUR          to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on RESOUR          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RESOUR          to BARS_DM;
grant SELECT                                                                 on RESOUR          to START1;
grant SELECT,UPDATE                                                          on RESOUR          to TOSS;
grant SELECT                                                                 on RESOUR          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RESOUR          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RESOUR.sql =========*** End *** ======
PROMPT ===================================================================================== 
