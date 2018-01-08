

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_SUB_GROUPS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_SUB_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_SUB_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_SUB_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_SUB_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_SUB_GROUPS 
   (	ID_GRP NUMBER(1,0), 
	ID_PRC_QUALITY NUMBER(2,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_SUB_GROUPS ***
 exec bpa.alter_policies('EBKC_SUB_GROUPS');


COMMENT ON TABLE BARS.EBKC_SUB_GROUPS IS '';
COMMENT ON COLUMN BARS.EBKC_SUB_GROUPS.ID_GRP IS '';
COMMENT ON COLUMN BARS.EBKC_SUB_GROUPS.ID_PRC_QUALITY IS '';




PROMPT *** Create  constraint SYS_C0032184 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_SUB_GROUPS MODIFY (ID_GRP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032185 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EBKC_SUB_GROUPS MODIFY (ID_PRC_QUALITY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EBKC_SUB_GROUPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_SUB_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBKC_SUB_GROUPS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_SUB_GROUPS.sql =========*** End *
PROMPT ===================================================================================== 
