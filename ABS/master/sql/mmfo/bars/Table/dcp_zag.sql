

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DCP_ZAG.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DCP_ZAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DCP_ZAG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DCP_ZAG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DCP_ZAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DCP_ZAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.DCP_ZAG 
   (	FN VARCHAR2(12), 
	DAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DCP_ZAG ***
 exec bpa.alter_policies('DCP_ZAG');


COMMENT ON TABLE BARS.DCP_ZAG IS '';
COMMENT ON COLUMN BARS.DCP_ZAG.FN IS '';
COMMENT ON COLUMN BARS.DCP_ZAG.DAT IS '';




PROMPT *** Create  constraint XPK_DCP_ZAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.DCP_ZAG ADD CONSTRAINT XPK_DCP_ZAG PRIMARY KEY (FN, DAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009217 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DCP_ZAG MODIFY (FN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DCP_ZAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DCP_ZAG ON BARS.DCP_ZAG (FN, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DCP_ZAG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DCP_ZAG         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DCP_ZAG         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DCP_ZAG         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DCP_ZAG.sql =========*** End *** =====
PROMPT ===================================================================================== 
