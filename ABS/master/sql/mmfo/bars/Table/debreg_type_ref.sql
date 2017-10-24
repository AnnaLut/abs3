

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEBREG_TYPE_REF.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEBREG_TYPE_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEBREG_TYPE_REF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEBREG_TYPE_REF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEBREG_TYPE_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEBREG_TYPE_REF 
   (	TYPE VARCHAR2(300)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEBREG_TYPE_REF ***
 exec bpa.alter_policies('DEBREG_TYPE_REF');


COMMENT ON TABLE BARS.DEBREG_TYPE_REF IS '';
COMMENT ON COLUMN BARS.DEBREG_TYPE_REF.TYPE IS '';



PROMPT *** Create  grants  DEBREG_TYPE_REF ***
grant SELECT                                                                 on DEBREG_TYPE_REF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEBREG_TYPE_REF to DEB_REG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEBREG_TYPE_REF.sql =========*** End *
PROMPT ===================================================================================== 
