

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SP_S180.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SP_S180 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SP_S180'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S180'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SP_S180'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SP_S180 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SP_S180 
   (	S180 VARCHAR2(1), 
	S181 VARCHAR2(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SP_S180 ***
 exec bpa.alter_policies('SP_S180');


COMMENT ON TABLE BARS.SP_S180 IS '';
COMMENT ON COLUMN BARS.SP_S180.S180 IS '';
COMMENT ON COLUMN BARS.SP_S180.S181 IS '';
COMMENT ON COLUMN BARS.SP_S180.TXT IS '';




PROMPT *** Create  constraint CC_SPS180_S180_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SP_S180 MODIFY (S180 CONSTRAINT CC_SPS180_S180_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPS180_S181_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SP_S180 MODIFY (S181 CONSTRAINT CC_SPS180_S181_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SPS180 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SP_S180 ADD CONSTRAINT PK_SPS180 PRIMARY KEY (S180)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPS180 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPS180 ON BARS.SP_S180 (S180) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SP_S180 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_S180         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_S180         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SP_S180         to SP_S180;
grant SELECT                                                                 on SP_S180         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SP_S180         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SP_S180         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SP_S180.sql =========*** End *** =====
PROMPT ===================================================================================== 
