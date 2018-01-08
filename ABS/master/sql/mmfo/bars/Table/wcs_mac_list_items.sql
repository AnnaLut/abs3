

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_MAC_LIST_ITEMS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_MAC_LIST_ITEMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_MAC_LIST_ITEMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_MAC_LIST_ITEMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_MAC_LIST_ITEMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_MAC_LIST_ITEMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_MAC_LIST_ITEMS 
   (	MAC_ID VARCHAR2(100), 
	ORD NUMBER, 
	TEXT VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_MAC_LIST_ITEMS ***
 exec bpa.alter_policies('WCS_MAC_LIST_ITEMS');


COMMENT ON TABLE BARS.WCS_MAC_LIST_ITEMS IS 'Описание МАКа типа LIST';
COMMENT ON COLUMN BARS.WCS_MAC_LIST_ITEMS.MAC_ID IS 'Идентификатор МАКа';
COMMENT ON COLUMN BARS.WCS_MAC_LIST_ITEMS.ORD IS 'Порядок в списке';
COMMENT ON COLUMN BARS.WCS_MAC_LIST_ITEMS.TEXT IS 'Текст';




PROMPT *** Create  constraint FK_MACLISTITEMS_MID_MACS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MAC_LIST_ITEMS ADD CONSTRAINT FK_MACLISTITEMS_MID_MACS_ID FOREIGN KEY (MAC_ID)
	  REFERENCES BARS.WCS_MACS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MACLISTITEMS_TEXT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MAC_LIST_ITEMS MODIFY (TEXT CONSTRAINT CC_MACLISTITEMS_TEXT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_MACLISTITEMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_MAC_LIST_ITEMS ADD CONSTRAINT PK_MACLISTITEMS PRIMARY KEY (MAC_ID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MACLISTITEMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MACLISTITEMS ON BARS.WCS_MAC_LIST_ITEMS (MAC_ID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_MAC_LIST_ITEMS ***
grant SELECT                                                                 on WCS_MAC_LIST_ITEMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_MAC_LIST_ITEMS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_MAC_LIST_ITEMS.sql =========*** En
PROMPT ===================================================================================== 
