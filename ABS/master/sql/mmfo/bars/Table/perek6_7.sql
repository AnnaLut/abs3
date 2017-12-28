

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PEREK6_7.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PEREK6_7 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PEREK6_7'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PEREK6_7'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PEREK6_7'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PEREK6_7 ***
begin 
  execute immediate '
  CREATE TABLE BARS.PEREK6_7 
   (	NLSA VARCHAR2(15), 
	NLSB VARCHAR2(15), 
	NAZN VARCHAR2(160), 
	TXT VARCHAR2(70), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	TOBO VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PEREK6_7 ***
 exec bpa.alter_policies('PEREK6_7');


COMMENT ON TABLE BARS.PEREK6_7 IS '';
COMMENT ON COLUMN BARS.PEREK6_7.NLSA IS '';
COMMENT ON COLUMN BARS.PEREK6_7.NLSB IS '';
COMMENT ON COLUMN BARS.PEREK6_7.NAZN IS '';
COMMENT ON COLUMN BARS.PEREK6_7.TXT IS '';
COMMENT ON COLUMN BARS.PEREK6_7.KF IS '';
COMMENT ON COLUMN BARS.PEREK6_7.TOBO IS '';




PROMPT *** Create  constraint FK_PEREK67_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREK6_7 ADD CONSTRAINT FK_PEREK67_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009829 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREK6_7 MODIFY (NLSA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009830 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREK6_7 MODIFY (NLSB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREK67_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREK6_7 MODIFY (KF CONSTRAINT CC_PEREK67_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_PEREK6_7 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREK6_7 ADD CONSTRAINT XPK_PEREK6_7 PRIMARY KEY (NLSA, NLSB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PEREK6_7 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PEREK6_7 ON BARS.PEREK6_7 (NLSA, NLSB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PEREK6_7 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREK6_7        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREK6_7        to PEREK6_7;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREK6_7        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PEREK6_7        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PEREK6_7.sql =========*** End *** ====
PROMPT ===================================================================================== 
