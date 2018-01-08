

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/T902.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to T902 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''T902'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''T902'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''T902'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table T902 ***
begin 
  execute immediate '
  CREATE TABLE BARS.T902 
   (	REF NUMBER(38,0), 
	REC NUMBER, 
	OTM NUMBER DEFAULT 0, 
	DAT DATE, 
	REC_O NUMBER, 
	S NUMBER(24,0), 
	STMP DATE DEFAULT SYSDATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BLK NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to T902 ***
 exec bpa.alter_policies('T902');


COMMENT ON TABLE BARS.T902 IS '';
COMMENT ON COLUMN BARS.T902.REF IS '';
COMMENT ON COLUMN BARS.T902.REC IS '';
COMMENT ON COLUMN BARS.T902.OTM IS 'Состояние документа на SUSPENSE';
COMMENT ON COLUMN BARS.T902.DAT IS 'Дата изменения состояния';
COMMENT ON COLUMN BARS.T902.REC_O IS 'Номер записи ответа';
COMMENT ON COLUMN BARS.T902.S IS '';
COMMENT ON COLUMN BARS.T902.STMP IS '';
COMMENT ON COLUMN BARS.T902.KF IS '';
COMMENT ON COLUMN BARS.T902.BLK IS 'Код причины помещения';




PROMPT *** Create  constraint XAK_T902 ***
begin   
 execute immediate '
  ALTER TABLE BARS.T902 ADD CONSTRAINT XAK_T902 UNIQUE (REC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_T902 ***
begin   
 execute immediate '
  ALTER TABLE BARS.T902 ADD CONSTRAINT PK_T902 PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_T902_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.T902 ADD CONSTRAINT FK_T902_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007336 ***
begin   
 execute immediate '
  ALTER TABLE BARS.T902 MODIFY (REF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_T902_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.T902 MODIFY (KF CONSTRAINT CC_T902_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_T902 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_T902 ON BARS.T902 (REC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_T902 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_T902 ON BARS.T902 (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  T902 ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on T902            to BARS014;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on T902            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on T902            to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on T902            to PYOD001;
grant SELECT                                                                 on T902            to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on T902            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/T902.sql =========*** End *** ========
PROMPT ===================================================================================== 
