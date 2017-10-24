

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RELATIVES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RELATIVES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RELATIVES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RELATIVES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RELATIVES ***
begin 
  execute immediate '
  CREATE TABLE BARS.RELATIVES 
   (	ID NUMBER, 
	RELATIVE VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RELATIVES ***
 exec bpa.alter_policies('RELATIVES');


COMMENT ON TABLE BARS.RELATIVES IS '������� �������';
COMMENT ON COLUMN BARS.RELATIVES.ID IS 'ID';
COMMENT ON COLUMN BARS.RELATIVES.RELATIVE IS '�����';




PROMPT *** Create  constraint CC_REL_RELATIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.RELATIVES MODIFY (RELATIVE CONSTRAINT CC_REL_RELATIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REL_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.RELATIVES MODIFY (ID CONSTRAINT CC_REL_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RELATIVES ***
grant SELECT                                                                 on RELATIVES       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RELATIVES       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RELATIVES.sql =========*** End *** ===
PROMPT ===================================================================================== 
