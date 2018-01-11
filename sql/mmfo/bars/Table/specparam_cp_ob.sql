

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPECPARAM_CP_OB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPECPARAM_CP_OB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPECPARAM_CP_OB'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SPECPARAM_CP_OB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SPECPARAM_CP_OB'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPECPARAM_CP_OB ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPECPARAM_CP_OB 
   (	ACC NUMBER, 
	INITIATOR VARCHAR2(2), 
	MARKET VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPECPARAM_CP_OB ***
 exec bpa.alter_policies('SPECPARAM_CP_OB');


COMMENT ON TABLE BARS.SPECPARAM_CP_OB IS '';
COMMENT ON COLUMN BARS.SPECPARAM_CP_OB.ACC IS '';
COMMENT ON COLUMN BARS.SPECPARAM_CP_OB.INITIATOR IS '';
COMMENT ON COLUMN BARS.SPECPARAM_CP_OB.MARKET IS '';




PROMPT *** Create  constraint SYS_C007618 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPECPARAM_CP_OB MODIFY (ACC NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CPOB ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CPOB ON BARS.SPECPARAM_CP_OB (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPECPARAM_CP_OB ***
grant SELECT                                                                 on SPECPARAM_CP_OB to BARSREADER_ROLE;
grant SELECT                                                                 on SPECPARAM_CP_OB to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPECPARAM_CP_OB to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPECPARAM_CP_OB to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPECPARAM_CP_OB to START1;
grant SELECT                                                                 on SPECPARAM_CP_OB to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPECPARAM_CP_OB.sql =========*** End *
PROMPT ===================================================================================== 
