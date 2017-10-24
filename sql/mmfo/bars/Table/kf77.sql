

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF77.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF77 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF77'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF77'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF77'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF77 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF77 
   (	RNK NUMBER, 
	NMK VARCHAR2(70), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF77 ***
 exec bpa.alter_policies('KF77');


COMMENT ON TABLE BARS.KF77 IS 'Контрагенти ФО, якi НЕ будуть виключенi до Фонду гарантування';
COMMENT ON COLUMN BARS.KF77.KF IS '';
COMMENT ON COLUMN BARS.KF77.RNK IS '';
COMMENT ON COLUMN BARS.KF77.NMK IS '';




PROMPT *** Create  constraint FK_KF77_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF77 ADD CONSTRAINT FK_KF77_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005129 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF77 MODIFY (RNK NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KF77_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF77 MODIFY (KF CONSTRAINT CC_KF77_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_KF77 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF77 ADD CONSTRAINT XPK_KF77 PRIMARY KEY (RNK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KF77 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KF77 ON BARS.KF77 (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF77 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KF77            to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KF77            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF77            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF77            to KF77;
grant SELECT                                                                 on KF77            to PYOD001;
grant SELECT                                                                 on KF77            to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF77            to SALGL;
grant SELECT                                                                 on KF77            to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KF77            to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KF77            to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF77.sql =========*** End *** ========
PROMPT ===================================================================================== 
