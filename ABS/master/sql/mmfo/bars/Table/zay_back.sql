

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_BACK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_BACK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_BACK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_BACK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_BACK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_BACK ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_BACK 
   (	ID NUMBER, 
	REASON VARCHAR2(160)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 5 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_BACK ***
 exec bpa.alter_policies('ZAY_BACK');


COMMENT ON TABLE BARS.ZAY_BACK IS 'Справочник причин возврата заявок';
COMMENT ON COLUMN BARS.ZAY_BACK.ID IS 'Код причины возврата заявки';
COMMENT ON COLUMN BARS.ZAY_BACK.REASON IS 'Причина возврата заявки';




PROMPT *** Create  constraint NK_ZAY_BACK_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_BACK MODIFY (ID CONSTRAINT NK_ZAY_BACK_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ZAYBACK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_BACK ADD CONSTRAINT PK_ZAYBACK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYBACK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYBACK ON BARS.ZAY_BACK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_BACK ***
grant FLASHBACK,REFERENCES,SELECT                                            on ZAY_BACK        to BARSAQ with grant option;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_BACK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_BACK        to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_BACK        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ZAY_BACK        to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_BACK        to ZAY;



PROMPT *** Create SYNONYM  to ZAY_BACK ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAY_BACK FOR BARS.ZAY_BACK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_BACK.sql =========*** End *** ====
PROMPT ===================================================================================== 
