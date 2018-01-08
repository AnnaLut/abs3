

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRICE_BASIS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRICE_BASIS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRICE_BASIS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRICE_BASIS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRICE_BASIS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRICE_BASIS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRICE_BASIS 
   (	PRCB VARCHAR2(2), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRICE_BASIS ***
 exec bpa.alter_policies('PRICE_BASIS');


COMMENT ON TABLE BARS.PRICE_BASIS IS '';
COMMENT ON COLUMN BARS.PRICE_BASIS.PRCB IS '';
COMMENT ON COLUMN BARS.PRICE_BASIS.NAME IS '';




PROMPT *** Create  constraint XPK_PRICE_BASIS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRICE_BASIS ADD CONSTRAINT XPK_PRICE_BASIS PRIMARY KEY (PRCB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009782 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRICE_BASIS MODIFY (PRCB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PRICE_BASIS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PRICE_BASIS ON BARS.PRICE_BASIS (PRCB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRICE_BASIS ***
grant SELECT                                                                 on PRICE_BASIS     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PRICE_BASIS     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PRICE_BASIS     to PRICE_BAS;
grant SELECT                                                                 on PRICE_BASIS     to UPLD;
grant FLASHBACK,SELECT                                                       on PRICE_BASIS     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRICE_BASIS.sql =========*** End *** =
PROMPT ===================================================================================== 
