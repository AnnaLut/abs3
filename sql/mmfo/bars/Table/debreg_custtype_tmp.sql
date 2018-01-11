

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEBREG_CUSTTYPE_TMP.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEBREG_CUSTTYPE_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEBREG_CUSTTYPE_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEBREG_CUSTTYPE_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEBREG_CUSTTYPE_TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEBREG_CUSTTYPE_TMP 
   (	ID NUMBER(*,0), 
	CUSTTYPE VARCHAR2(300)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEBREG_CUSTTYPE_TMP ***
 exec bpa.alter_policies('DEBREG_CUSTTYPE_TMP');


COMMENT ON TABLE BARS.DEBREG_CUSTTYPE_TMP IS '';
COMMENT ON COLUMN BARS.DEBREG_CUSTTYPE_TMP.ID IS '';
COMMENT ON COLUMN BARS.DEBREG_CUSTTYPE_TMP.CUSTTYPE IS '';



PROMPT *** Create  grants  DEBREG_CUSTTYPE_TMP ***
grant SELECT                                                                 on DEBREG_CUSTTYPE_TMP to BARSREADER_ROLE;
grant SELECT                                                                 on DEBREG_CUSTTYPE_TMP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEBREG_CUSTTYPE_TMP to DEB_REG;
grant SELECT                                                                 on DEBREG_CUSTTYPE_TMP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEBREG_CUSTTYPE_TMP.sql =========*** E
PROMPT ===================================================================================== 
