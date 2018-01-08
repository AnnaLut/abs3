

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_SHTYPE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_SHTYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_SHTYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_SHTYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_SHTYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_SHTYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_SHTYPE 
   (	ID NUMBER(2,0), 
	NAME VARCHAR2(100), 
	COMM VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_SHTYPE ***
 exec bpa.alter_policies('DPT_SHTYPE');


COMMENT ON TABLE BARS.DPT_SHTYPE IS 'Типы штрафа';
COMMENT ON COLUMN BARS.DPT_SHTYPE.ID IS 'ID';
COMMENT ON COLUMN BARS.DPT_SHTYPE.NAME IS 'Название штрафа';
COMMENT ON COLUMN BARS.DPT_SHTYPE.COMM IS 'Комментраий';




PROMPT *** Create  constraint PK_DPTSHTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_SHTYPE ADD CONSTRAINT PK_DPTSHTYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 1 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSHTYPE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_SHTYPE MODIFY (ID CONSTRAINT CC_DPTSHTYPE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSHTYPE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_SHTYPE MODIFY (NAME CONSTRAINT CC_DPTSHTYPE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTSHTYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTSHTYPE ON BARS.DPT_SHTYPE (ID) 
  PCTFREE 1 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_SHTYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHTYPE      to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHTYPE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_SHTYPE      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHTYPE      to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_SHTYPE      to DPT_ADMIN;
grant SELECT                                                                 on DPT_SHTYPE      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_SHTYPE      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_SHTYPE.sql =========*** End *** ==
PROMPT ===================================================================================== 
