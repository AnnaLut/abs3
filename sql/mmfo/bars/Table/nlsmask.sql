

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NLSMASK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NLSMASK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NLSMASK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NLSMASK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NLSMASK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NLSMASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.NLSMASK 
   (	MASKID VARCHAR2(10), 
	DESCR VARCHAR2(40), 
	MASK VARCHAR2(15), 
	MASKNMS VARCHAR2(70), 
	SQLNMS VARCHAR2(2000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NLSMASK ***
 exec bpa.alter_policies('NLSMASK');


COMMENT ON TABLE BARS.NLSMASK IS 'Маска счета';
COMMENT ON COLUMN BARS.NLSMASK.MASKID IS 'Признак счета';
COMMENT ON COLUMN BARS.NLSMASK.DESCR IS 'Коментарий';
COMMENT ON COLUMN BARS.NLSMASK.MASK IS 'Маска счета';
COMMENT ON COLUMN BARS.NLSMASK.MASKNMS IS 'Наименование счета';
COMMENT ON COLUMN BARS.NLSMASK.SQLNMS IS 'SQL-запрос для получения наименования';




PROMPT *** Create  constraint PK_NLSMASK ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLSMASK ADD CONSTRAINT PK_NLSMASK PRIMARY KEY (MASKID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009901 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLSMASK MODIFY (MASKID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NLSMASK_MASK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NLSMASK MODIFY (MASK CONSTRAINT CC_NLSMASK_MASK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NLSMASK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NLSMASK ON BARS.NLSMASK (MASKID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NLSMASK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NLSMASK         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NLSMASK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NLSMASK         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on NLSMASK         to NLSMASK;
grant DELETE,INSERT,SELECT,UPDATE                                            on NLSMASK         to NLSMASK_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NLSMASK         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NLSMASK         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on NLSMASK         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NLSMASK.sql =========*** End *** =====
PROMPT ===================================================================================== 
