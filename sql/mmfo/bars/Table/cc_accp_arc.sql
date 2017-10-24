

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_ACCP_ARC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_ACCP_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_ACCP_ARC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_ACCP_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_ACCP_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_ACCP_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_ACCP_ARC 
   (	ACC NUMBER(*,0), 
	ACCS NUMBER(*,0), 
	ND NUMBER(*,0), 
	DATI DATE, 
	DATD DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_ACCP_ARC ***
 exec bpa.alter_policies('CC_ACCP_ARC');


COMMENT ON TABLE BARS.CC_ACCP_ARC IS '';
COMMENT ON COLUMN BARS.CC_ACCP_ARC.ACC IS '';
COMMENT ON COLUMN BARS.CC_ACCP_ARC.ACCS IS '';
COMMENT ON COLUMN BARS.CC_ACCP_ARC.ND IS '';
COMMENT ON COLUMN BARS.CC_ACCP_ARC.DATI IS '';
COMMENT ON COLUMN BARS.CC_ACCP_ARC.DATD IS '';
COMMENT ON COLUMN BARS.CC_ACCP_ARC.KF IS '';



PROMPT *** Create  grants  CC_ACCP_ARC ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CC_ACCP_ARC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_ACCP_ARC     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_ACCP_ARC.sql =========*** End *** =
PROMPT ===================================================================================== 
