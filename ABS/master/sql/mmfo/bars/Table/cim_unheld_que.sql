

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_UNHELD_QUE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_UNHELD_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_UNHELD_QUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_UNHELD_QUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_UNHELD_QUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_UNHELD_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_UNHELD_QUE 
   (	BOUND_ID NUMBER, 
	REF NUMBER, 
	CONTR_ID NUMBER, 
	VDAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_UNHELD_QUE ***
 exec bpa.alter_policies('CIM_UNHELD_QUE');


COMMENT ON TABLE BARS.CIM_UNHELD_QUE IS 'Черга непроведених платежів';
COMMENT ON COLUMN BARS.CIM_UNHELD_QUE.BOUND_ID IS '';
COMMENT ON COLUMN BARS.CIM_UNHELD_QUE.REF IS 'Id типу';
COMMENT ON COLUMN BARS.CIM_UNHELD_QUE.CONTR_ID IS 'ID контракту';
COMMENT ON COLUMN BARS.CIM_UNHELD_QUE.VDAT IS 'Планова дата валютування';



PROMPT *** Create  grants  CIM_UNHELD_QUE ***
grant SELECT                                                                 on CIM_UNHELD_QUE  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_UNHELD_QUE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_UNHELD_QUE  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_UNHELD_QUE  to CIM_ROLE;
grant SELECT                                                                 on CIM_UNHELD_QUE  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_UNHELD_QUE.sql =========*** End **
PROMPT ===================================================================================== 
