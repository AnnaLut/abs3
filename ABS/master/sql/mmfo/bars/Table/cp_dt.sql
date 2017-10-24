

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_DT.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_DT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_DT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_DT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_DT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_DT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_DT 
   (	RNK NUMBER, 
	FDAT DATE, 
	KAPIT0 NUMBER, 
	KAPIT NUMBER, 
	DT NUMBER, 
	PROC NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_DT ***
 exec bpa.alter_policies('CP_DT');


COMMENT ON TABLE BARS.CP_DT IS '';
COMMENT ON COLUMN BARS.CP_DT.RNK IS '';
COMMENT ON COLUMN BARS.CP_DT.FDAT IS '';
COMMENT ON COLUMN BARS.CP_DT.KAPIT0 IS '';
COMMENT ON COLUMN BARS.CP_DT.KAPIT IS '';
COMMENT ON COLUMN BARS.CP_DT.DT IS '';
COMMENT ON COLUMN BARS.CP_DT.PROC IS '';




PROMPT *** Create  constraint XPK_CP_DT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DT ADD CONSTRAINT XPK_CP_DT PRIMARY KEY (RNK, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_DT_RNK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DT ADD CONSTRAINT FK_CP_DT_RNK FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009667 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DT MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009668 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DT MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_DT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_DT ON BARS.CP_DT (RNK, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_DT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DT           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_DT           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DT           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_DT.sql =========*** End *** =======
PROMPT ===================================================================================== 
