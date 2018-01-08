

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REF_KODDZ.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REF_KODDZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REF_KODDZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REF_KODDZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REF_KODDZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REF_KODDZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.REF_KODDZ 
   (	REF NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REF_KODDZ ***
 exec bpa.alter_policies('REF_KODDZ');


COMMENT ON TABLE BARS.REF_KODDZ IS '';
COMMENT ON COLUMN BARS.REF_KODDZ.REF IS '';
COMMENT ON COLUMN BARS.REF_KODDZ.KF IS '';




PROMPT *** Create  constraint XPK_REFKODDZ ***
begin   
 execute immediate '
  ALTER TABLE BARS.REF_KODDZ ADD CONSTRAINT XPK_REFKODDZ PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REFKODDZ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REFKODDZ ON BARS.REF_KODDZ (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REF_KODDZ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REF_KODDZ       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REF_KODDZ       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REF_KODDZ       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REF_KODDZ.sql =========*** End *** ===
PROMPT ===================================================================================== 
