

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SP_S240.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SP_S240 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SP_S240'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S240'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S240'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SP_S240 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SP_S240 
   (	S240 VARCHAR2(1), 
	S242 VARCHAR2(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SP_S240 ***
 exec bpa.alter_policies('SP_S240');


COMMENT ON TABLE BARS.SP_S240 IS 'Классификатор кодов сроков до гашения';
COMMENT ON COLUMN BARS.SP_S240.S240 IS '';
COMMENT ON COLUMN BARS.SP_S240.S242 IS '';
COMMENT ON COLUMN BARS.SP_S240.TXT IS '';




PROMPT *** Create  constraint CC_SPS240_S240_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SP_S240 MODIFY (S240 CONSTRAINT CC_SPS240_S240_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPS240_S242_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SP_S240 MODIFY (S242 CONSTRAINT CC_SPS240_S242_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SPS240 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SP_S240 ADD CONSTRAINT PK_SPS240 PRIMARY KEY (S240)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPS240 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPS240 ON BARS.SP_S240 (S240) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SP_S240 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_S240         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_S240         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SP_S240         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_S240         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SP_S240         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SP_S240.sql =========*** End *** =====
PROMPT ===================================================================================== 
