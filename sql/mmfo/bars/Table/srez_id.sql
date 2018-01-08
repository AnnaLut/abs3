

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SREZ_ID.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SREZ_ID ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SREZ_ID'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SREZ_ID'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SREZ_ID'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SREZ_ID ***
begin 
  execute immediate '
  CREATE TABLE BARS.SREZ_ID 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SREZ_ID ***
 exec bpa.alter_policies('SREZ_ID');


COMMENT ON TABLE BARS.SREZ_ID IS 'Виды резервов активов';
COMMENT ON COLUMN BARS.SREZ_ID.ID IS 'Код вида';
COMMENT ON COLUMN BARS.SREZ_ID.NAME IS 'Наименование вида';




PROMPT *** Create  constraint XPK_SREZ_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SREZ_ID ADD CONSTRAINT XPK_SREZ_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SREZ_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SREZ_ID ON BARS.SREZ_ID (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SREZ_ID ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZ_ID         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SREZ_ID         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SREZ_ID         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SREZ_ID         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SREZ_ID         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SREZ_ID.sql =========*** End *** =====
PROMPT ===================================================================================== 
