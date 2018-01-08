

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VALUABLES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VALUABLES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VALUABLES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VALUABLES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VALUABLES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VALUABLES ***
begin 
  execute immediate '
  CREATE TABLE BARS.VALUABLES 
   (	NAME VARCHAR2(45), 
	NOMINAL NUMBER(10,0), 
	CENA NUMBER(10,0) DEFAULT 0, 
	OB22 CHAR(6), 
	OB22_989 CHAR(2), 
	OB22_DOR CHAR(2), 
	OB22_SPL CHAR(2), 
	OB22_205 CHAR(2), 
	OB22_DORS CHAR(2), 
	NOT_9819 NUMBER(*,0), 
	ZALIK NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VALUABLES ***
 exec bpa.alter_policies('VALUABLES');


COMMENT ON TABLE BARS.VALUABLES IS 'Цiннi активи, що реалiзуються в вiддiленнях';
COMMENT ON COLUMN BARS.VALUABLES.NAME IS 'Назва цiнностi';
COMMENT ON COLUMN BARS.VALUABLES.NOMINAL IS 'Номiнaльна вартiсть цiнностi';
COMMENT ON COLUMN BARS.VALUABLES.CENA IS '';
COMMENT ON COLUMN BARS.VALUABLES.OB22 IS 'БАЛ+OB22 (ключ) для~цiнностi';
COMMENT ON COLUMN BARS.VALUABLES.OB22_989 IS 'OB22 для~пiдзвiту';
COMMENT ON COLUMN BARS.VALUABLES.OB22_DOR IS 'OB22 для~дороги';
COMMENT ON COLUMN BARS.VALUABLES.OB22_SPL IS 'OB22 для~сплаченi';
COMMENT ON COLUMN BARS.VALUABLES.OB22_205 IS 'OB22 для~2905/2805';
COMMENT ON COLUMN BARS.VALUABLES.OB22_DORS IS 'OB22 для~дороги сплачені';
COMMENT ON COLUMN BARS.VALUABLES.NOT_9819 IS '';
COMMENT ON COLUMN BARS.VALUABLES.ZALIK IS '';




PROMPT *** Create  constraint PK_VALUABLES ***
begin   
 execute immediate '
  ALTER TABLE BARS.VALUABLES ADD CONSTRAINT PK_VALUABLES PRIMARY KEY (OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VALUABLES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VALUABLES MODIFY (NAME CONSTRAINT CC_VALUABLES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VALUABLES_NOMINAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VALUABLES MODIFY (NOMINAL CONSTRAINT CC_VALUABLES_NOMINAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VALUABLES_CENA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VALUABLES MODIFY (CENA CONSTRAINT CC_VALUABLES_CENA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VALUABLES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VALUABLES ON BARS.VALUABLES (OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VALUABLES ***
grant DELETE,INSERT,UPDATE                                                   on VALUABLES       to ABS_ADMIN;
grant SELECT                                                                 on VALUABLES       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VALUABLES       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VALUABLES       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on VALUABLES       to PYOD001;
grant SELECT                                                                 on VALUABLES       to START1;
grant SELECT                                                                 on VALUABLES       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VALUABLES       to WR_ALL_RIGHTS;
grant SELECT                                                                 on VALUABLES       to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on VALUABLES       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VALUABLES.sql =========*** End *** ===
PROMPT ===================================================================================== 
