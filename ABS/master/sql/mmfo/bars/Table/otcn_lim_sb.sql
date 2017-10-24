

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_LIM_SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_LIM_SB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_LIM_SB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_LIM_SB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_LIM_SB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_LIM_SB ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_LIM_SB 
   (	ACC NUMBER, 
	FDAT DATE, 
	LIM NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_LIM_SB ***
 exec bpa.alter_policies('OTCN_LIM_SB');


COMMENT ON TABLE BARS.OTCN_LIM_SB IS '';
COMMENT ON COLUMN BARS.OTCN_LIM_SB.KF IS '';
COMMENT ON COLUMN BARS.OTCN_LIM_SB.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_LIM_SB.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_LIM_SB.LIM IS '';




PROMPT *** Create  constraint CC_OTCNLIMSB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LIM_SB MODIFY (KF CONSTRAINT CC_OTCNLIMSB_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OTCNLIMSB_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LIM_SB ADD CONSTRAINT FK_OTCNLIMSB_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OTCN_LIM_SB ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LIM_SB ADD CONSTRAINT PK_OTCN_LIM_SB PRIMARY KEY (ACC, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005761 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LIM_SB MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005762 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_LIM_SB MODIFY (FDAT NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTCN_LIM_SB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTCN_LIM_SB ON BARS.OTCN_LIM_SB (ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_LIM_SB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_LIM_SB     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_LIM_SB     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_LIM_SB.sql =========*** End *** =
PROMPT ===================================================================================== 
