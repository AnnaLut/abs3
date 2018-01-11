

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_CLOSE_TYPES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_CLOSE_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_CLOSE_TYPES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_CLOSE_TYPES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_CLOSE_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_CLOSE_TYPES 
   (	ID NUMBER(1,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_CLOSE_TYPES ***
 exec bpa.alter_policies('ZAY_CLOSE_TYPES');


COMMENT ON TABLE BARS.ZAY_CLOSE_TYPES IS 'Типы закрытия заявок (Надра)';
COMMENT ON COLUMN BARS.ZAY_CLOSE_TYPES.ID IS 'Код';
COMMENT ON COLUMN BARS.ZAY_CLOSE_TYPES.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_ZAYCLOSETYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_CLOSE_TYPES ADD CONSTRAINT PK_ZAYCLOSETYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYCLOSETYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYCLOSETYPES ON BARS.ZAY_CLOSE_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_CLOSE_TYPES ***
grant SELECT                                                                 on ZAY_CLOSE_TYPES to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_CLOSE_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_CLOSE_TYPES to UPLD;
grant FLASHBACK,SELECT                                                       on ZAY_CLOSE_TYPES to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_CLOSE_TYPES to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_CLOSE_TYPES.sql =========*** End *
PROMPT ===================================================================================== 
