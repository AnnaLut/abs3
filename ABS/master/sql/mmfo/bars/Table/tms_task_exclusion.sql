

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMS_TASK_EXCLUSION.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMS_TASK_EXCLUSION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMS_TASK_EXCLUSION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMS_TASK_EXCLUSION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMS_TASK_EXCLUSION ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMS_TASK_EXCLUSION 
   (	TASK_CODE VARCHAR2(30 CHAR), 
	KF VARCHAR2(30 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMS_TASK_EXCLUSION ***
 exec bpa.alter_policies('TMS_TASK_EXCLUSION');


COMMENT ON TABLE BARS.TMS_TASK_EXCLUSION IS '';
COMMENT ON COLUMN BARS.TMS_TASK_EXCLUSION.TASK_CODE IS '';
COMMENT ON COLUMN BARS.TMS_TASK_EXCLUSION.KF IS '';



PROMPT *** Create  grants  TMS_TASK_EXCLUSION ***
grant SELECT                                                                 on TMS_TASK_EXCLUSION to BARSREADER_ROLE;
grant SELECT                                                                 on TMS_TASK_EXCLUSION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMS_TASK_EXCLUSION.sql =========*** En
PROMPT ===================================================================================== 
