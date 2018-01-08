

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_SWIFT_BIC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_SWIFT_BIC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_SWIFT_BIC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S6_SWIFT_BIC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''S6_SWIFT_BIC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_SWIFT_BIC ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_SWIFT_BIC 
   (	BIC NUMBER(10,0), 
	NLS VARCHAR2(25), 
	GROUP_U NUMBER(10,0), 
	I_VA NUMBER(5,0), 
	BIC_IN VARCHAR2(12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_SWIFT_BIC ***
 exec bpa.alter_policies('S6_SWIFT_BIC');


COMMENT ON TABLE BARS.S6_SWIFT_BIC IS '';
COMMENT ON COLUMN BARS.S6_SWIFT_BIC.BIC IS '';
COMMENT ON COLUMN BARS.S6_SWIFT_BIC.NLS IS '';
COMMENT ON COLUMN BARS.S6_SWIFT_BIC.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_SWIFT_BIC.I_VA IS '';
COMMENT ON COLUMN BARS.S6_SWIFT_BIC.BIC_IN IS '';




PROMPT *** Create  constraint SYS_C005075 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SWIFT_BIC MODIFY (BIC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005076 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SWIFT_BIC MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005077 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SWIFT_BIC MODIFY (GROUP_U NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005078 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SWIFT_BIC MODIFY (I_VA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005079 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_SWIFT_BIC MODIFY (BIC_IN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S6_SWIFT_BIC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_SWIFT_BIC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_SWIFT_BIC    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on S6_SWIFT_BIC    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_SWIFT_BIC.sql =========*** End *** 
PROMPT ===================================================================================== 
