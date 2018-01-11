

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RAZ_KOM.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RAZ_KOM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RAZ_KOM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RAZ_KOM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RAZ_KOM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RAZ_KOM ***
begin 
  execute immediate '
  CREATE TABLE BARS.RAZ_KOM 
   (	KOD CHAR(6), 
	PDV NUMBER(*,0) DEFAULT 0, 
	UO NUMBER(*,0), 
	NAME VARCHAR2(100), 
	SK NUMBER(2,0) DEFAULT 5
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RAZ_KOM ***
 exec bpa.alter_policies('RAZ_KOM');


COMMENT ON TABLE BARS.RAZ_KOM IS 'ОдноРазовi Комiсiї';
COMMENT ON COLUMN BARS.RAZ_KOM.KOD IS 'Код (БР+ОБ22)~ОдноРазової~Комiсiї';
COMMENT ON COLUMN BARS.RAZ_KOM.PDV IS '';
COMMENT ON COLUMN BARS.RAZ_KOM.UO IS '';
COMMENT ON COLUMN BARS.RAZ_KOM.NAME IS '';
COMMENT ON COLUMN BARS.RAZ_KOM.SK IS '';




PROMPT *** Create  constraint PK_RAZKOM ***
begin   
 execute immediate '
  ALTER TABLE BARS.RAZ_KOM ADD CONSTRAINT PK_RAZKOM PRIMARY KEY (KOD, PDV, UO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RAZKOM_PDV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RAZ_KOM MODIFY (PDV CONSTRAINT CC_RAZKOM_PDV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RAZKOM_SK ***
begin   
 execute immediate '
  ALTER TABLE BARS.RAZ_KOM MODIFY (SK CONSTRAINT CC_RAZKOM_SK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RAZKOM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RAZKOM ON BARS.RAZ_KOM (KOD, PDV, UO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RAZ_KOM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RAZ_KOM         to ABS_ADMIN;
grant SELECT                                                                 on RAZ_KOM         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RAZ_KOM         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RAZ_KOM         to BARS_DM;
grant SELECT                                                                 on RAZ_KOM         to UPLD;
grant FLASHBACK,SELECT                                                       on RAZ_KOM         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RAZ_KOM.sql =========*** End *** =====
PROMPT ===================================================================================== 
