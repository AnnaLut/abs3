

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBS_K014.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBS_K014 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBS_K014'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NBS_K014'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBS_K014'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBS_K014 ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBS_K014 
   (	K014 NUMBER(1,0), 
	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBS_K014 ***
 exec bpa.alter_policies('NBS_K014');


COMMENT ON TABLE BARS.NBS_K014 IS 'Допустимі БР для типів клієнтів';
COMMENT ON COLUMN BARS.NBS_K014.K014 IS 'Тип клієнта: 1-ЮО, 2-ФО-СПД, 3-ФО, 4-Банк, 5-Наш Банк';
COMMENT ON COLUMN BARS.NBS_K014.NBS IS 'БР';




PROMPT *** Create  constraint PK_NBSK014 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_K014 ADD CONSTRAINT PK_NBSK014 PRIMARY KEY (K014, NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBSK014_K014 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_K014 ADD CONSTRAINT CC_NBSK014_K014 CHECK (k014 in (1, 2, 3, 4, 5)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBSK014_K014_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_K014 MODIFY (K014 CONSTRAINT CC_NBSK014_K014_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBSK014_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBS_K014 MODIFY (NBS CONSTRAINT CC_NBSK014_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBSK014 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBSK014 ON BARS.NBS_K014 (K014, NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBS_K014 ***
grant SELECT                                                                 on NBS_K014        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_K014        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBS_K014        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on NBS_K014        to CUST001;
grant SELECT                                                                 on NBS_K014        to UPLD;
grant FLASHBACK,SELECT                                                       on NBS_K014        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBS_K014.sql =========*** End *** ====
PROMPT ===================================================================================== 
