

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VAL_QUEUE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VAL_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VAL_QUEUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VAL_QUEUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VAL_QUEUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VAL_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.VAL_QUEUE 
   (	REF NUMBER, 
	TT VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VAL_QUEUE ***
 exec bpa.alter_policies('VAL_QUEUE');


COMMENT ON TABLE BARS.VAL_QUEUE IS '';
COMMENT ON COLUMN BARS.VAL_QUEUE.REF IS '';
COMMENT ON COLUMN BARS.VAL_QUEUE.TT IS '';




PROMPT *** Create  constraint PK_VAL_QUEUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.VAL_QUEUE ADD CONSTRAINT PK_VAL_QUEUE PRIMARY KEY (REF, TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VAL_QUEUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VAL_QUEUE ON BARS.VAL_QUEUE (REF, TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VAL_QUEUE ***
grant INSERT,SELECT,UPDATE                                                   on VAL_QUEUE       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VAL_QUEUE       to BARS_DM;
grant INSERT,SELECT,UPDATE                                                   on VAL_QUEUE       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VAL_QUEUE.sql =========*** End *** ===
PROMPT ===================================================================================== 
