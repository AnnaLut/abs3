

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLPVACC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLPVACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLPVACC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLPVACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLPVACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLPVACC 
   (	ACC NUMBER, 
	NEOM NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLPVACC ***
 exec bpa.alter_policies('KLPVACC');


COMMENT ON TABLE BARS.KLPVACC IS '';
COMMENT ON COLUMN BARS.KLPVACC.ACC IS 'Внутренний номер счета';
COMMENT ON COLUMN BARS.KLPVACC.NEOM IS '';
COMMENT ON COLUMN BARS.KLPVACC.KF IS '';




PROMPT *** Create  constraint FK_KLPVACC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPVACC ADD CONSTRAINT FK_KLPVACC_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPVACC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPVACC ADD CONSTRAINT FK_KLPVACC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_STAFF_KLPVACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPVACC ADD CONSTRAINT R_STAFF_KLPVACC FOREIGN KEY (NEOM)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_KLPVACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPVACC ADD CONSTRAINT XPK_KLPVACC PRIMARY KEY (ACC, NEOM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPVACC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPVACC MODIFY (KF CONSTRAINT CC_KLPVACC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XFK_ACC_KLPVACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.XFK_ACC_KLPVACC ON BARS.KLPVACC (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XFK_NEOM_KLPVACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.XFK_NEOM_KLPVACC ON BARS.KLPVACC (NEOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KLPVACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KLPVACC ON BARS.KLPVACC (ACC, NEOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLPVACC ***
grant SELECT                                                                 on KLPVACC         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLPVACC         to START1;
grant SELECT                                                                 on KLPVACC         to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLPVACC         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KLPVACC ***

  CREATE OR REPLACE PUBLIC SYNONYM KLPVACC FOR BARS.KLPVACC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLPVACC.sql =========*** End *** =====
PROMPT ===================================================================================== 
