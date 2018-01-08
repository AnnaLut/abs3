

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF91.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF91 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF91'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF91'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF91'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF91 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF91 
   (	NLS VARCHAR2(15), 
	KV NUMBER, 
	RNK NUMBER, 
	NMS VARCHAR2(70), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF91 ***
 exec bpa.alter_policies('KF91');


COMMENT ON TABLE BARS.KF91 IS 'Рахунки, якi НЕ будуть виключенi в файл #91 i до Фонду гарантування';
COMMENT ON COLUMN BARS.KF91.KF IS '';
COMMENT ON COLUMN BARS.KF91.NLS IS '';
COMMENT ON COLUMN BARS.KF91.KV IS '';
COMMENT ON COLUMN BARS.KF91.RNK IS '';
COMMENT ON COLUMN BARS.KF91.NMS IS '';




PROMPT *** Create  constraint FK_KF91_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF91 ADD CONSTRAINT FK_KF91_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_KF91 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF91 ADD CONSTRAINT XPK_KF91 PRIMARY KEY (NLS, KV, RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KF91_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF91 MODIFY (KF CONSTRAINT CC_KF91_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005816 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF91 MODIFY (NLS NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005817 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF91 MODIFY (KV NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KF91 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KF91 ON BARS.KF91 (NLS, KV, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF91 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KF91            to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF91            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF91            to BARS_DM;
grant SELECT                                                                 on KF91            to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF91            to SALGL;
grant SELECT                                                                 on KF91            to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KF91            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF91.sql =========*** End *** ========
PROMPT ===================================================================================== 
