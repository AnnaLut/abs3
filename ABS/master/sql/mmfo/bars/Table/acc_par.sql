

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_PAR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_PAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_PAR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_PAR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_PAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_PAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_PAR 
   (	TABID NUMBER(38,0), 
	COLID NUMBER(38,0), 
	PR NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_PAR ***
 exec bpa.alter_policies('ACC_PAR');


COMMENT ON TABLE BARS.ACC_PAR IS 'Метаописание. Справочник параметров счетов и клиентов';
COMMENT ON COLUMN BARS.ACC_PAR.TABID IS 'Идентификатор таблицы';
COMMENT ON COLUMN BARS.ACC_PAR.COLID IS 'Идентификатор столбца';
COMMENT ON COLUMN BARS.ACC_PAR.PR IS 'Признак отношения (1-счета, 2-клиенты)';




PROMPT *** Create  constraint CC_ACCPAR_PR ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_PAR ADD CONSTRAINT CC_ACCPAR_PR CHECK (pr in (1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCPAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_PAR ADD CONSTRAINT PK_ACCPAR PRIMARY KEY (TABID, COLID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPAR_TABID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_PAR MODIFY (TABID CONSTRAINT CC_ACCPAR_TABID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPAR_COLID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_PAR MODIFY (COLID CONSTRAINT CC_ACCPAR_COLID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPAR_PR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_PAR MODIFY (PR CONSTRAINT CC_ACCPAR_PR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCPAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCPAR ON BARS.ACC_PAR (TABID, COLID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_PAR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_PAR         to ABS_ADMIN;
grant SELECT                                                                 on ACC_PAR         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_PAR         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_PAR         to BARS_DM;
grant SELECT                                                                 on ACC_PAR         to CUST001;
grant SELECT                                                                 on ACC_PAR         to START1;
grant SELECT                                                                 on ACC_PAR         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_PAR         to WR_ALL_RIGHTS;
grant SELECT                                                                 on ACC_PAR         to WR_CUSTLIST;
grant FLASHBACK,SELECT                                                       on ACC_PAR         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_PAR.sql =========*** End *** =====
PROMPT ===================================================================================== 
