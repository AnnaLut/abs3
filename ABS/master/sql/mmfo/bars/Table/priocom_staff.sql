

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRIOCOM_STAFF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRIOCOM_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRIOCOM_STAFF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRIOCOM_STAFF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRIOCOM_STAFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRIOCOM_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRIOCOM_STAFF 
   (	ID NUMBER(38,0), 
	 CONSTRAINT XPK_PRIOCOM_STAFF PRIMARY KEY (ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRIOCOM_STAFF ***
 exec bpa.alter_policies('PRIOCOM_STAFF');


COMMENT ON TABLE BARS.PRIOCOM_STAFF IS '';
COMMENT ON COLUMN BARS.PRIOCOM_STAFF.ID IS '';




PROMPT *** Create  constraint XPK_PRIOCOM_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRIOCOM_STAFF ADD CONSTRAINT XPK_PRIOCOM_STAFF PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PRIOCOM_STAFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PRIOCOM_STAFF ON BARS.PRIOCOM_STAFF (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRIOCOM_STAFF ***
grant SELECT                                                                 on PRIOCOM_STAFF   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PRIOCOM_STAFF   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PRIOCOM_STAFF   to PRIOCOM_STAFF_ROLE;
grant FLASHBACK,SELECT                                                       on PRIOCOM_STAFF   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRIOCOM_STAFF.sql =========*** End ***
PROMPT ===================================================================================== 
