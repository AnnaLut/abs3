

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOS0QUE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOS0QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOS0QUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SOS0QUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SOS0QUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOS0QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOS0QUE 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	REF NUMBER(38,0), 
	 CONSTRAINT PK_SOS0QUE PRIMARY KEY (KF, REF) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOS0QUE ***
 exec bpa.alter_policies('SOS0QUE');


COMMENT ON TABLE BARS.SOS0QUE IS 'Очередь на фактическую доплату второй половины проводки';
COMMENT ON COLUMN BARS.SOS0QUE.KF IS '';
COMMENT ON COLUMN BARS.SOS0QUE.REF IS 'Референс проводки с sos0';




PROMPT *** Create  constraint CC_SOS0QUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS0QUE MODIFY (KF CONSTRAINT CC_SOS0QUE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOS0QUE_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS0QUE MODIFY (REF CONSTRAINT CC_SOS0QUE_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SOS0QUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS0QUE ADD CONSTRAINT PK_SOS0QUE PRIMARY KEY (KF, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SOS0QUE_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS0QUE ADD CONSTRAINT FK_SOS0QUE_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOS0QUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOS0QUE ON BARS.SOS0QUE (KF, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOS0QUE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOS0QUE         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOS0QUE.sql =========*** End *** =====
PROMPT ===================================================================================== 
