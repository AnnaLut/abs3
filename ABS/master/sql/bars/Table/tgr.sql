

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TGR.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TGR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TGR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TGR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TGR ***
begin 
  execute immediate '
  CREATE TABLE BARS.TGR 
   (	TGR NUMBER(1,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


prompt modify name to varchar2(50)
alter table bars.tgr modify name varchar2(50);
/

PROMPT *** ALTER_POLICIES to TGR ***
 exec bpa.alter_policies('TGR');


COMMENT ON TABLE BARS.TGR IS 'Тип  Госреестра';
COMMENT ON COLUMN BARS.TGR.TGR IS 'Код';
COMMENT ON COLUMN BARS.TGR.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_TGR ***
begin   
 execute immediate '
  ALTER TABLE BARS.TGR ADD CONSTRAINT PK_TGR PRIMARY KEY (TGR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TGR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TGR MODIFY (NAME CONSTRAINT CC_TGR_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TGR_TGR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TGR MODIFY (TGR CONSTRAINT CC_TGR_TGR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TGR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TGR ON BARS.TGR (TGR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TGR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TGR             to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TGR             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TGR             to DPT;
grant SELECT                                                                 on TGR             to DPT_ROLE;
grant SELECT                                                                 on TGR             to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TGR             to WR_ALL_RIGHTS;
grant SELECT                                                                 on TGR             to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on TGR             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TGR.sql =========*** End *** =========
PROMPT ===================================================================================== 
