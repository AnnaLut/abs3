

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_PR_KIAKR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_PR_KIAKR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_PR_KIAKR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_PR_KIAKR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_PR_KIAKR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_PR_KIAKR ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_PR_KIAKR 
   (	DAT DATE, 
	KV NUMBER, 
	PR1 NUMBER, 
	PR2 NUMBER, 
	PR3 NUMBER, 
	PR4 NUMBER, 
	PR5 NUMBER, 
	PR6 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_PR_KIAKR ***
 exec bpa.alter_policies('CP_PR_KIAKR');


COMMENT ON TABLE BARS.CP_PR_KIAKR IS '';
COMMENT ON COLUMN BARS.CP_PR_KIAKR.DAT IS '';
COMMENT ON COLUMN BARS.CP_PR_KIAKR.KV IS '';
COMMENT ON COLUMN BARS.CP_PR_KIAKR.PR1 IS '';
COMMENT ON COLUMN BARS.CP_PR_KIAKR.PR2 IS '';
COMMENT ON COLUMN BARS.CP_PR_KIAKR.PR3 IS '';
COMMENT ON COLUMN BARS.CP_PR_KIAKR.PR4 IS '';
COMMENT ON COLUMN BARS.CP_PR_KIAKR.PR5 IS '';
COMMENT ON COLUMN BARS.CP_PR_KIAKR.PR6 IS '';




PROMPT *** Create  constraint PK_CP_PR_KIAKR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PR_KIAKR ADD CONSTRAINT PK_CP_PR_KIAKR PRIMARY KEY (DAT, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CP_PR_KIAKR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CP_PR_KIAKR ON BARS.CP_PR_KIAKR (DAT, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_PR_KIAKR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_PR_KIAKR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_PR_KIAKR     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_PR_KIAKR     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_PR_KIAKR.sql =========*** End *** =
PROMPT ===================================================================================== 
