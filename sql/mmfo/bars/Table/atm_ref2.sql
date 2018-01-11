

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATM_REF2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATM_REF2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATM_REF2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ATM_REF2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATM_REF2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATM_REF2 
   (	REF1 NUMBER, 
	REF2 NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATM_REF2 ***
 exec bpa.alter_policies('ATM_REF2');


COMMENT ON TABLE BARS.ATM_REF2 IS 'Картотека  розыбраних надлишків та нестач в банкоматах';
COMMENT ON COLUMN BARS.ATM_REF2.REF1 IS 'Реф.виникнення заборгованості';
COMMENT ON COLUMN BARS.ATM_REF2.REF2 IS 'Реф.закриття заборгованості';




PROMPT *** Create  constraint XPK_ATMREF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATM_REF2 ADD CONSTRAINT XPK_ATMREF2 PRIMARY KEY (REF1, REF2)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ATMREF2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ATMREF2 ON BARS.ATM_REF2 (REF1, REF2) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATM_REF2 ***
grant SELECT                                                                 on ATM_REF2        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATM_REF2.sql =========*** End *** ====
PROMPT ===================================================================================== 
