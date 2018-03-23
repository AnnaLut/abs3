

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_ICONS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_ICONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_ICONS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_ICONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_ICONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_ICONS 
   (	ICON_ID NUMBER, 
	ICON_PATH VARCHAR2(400), 
	ICON_DESC VARCHAR2(400)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_ICONS ***
 exec bpa.alter_policies('META_ICONS');


COMMENT ON TABLE BARS.META_ICONS IS 'Таблица описания иконок в табличных формах для описания БМД';
COMMENT ON COLUMN BARS.META_ICONS.ICON_ID IS '';
COMMENT ON COLUMN BARS.META_ICONS.ICON_PATH IS '';
COMMENT ON COLUMN BARS.META_ICONS.ICON_DESC IS '';




PROMPT *** Create  constraint PK_METAICONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_ICONS ADD CONSTRAINT PK_METAICONS PRIMARY KEY (ICON_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METAICONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METAICONS ON BARS.META_ICONS (ICON_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_ICONS ***
grant SELECT                                                                 on META_ICONS      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_ICONS.sql =========*** End *** ==
PROMPT ===================================================================================== 
