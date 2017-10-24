

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_SUBPRODUCT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_SUBPRODUCT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_SUBPRODUCT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''W4_SUBPRODUCT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''W4_SUBPRODUCT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_SUBPRODUCT ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_SUBPRODUCT 
   (	CODE VARCHAR2(32), 
	NAME VARCHAR2(100), 
	FLAG_KK NUMBER(1,0) DEFAULT 0, 
	FLAG_INSTANT NUMBER(1,0) DEFAULT 0, 
	DATE_INSTANT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_SUBPRODUCT ***
 exec bpa.alter_policies('W4_SUBPRODUCT');


COMMENT ON TABLE BARS.W4_SUBPRODUCT IS 'W4. Справочник субпродуктов';
COMMENT ON COLUMN BARS.W4_SUBPRODUCT.CODE IS 'Код субпродукта';
COMMENT ON COLUMN BARS.W4_SUBPRODUCT.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.W4_SUBPRODUCT.FLAG_KK IS 'Признак Картки киянина';
COMMENT ON COLUMN BARS.W4_SUBPRODUCT.FLAG_INSTANT IS 'Ознака випуску тільки миттєвих карток';
COMMENT ON COLUMN BARS.W4_SUBPRODUCT.DATE_INSTANT IS 'Ознака випуску тільки миттєвих карток з вказаної дати';




PROMPT *** Create  constraint CC_W4SUBPRODUCT_FLAGINSTANT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SUBPRODUCT ADD CONSTRAINT CC_W4SUBPRODUCT_FLAGINSTANT_NN CHECK (flag_instant is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4SUBPRODUCT_FLAGKK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SUBPRODUCT ADD CONSTRAINT CC_W4SUBPRODUCT_FLAGKK_NN CHECK (flag_kk is not null) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4SUBPRODUCT_FLAGKK ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SUBPRODUCT ADD CONSTRAINT CC_W4SUBPRODUCT_FLAGKK CHECK (flag_kk in (0,1,2)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4SUBPRODUCT_FLAGINSTANT ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SUBPRODUCT ADD CONSTRAINT CC_W4SUBPRODUCT_FLAGINSTANT CHECK (flag_instant in (0, 1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4SUBPRODUCT_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SUBPRODUCT MODIFY (CODE CONSTRAINT CC_W4SUBPRODUCT_CODE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_W4SUBPRODUCT ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_SUBPRODUCT ADD CONSTRAINT PK_W4SUBPRODUCT PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4SUBPRODUCT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4SUBPRODUCT ON BARS.W4_SUBPRODUCT (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_SUBPRODUCT ***
grant SELECT                                                                 on W4_SUBPRODUCT   to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on W4_SUBPRODUCT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_SUBPRODUCT   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_SUBPRODUCT   to OW;
grant SELECT                                                                 on W4_SUBPRODUCT   to UPLD;
grant FLASHBACK,SELECT                                                       on W4_SUBPRODUCT   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_SUBPRODUCT.sql =========*** End ***
PROMPT ===================================================================================== 
