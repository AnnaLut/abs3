

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEBREG_CUSTTYPE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEBREG_CUSTTYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEBREG_CUSTTYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEBREG_CUSTTYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEBREG_CUSTTYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEBREG_CUSTTYPE 
   (	CUSTTYPE VARCHAR2(300)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEBREG_CUSTTYPE ***
 exec bpa.alter_policies('DEBREG_CUSTTYPE');


COMMENT ON TABLE BARS.DEBREG_CUSTTYPE IS 'Довідник типів клієнтів для АРМ "Реєстр позичальників"';
COMMENT ON COLUMN BARS.DEBREG_CUSTTYPE.CUSTTYPE IS 'Найменування типу клієнта';



PROMPT *** Create  grants  DEBREG_CUSTTYPE ***
grant SELECT                                                                 on DEBREG_CUSTTYPE to BARSREADER_ROLE;
grant SELECT                                                                 on DEBREG_CUSTTYPE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEBREG_CUSTTYPE to DEB_REG;
grant SELECT                                                                 on DEBREG_CUSTTYPE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEBREG_CUSTTYPE.sql =========*** End *
PROMPT ===================================================================================== 
