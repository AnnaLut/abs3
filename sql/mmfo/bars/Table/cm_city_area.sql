

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CM_CITY_AREA.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CM_CITY_AREA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CM_CITY_AREA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CM_CITY_AREA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CM_CITY_AREA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CM_CITY_AREA ***
begin 
  execute immediate '
  CREATE TABLE BARS.CM_CITY_AREA 
   (	ID NUMBER(10,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CM_CITY_AREA ***
 exec bpa.alter_policies('CM_CITY_AREA');


COMMENT ON TABLE BARS.CM_CITY_AREA IS 'CardMake. Довідник кодів районів міста';
COMMENT ON COLUMN BARS.CM_CITY_AREA.ID IS 'Код';
COMMENT ON COLUMN BARS.CM_CITY_AREA.NAME IS 'Назва';




PROMPT *** Create  constraint PK_CMCITYAREA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CM_CITY_AREA ADD CONSTRAINT PK_CMCITYAREA PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CMCITYAREA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CMCITYAREA ON BARS.CM_CITY_AREA (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CM_CITY_AREA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_CITY_AREA    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CM_CITY_AREA    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CM_CITY_AREA    to OW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CM_CITY_AREA.sql =========*** End *** 
PROMPT ===================================================================================== 
