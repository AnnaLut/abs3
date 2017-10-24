

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SMS_ACC_CLEARANCE_EXP.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SMS_ACC_CLEARANCE_EXP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SMS_ACC_CLEARANCE_EXP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SMS_ACC_CLEARANCE_EXP'', ''FILIAL'' , null, null, ''E'', ''E'');
               bpa.alter_policy_info(''SMS_ACC_CLEARANCE_EXP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SMS_ACC_CLEARANCE_EXP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SMS_ACC_CLEARANCE_EXP 
   (	ACC_CLEARANCE NUMBER, 
	ACC_CLEARANCE_EXP NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SMS_ACC_CLEARANCE_EXP ***
 exec bpa.alter_policies('SMS_ACC_CLEARANCE_EXP');


COMMENT ON TABLE BARS.SMS_ACC_CLEARANCE_EXP IS 'Звязок рахунок - рахунок простроченої заборгованості за SMS інформування';
COMMENT ON COLUMN BARS.SMS_ACC_CLEARANCE_EXP.ACC_CLEARANCE IS 'рахунок заборгованості';
COMMENT ON COLUMN BARS.SMS_ACC_CLEARANCE_EXP.ACC_CLEARANCE_EXP IS 'рахунок дебіторської простроченої заборгованості';




PROMPT *** Create  constraint PK_SMS_ACC_CLEARANCE_EXP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SMS_ACC_CLEARANCE_EXP ADD CONSTRAINT PK_SMS_ACC_CLEARANCE_EXP PRIMARY KEY (ACC_CLEARANCE, ACC_CLEARANCE_EXP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SMS_ACC_CLEARANCE_EXP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SMS_ACC_CLEARANCE_EXP ON BARS.SMS_ACC_CLEARANCE_EXP (ACC_CLEARANCE, ACC_CLEARANCE_EXP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SMS_ACC_CLEARANCE_EXP ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SMS_ACC_CLEARANCE_EXP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SMS_ACC_CLEARANCE_EXP.sql =========***
PROMPT ===================================================================================== 
