

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_SHOST.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_SHOST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_SHOST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_SHOST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_SHOST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_SHOST ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_SHOST 
   (	ID NUMBER(2,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_SHOST ***
 exec bpa.alter_policies('DPT_SHOST');


COMMENT ON TABLE BARS.DPT_SHOST IS 'Справочник видов вычисления штрафа по остатку';
COMMENT ON COLUMN BARS.DPT_SHOST.ID IS 'ID';
COMMENT ON COLUMN BARS.DPT_SHOST.NAME IS 'Название';




PROMPT *** Create  constraint PK_DPTSHOST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_SHOST ADD CONSTRAINT PK_DPTSHOST PRIMARY KEY (ID)
  USING INDEX PCTFREE 1 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006020 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_SHOST MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSHOST_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_SHOST MODIFY (NAME CONSTRAINT CC_DPTSHOST_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTSHOST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTSHOST ON BARS.DPT_SHOST (ID) 
  PCTFREE 1 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_SHOST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHOST       to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHOST       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_SHOST       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHOST       to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHOST       to DPT_ADMIN;
grant SELECT                                                                 on DPT_SHOST       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_SHOST       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_SHOST.sql =========*** End *** ===
PROMPT ===================================================================================== 
