

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DCP_A.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DCP_A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DCP_A'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DCP_A'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DCP_A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DCP_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.DCP_A 
   (	REF NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DCP_A ***
 exec bpa.alter_policies('DCP_A');


COMMENT ON TABLE BARS.DCP_A IS '';
COMMENT ON COLUMN BARS.DCP_A.REF IS '';




PROMPT *** Create  constraint XPK_DCP_A ***
begin   
 execute immediate '
  ALTER TABLE BARS.DCP_A ADD CONSTRAINT XPK_DCP_A PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DCP_A ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DCP_A ON BARS.DCP_A (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DCP_A ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DCP_A           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DCP_A           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DCP_A           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DCP_A.sql =========*** End *** =======
PROMPT ===================================================================================== 
