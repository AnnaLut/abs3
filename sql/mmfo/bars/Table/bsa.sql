

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BSA.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BSA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BSA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BSA'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''BSA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BSA ***
begin 
  execute immediate '
  CREATE TABLE BARS.BSA 
   (	BRANCH VARCHAR2(30), 
	AP NUMBER(1,0), 
	BS CHAR(4), 
	KV NUMBER(3,0), 
	OB VARCHAR2(2), 
	D5 CHAR(1), 
	S NUMBER(38,0), 
	DM NUMBER(*,0), 
	KM NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BSA ***
 exec bpa.alter_policies('BSA');


COMMENT ON TABLE BARS.BSA IS '';
COMMENT ON COLUMN BARS.BSA.BRANCH IS '';
COMMENT ON COLUMN BARS.BSA.AP IS '';
COMMENT ON COLUMN BARS.BSA.BS IS '';
COMMENT ON COLUMN BARS.BSA.KV IS '';
COMMENT ON COLUMN BARS.BSA.OB IS '';
COMMENT ON COLUMN BARS.BSA.D5 IS '';
COMMENT ON COLUMN BARS.BSA.S IS '';
COMMENT ON COLUMN BARS.BSA.DM IS '';
COMMENT ON COLUMN BARS.BSA.KM IS '';




PROMPT *** Create  constraint FK_BSA_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BSA ADD CONSTRAINT FK_BSA_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BSA_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BSA MODIFY (BRANCH CONSTRAINT CC_BSA_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BSA_AP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BSA MODIFY (AP CONSTRAINT CC_BSA_AP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BSA_BS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BSA MODIFY (BS CONSTRAINT CC_BSA_BS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BSA_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BSA MODIFY (KV CONSTRAINT CC_BSA_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_BSA ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_BSA ON BARS.BSA (BRANCH, AP, BS, OB, D5, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BSA ***
grant SELECT                                                                 on BSA             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BSA             to BARS_DM;
grant SELECT                                                                 on BSA             to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BSA.sql =========*** End *** =========
PROMPT ===================================================================================== 
