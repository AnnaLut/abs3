

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_GROUPS_STAFF_ACC.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_GROUPS_STAFF_ACC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_GROUPS_STAFF_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_GROUPS_STAFF_ACC 
   (	STAFF_GROUP_ID NUMBER, 
	ACC_GROUP_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_GROUPS_STAFF_ACC ***
 exec bpa.alter_policies('TMP_GROUPS_STAFF_ACC');


COMMENT ON TABLE BARS.TMP_GROUPS_STAFF_ACC IS '';
COMMENT ON COLUMN BARS.TMP_GROUPS_STAFF_ACC.STAFF_GROUP_ID IS '';
COMMENT ON COLUMN BARS.TMP_GROUPS_STAFF_ACC.ACC_GROUP_ID IS '';



PROMPT *** Create  grants  TMP_GROUPS_STAFF_ACC ***
grant SELECT                                                                 on TMP_GROUPS_STAFF_ACC to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_GROUPS_STAFF_ACC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_GROUPS_STAFF_ACC.sql =========*** 
PROMPT ===================================================================================== 
