

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_FF9.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_FF9 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_FF9'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_FF9'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_FF9'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_FF9 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_FF9 
   (	DP1 VARCHAR2(1), 
	NAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_FF9 ***
 exec bpa.alter_policies('KL_FF9');


COMMENT ON TABLE BARS.KL_FF9 IS '';
COMMENT ON COLUMN BARS.KL_FF9.DP1 IS '';
COMMENT ON COLUMN BARS.KL_FF9.NAME IS '';




PROMPT *** Create  constraint PK_KL_FF9_DP1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_FF9 ADD CONSTRAINT PK_KL_FF9_DP1 PRIMARY KEY (DP1)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KL_FF9_DP1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KL_FF9_DP1 ON BARS.KL_FF9 (DP1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_FF9 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_FF9          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_FF9          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_FF9          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_FF9.sql =========*** End *** ======
PROMPT ===================================================================================== 
