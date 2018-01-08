

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CHKNBS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CHKNBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CHKNBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CHKNBS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CHKNBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CHKNBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CHKNBS 
   (	CHKNBS NUMBER(1,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CHKNBS ***
 exec bpa.alter_policies('CHKNBS');


COMMENT ON TABLE BARS.CHKNBS IS 'Коды запрещения использования балансовых счетов';
COMMENT ON COLUMN BARS.CHKNBS.CHKNBS IS 'Коды запрещения:
1- запрещен для коммерческого банка
2- запрещен для НБУ';
COMMENT ON COLUMN BARS.CHKNBS.NAME IS 'Наименование кода';




PROMPT *** Create  constraint PK_CHKNBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKNBS ADD CONSTRAINT PK_CHKNBS PRIMARY KEY (CHKNBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHKNBS_CHKNBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKNBS MODIFY (CHKNBS CONSTRAINT CC_CHKNBS_CHKNBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CHKNBS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CHKNBS MODIFY (NAME CONSTRAINT CC_CHKNBS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CHKNBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CHKNBS ON BARS.CHKNBS (CHKNBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CHKNBS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CHKNBS          to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on CHKNBS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CHKNBS          to BARS_DM;
grant SELECT                                                                 on CHKNBS          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CHKNBS          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CHKNBS.sql =========*** End *** ======
PROMPT ===================================================================================== 
