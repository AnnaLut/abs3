

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KEKB_PLAN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KEKB_PLAN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KEKB_PLAN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KEKB_PLAN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KEKB_PLAN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KEKB_PLAN ***
begin 
  execute immediate '
  CREATE TABLE BARS.KEKB_PLAN 
   (	KEKB NUMBER(38,0), 
	YYYYMM NUMBER(38,0), 
	S NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KEKB_PLAN ***
 exec bpa.alter_policies('KEKB_PLAN');


COMMENT ON TABLE BARS.KEKB_PLAN IS '';
COMMENT ON COLUMN BARS.KEKB_PLAN.KEKB IS '';
COMMENT ON COLUMN BARS.KEKB_PLAN.YYYYMM IS '';
COMMENT ON COLUMN BARS.KEKB_PLAN.S IS '';




PROMPT *** Create  constraint XPK_KEKB_PLAN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KEKB_PLAN ADD CONSTRAINT XPK_KEKB_PLAN PRIMARY KEY (KEKB, YYYYMM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_KEKB_PLAN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KEKB_PLAN ADD CONSTRAINT R_KEKB_PLAN FOREIGN KEY (KEKB)
	  REFERENCES BARS.KEKB (KEKB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007803 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KEKB_PLAN MODIFY (KEKB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007804 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KEKB_PLAN MODIFY (YYYYMM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KEKB_PLAN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KEKB_PLAN ON BARS.KEKB_PLAN (KEKB, YYYYMM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KEKB_PLAN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KEKB_PLAN       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KEKB_PLAN       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KEKB_PLAN.sql =========*** End *** ===
PROMPT ===================================================================================== 
