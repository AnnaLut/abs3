

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MONEY1.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MONEY1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MONEY1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MONEY1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''MONEY1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MONEY1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.MONEY1 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(50), 
	LIMIT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MONEY1 ***
 exec bpa.alter_policies('MONEY1');


COMMENT ON TABLE BARS.MONEY1 IS 'Закордоннi перекази ФО';
COMMENT ON COLUMN BARS.MONEY1.ID IS 'Код напряму';
COMMENT ON COLUMN BARS.MONEY1.NAME IS 'Назва';
COMMENT ON COLUMN BARS.MONEY1.LIMIT IS 'Лiмiт (екв-грн.коп) готiвки однiй ФО в один календ день';




PROMPT *** Create  constraint PK_MONEY1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MONEY1 ADD CONSTRAINT PK_MONEY1 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MONEY1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MONEY1 ON BARS.MONEY1 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MONEY1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on MONEY1          to ABS_ADMIN;
grant SELECT                                                                 on MONEY1          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MONEY1          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MONEY1          to BARS_DM;
grant SELECT                                                                 on MONEY1          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MONEY1.sql =========*** End *** ======
PROMPT ===================================================================================== 
