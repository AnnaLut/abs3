

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_TT.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_TT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_TT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_TT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_TT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_TT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_TT 
   (	TIP NUMBER(*,0), 
	KV NUMBER(*,0), 
	REZ NUMBER(*,0), 
	TT VARCHAR2(3), 
	ISIN VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_TT ***
 exec bpa.alter_policies('CP_TT');


COMMENT ON TABLE BARS.CP_TT IS 'Дов_дник авт. п_дбору операц_й';
COMMENT ON COLUMN BARS.CP_TT.TIP IS 'Чуж_ ЦП чи власної ем_с_ї';
COMMENT ON COLUMN BARS.CP_TT.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.CP_TT.REZ IS 'Резидент';
COMMENT ON COLUMN BARS.CP_TT.TT IS 'Код операц_ї';
COMMENT ON COLUMN BARS.CP_TT.ISIN IS 'substr(ISIN,1,2) ';




PROMPT *** Create  constraint XPK_CP_TT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TT ADD CONSTRAINT XPK_CP_TT PRIMARY KEY (TIP, KV, REZ)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_TIP_CPTT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TT ADD CONSTRAINT R_TIP_CPTT FOREIGN KEY (TIP)
	  REFERENCES BARS.CC_TIPD (TIPD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006069 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TT MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006070 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TT MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006071 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_TT MODIFY (REZ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_TT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_TT ON BARS.CP_TT (TIP, KV, REZ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_TT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_TT           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_TT           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_TT           to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_TT           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_TT.sql =========*** End *** =======
PROMPT ===================================================================================== 
