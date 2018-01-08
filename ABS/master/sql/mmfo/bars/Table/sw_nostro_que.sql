

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_NOSTRO_QUE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_NOSTRO_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_NOSTRO_QUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_NOSTRO_QUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SW_NOSTRO_QUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_NOSTRO_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_NOSTRO_QUE 
   (	REF NUMBER(38,0), 
	 CONSTRAINT PK_SWNOSTROQUE PRIMARY KEY (REF) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_NOSTRO_QUE ***
 exec bpa.alter_policies('SW_NOSTRO_QUE');


COMMENT ON TABLE BARS.SW_NOSTRO_QUE IS 'SWT. Очередь документов на подбор корсчета';
COMMENT ON COLUMN BARS.SW_NOSTRO_QUE.REF IS 'Референс документа';




PROMPT *** Create  constraint CC_SWNOSTROQUE_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_NOSTRO_QUE MODIFY (REF CONSTRAINT CC_SWNOSTROQUE_REF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWNOSTROQUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_NOSTRO_QUE ADD CONSTRAINT PK_SWNOSTROQUE PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWNOSTROQUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWNOSTROQUE ON BARS.SW_NOSTRO_QUE (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_NOSTRO_QUE ***
grant SELECT                                                                 on SW_NOSTRO_QUE   to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SW_NOSTRO_QUE   to SWTOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_NOSTRO_QUE   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_NOSTRO_QUE.sql =========*** End ***
PROMPT ===================================================================================== 
