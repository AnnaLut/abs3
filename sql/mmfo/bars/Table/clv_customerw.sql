

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CLV_CUSTOMERW.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CLV_CUSTOMERW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CLV_CUSTOMERW'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CLV_CUSTOMERW'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CLV_CUSTOMERW'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CLV_CUSTOMERW ***
begin 
  execute immediate '
  CREATE TABLE BARS.CLV_CUSTOMERW 
   (	RNK NUMBER(38,0), 
	TAG CHAR(5), 
	VALUE VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CLV_CUSTOMERW ***
 exec bpa.alter_policies('CLV_CUSTOMERW');


COMMENT ON TABLE BARS.CLV_CUSTOMERW IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMERW.RNK IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMERW.TAG IS '';
COMMENT ON COLUMN BARS.CLV_CUSTOMERW.VALUE IS '';




PROMPT *** Create  constraint PK_CLVCUSTOMERW ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMERW ADD CONSTRAINT PK_CLVCUSTOMERW PRIMARY KEY (RNK, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMERW_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMERW MODIFY (RNK CONSTRAINT CC_CLVCUSTOMERW_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CLVCUSTOMERW_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CLV_CUSTOMERW MODIFY (TAG CONSTRAINT CC_CLVCUSTOMERW_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CLVCUSTOMERW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CLVCUSTOMERW ON BARS.CLV_CUSTOMERW (RNK, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CLV_CUSTOMERW ***
grant SELECT                                                                 on CLV_CUSTOMERW   to BARSREADER_ROLE;
grant SELECT                                                                 on CLV_CUSTOMERW   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CLV_CUSTOMERW   to BARS_DM;
grant SELECT                                                                 on CLV_CUSTOMERW   to CUST001;
grant SELECT                                                                 on CLV_CUSTOMERW   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CLV_CUSTOMERW.sql =========*** End ***
PROMPT ===================================================================================== 
