

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBK_SUB_GROUPS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBK_SUB_GROUPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBK_SUB_GROUPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_SUB_GROUPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBK_SUB_GROUPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBK_SUB_GROUPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBK_SUB_GROUPS 
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




PROMPT *** ALTER_POLICIES to EBK_SUB_GROUPS ***
 exec bpa.alter_policies('EBK_SUB_GROUPS');


COMMENT ON TABLE BARS.EBK_SUB_GROUPS IS '';
COMMENT ON COLUMN BARS.EBK_SUB_GROUPS.ID_GRP IS '';
COMMENT ON COLUMN BARS.EBK_SUB_GROUPS.ID_PRC_QUALITY IS '';



PROMPT *** Create  grants  EBK_SUB_GROUPS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBK_SUB_GROUPS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EBK_SUB_GROUPS  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBK_SUB_GROUPS.sql =========*** End **
PROMPT ===================================================================================== 
