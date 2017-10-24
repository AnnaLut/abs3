

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAG_KLBXA.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAG_KLBXA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAG_KLBXA ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAG_KLBXA 
   (	FN VARCHAR2(100), 
	DAT DATE, 
	OTM NUMBER(1,0), 
	ERR VARCHAR2(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAG_KLBXA ***
 exec bpa.alter_policies('ZAG_KLBXA');


COMMENT ON TABLE BARS.ZAG_KLBXA IS 'файлы входящие на клиент-банк(XML)';
COMMENT ON COLUMN BARS.ZAG_KLBXA.FN IS '';
COMMENT ON COLUMN BARS.ZAG_KLBXA.DAT IS '';
COMMENT ON COLUMN BARS.ZAG_KLBXA.OTM IS '';
COMMENT ON COLUMN BARS.ZAG_KLBXA.ERR IS '';




PROMPT *** Create  constraint XPK_ZAG_KLBXA ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_KLBXA ADD CONSTRAINT XPK_ZAG_KLBXA PRIMARY KEY (FN, DAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ZAG_KLBXA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ZAG_KLBXA ON BARS.ZAG_KLBXA (FN, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAG_KLBXA ***
grant SELECT                                                                 on ZAG_KLBXA       to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAG_KLBXA       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAG_KLBXA.sql =========*** End *** ===
PROMPT ===================================================================================== 
