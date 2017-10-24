

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMERP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMERP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMERP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMERP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CUSTOMERP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMERP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMERP 
   (	RNK NUMBER, 
	DAT1 DATE, 
	DAT2 DATE, 
	PARID NUMBER, 
	VAL VARCHAR2(254)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMERP ***
 exec bpa.alter_policies('CUSTOMERP');


COMMENT ON TABLE BARS.CUSTOMERP IS '';
COMMENT ON COLUMN BARS.CUSTOMERP.RNK IS '';
COMMENT ON COLUMN BARS.CUSTOMERP.DAT1 IS '';
COMMENT ON COLUMN BARS.CUSTOMERP.DAT2 IS '';
COMMENT ON COLUMN BARS.CUSTOMERP.PARID IS '';
COMMENT ON COLUMN BARS.CUSTOMERP.VAL IS '';




PROMPT *** Create  constraint XPK_CUSTOMERP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERP ADD CONSTRAINT XPK_CUSTOMERP PRIMARY KEY (RNK, DAT1, PARID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERP_CUSTOMERFIELD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERP ADD CONSTRAINT FK_CUSTOMERP_CUSTOMERFIELD FOREIGN KEY (PARID)
	  REFERENCES BARS.CUSTOMER_FIELD (PARID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CUSTOMERP_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUSTOMERP ADD CONSTRAINT FK_CUSTOMERP_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CUSTOMERP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CUSTOMERP ON BARS.CUSTOMERP (RNK, DAT1, PARID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMERP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERP       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMERP       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMERP       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMERP.sql =========*** End *** ===
PROMPT ===================================================================================== 
