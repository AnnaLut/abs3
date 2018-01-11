

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_PAYMENT_QUE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_PAYMENT_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_PAYMENT_QUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_PAYMENT_QUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_PAYMENT_QUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_PAYMENT_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_PAYMENT_QUE 
   (	ID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_PAYMENT_QUE ***
 exec bpa.alter_policies('STO_PAYMENT_QUE');


COMMENT ON TABLE BARS.STO_PAYMENT_QUE IS 'Черга на відправку до СРМ';
COMMENT ON COLUMN BARS.STO_PAYMENT_QUE.ID IS 'Ідентифікатор платежу';




PROMPT *** Create  constraint PK_STO_PAYMENT_QUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT_QUE ADD CONSTRAINT PK_STO_PAYMENT_QUE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008808 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT_QUE MODIFY (ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_PAYMENT_QUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_PAYMENT_QUE ON BARS.STO_PAYMENT_QUE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_PAYMENT_QUE ***
grant SELECT                                                                 on STO_PAYMENT_QUE to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on STO_PAYMENT_QUE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_PAYMENT_QUE to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on STO_PAYMENT_QUE to STO;
grant SELECT                                                                 on STO_PAYMENT_QUE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_PAYMENT_QUE.sql =========*** End *
PROMPT ===================================================================================== 
