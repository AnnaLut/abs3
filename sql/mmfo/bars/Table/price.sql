

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRICE.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRICE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRICE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRICE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRICE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRICE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRICE 
   (	INST_NUM NUMBER, 
	VDATE DATE DEFAULT SYSDATE, 
	BID_PRICE NUMBER(24,0), 
	OFFER_PRICE NUMBER(24,0), 
	MID_PRICE NUMBER(24,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRICE ***
 exec bpa.alter_policies('PRICE');


COMMENT ON TABLE BARS.PRICE IS '';
COMMENT ON COLUMN BARS.PRICE.MID_PRICE IS '';
COMMENT ON COLUMN BARS.PRICE.INST_NUM IS '';
COMMENT ON COLUMN BARS.PRICE.VDATE IS '';
COMMENT ON COLUMN BARS.PRICE.BID_PRICE IS '';
COMMENT ON COLUMN BARS.PRICE.OFFER_PRICE IS '';




PROMPT *** Create  constraint XPK_PRICE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRICE ADD CONSTRAINT XPK_PRICE PRIMARY KEY (INST_NUM, VDATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006045 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRICE MODIFY (INST_NUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006046 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRICE MODIFY (VDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PRICE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PRICE ON BARS.PRICE (INST_NUM, VDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRICE ***
grant SELECT                                                                 on PRICE           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PRICE           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PRICE           to START1;
grant SELECT                                                                 on PRICE           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRICE.sql =========*** End *** =======
PROMPT ===================================================================================== 
