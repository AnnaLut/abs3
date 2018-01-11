

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEBREG_TYPE_REF_CBD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEBREG_TYPE_REF_CBD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEBREG_TYPE_REF_CBD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEBREG_TYPE_REF_CBD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEBREG_TYPE_REF_CBD ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEBREG_TYPE_REF_CBD 
   (	TYPE VARCHAR2(300)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEBREG_TYPE_REF_CBD ***
 exec bpa.alter_policies('DEBREG_TYPE_REF_CBD');


COMMENT ON TABLE BARS.DEBREG_TYPE_REF_CBD IS '';
COMMENT ON COLUMN BARS.DEBREG_TYPE_REF_CBD.TYPE IS '';



PROMPT *** Create  grants  DEBREG_TYPE_REF_CBD ***
grant SELECT                                                                 on DEBREG_TYPE_REF_CBD to BARSREADER_ROLE;
grant SELECT                                                                 on DEBREG_TYPE_REF_CBD to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEBREG_TYPE_REF_CBD to DEB_REG;
grant SELECT                                                                 on DEBREG_TYPE_REF_CBD to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEBREG_TYPE_REF_CBD.sql =========*** E
PROMPT ===================================================================================== 
