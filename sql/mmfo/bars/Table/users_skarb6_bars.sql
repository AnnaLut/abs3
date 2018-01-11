

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/USERS_SKARB6_BARS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to USERS_SKARB6_BARS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''USERS_SKARB6_BARS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''USERS_SKARB6_BARS'', ''FILIAL'' , ''C'', null, null, null);
               bpa.alter_policy_info(''USERS_SKARB6_BARS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table USERS_SKARB6_BARS ***
begin 
  execute immediate '
  CREATE TABLE BARS.USERS_SKARB6_BARS 
   (	KF VARCHAR2(30), 
	USKARB6 NUMBER(30,0), 
	UBARS NUMBER(30,0), 
	FILIAL VARCHAR2(12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to USERS_SKARB6_BARS ***
 exec bpa.alter_policies('USERS_SKARB6_BARS');


COMMENT ON TABLE BARS.USERS_SKARB6_BARS IS '';
COMMENT ON COLUMN BARS.USERS_SKARB6_BARS.KF IS '';
COMMENT ON COLUMN BARS.USERS_SKARB6_BARS.USKARB6 IS '';
COMMENT ON COLUMN BARS.USERS_SKARB6_BARS.UBARS IS '';
COMMENT ON COLUMN BARS.USERS_SKARB6_BARS.FILIAL IS '';




PROMPT *** Create  constraint NN_USERSSKARB6BARS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.USERS_SKARB6_BARS MODIFY (KF CONSTRAINT NN_USERSSKARB6BARS_KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_USERSSKARB6BARS_USKARB6 ***
begin   
 execute immediate '
  ALTER TABLE BARS.USERS_SKARB6_BARS MODIFY (USKARB6 CONSTRAINT NN_USERSSKARB6BARS_USKARB6 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  USERS_SKARB6_BARS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on USERS_SKARB6_BARS to ABS_ADMIN;
grant SELECT                                                                 on USERS_SKARB6_BARS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on USERS_SKARB6_BARS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on USERS_SKARB6_BARS to BARS_DM;
grant SELECT                                                                 on USERS_SKARB6_BARS to START1;
grant SELECT                                                                 on USERS_SKARB6_BARS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on USERS_SKARB6_BARS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/USERS_SKARB6_BARS.sql =========*** End
PROMPT ===================================================================================== 
