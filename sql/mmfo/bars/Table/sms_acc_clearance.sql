

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SMS_ACC_CLEARANCE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SMS_ACC_CLEARANCE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SMS_ACC_CLEARANCE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SMS_ACC_CLEARANCE'', ''FILIAL'' , null, null, ''E'', ''E'');
               bpa.alter_policy_info(''SMS_ACC_CLEARANCE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SMS_ACC_CLEARANCE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SMS_ACC_CLEARANCE 
   (	ACC NUMBER, 
	ACC_CLEARANCE NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SMS_ACC_CLEARANCE ***
 exec bpa.alter_policies('SMS_ACC_CLEARANCE');


COMMENT ON TABLE BARS.SMS_ACC_CLEARANCE IS 'Звязок рахунок - рахунок заборгованості за SMS інформування';
COMMENT ON COLUMN BARS.SMS_ACC_CLEARANCE.ACC IS 'основний рахунок';
COMMENT ON COLUMN BARS.SMS_ACC_CLEARANCE.ACC_CLEARANCE IS 'рахунок дебіторської заборгованості';




PROMPT *** Create  constraint PK_SMS_ACC_CLEARANCE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_ACC_CLEARANCE ADD CONSTRAINT PK_SMS_ACC_CLEARANCE PRIMARY KEY (ACC, ACC_CLEARANCE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SMS_ACC_CLEARANCE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SMS_ACC_CLEARANCE ON BARS.SMS_ACC_CLEARANCE (ACC, ACC_CLEARANCE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SMS_ACC_CLEARANCE ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SMS_ACC_CLEARANCE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SMS_ACC_CLEARANCE.sql =========*** End
PROMPT ===================================================================================== 
