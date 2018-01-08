

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRICE_FORMAT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRICE_FORMAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRICE_FORMAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRICE_FORMAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRICE_FORMAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRICE_FORMAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRICE_FORMAT 
   (	PRCF VARCHAR2(1), 
	NAME VARCHAR2(35), 
	VALUE NUMBER(3,0) DEFAULT 1
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRICE_FORMAT ***
 exec bpa.alter_policies('PRICE_FORMAT');


COMMENT ON TABLE BARS.PRICE_FORMAT IS '';
COMMENT ON COLUMN BARS.PRICE_FORMAT.PRCF IS '';
COMMENT ON COLUMN BARS.PRICE_FORMAT.NAME IS '';
COMMENT ON COLUMN BARS.PRICE_FORMAT.VALUE IS '';




PROMPT *** Create  constraint XPK_PRICE_FORMAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRICE_FORMAT ADD CONSTRAINT XPK_PRICE_FORMAT PRIMARY KEY (PRCF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006566 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRICE_FORMAT MODIFY (PRCF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006567 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRICE_FORMAT MODIFY (VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PRICE_FORMAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PRICE_FORMAT ON BARS.PRICE_FORMAT (PRCF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRICE_FORMAT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PRICE_FORMAT    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PRICE_FORMAT    to PRICE_FOR;
grant FLASHBACK,SELECT                                                       on PRICE_FORMAT    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRICE_FORMAT.sql =========*** End *** 
PROMPT ===================================================================================== 
