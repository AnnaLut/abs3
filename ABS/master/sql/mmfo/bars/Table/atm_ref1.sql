

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATM_REF1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATM_REF1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATM_REF1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ATM_REF1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATM_REF1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATM_REF1 
   (	ACC NUMBER, 
	REF1 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATM_REF1 ***
 exec bpa.alter_policies('ATM_REF1');


COMMENT ON TABLE BARS.ATM_REF1 IS 'Картотека надлишків та нестач в банкоматах';
COMMENT ON COLUMN BARS.ATM_REF1.ACC IS 'АСС рахунку 2924/07-08';
COMMENT ON COLUMN BARS.ATM_REF1.REF1 IS 'Реф.виникнення заборгованості';




PROMPT *** Create  constraint XPK_ATMREF1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATM_REF1 ADD CONSTRAINT XPK_ATMREF1 PRIMARY KEY (REF1)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ATMREF1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ATMREF1 ON BARS.ATM_REF1 (REF1) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATM_REF1 ***
grant DELETE,INSERT                                                          on ATM_REF1        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ATM_REF1        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATM_REF1.sql =========*** End *** ====
PROMPT ===================================================================================== 
