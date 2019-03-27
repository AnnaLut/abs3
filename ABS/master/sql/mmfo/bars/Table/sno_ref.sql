

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SNO_REF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SNO_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SNO_REF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SNO_REF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SNO_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.SNO_REF 
   (	ACC NUMBER, 
	REF NUMBER, 
	ND NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SNO_REF ***
 exec bpa.alter_policies('SNO_REF');


COMMENT ON TABLE BARS.SNO_REF IS '';
COMMENT ON COLUMN BARS.SNO_REF.ACC IS '';
COMMENT ON COLUMN BARS.SNO_REF.REF IS '';
COMMENT ON COLUMN BARS.SNO_REF.ND IS '';




PROMPT *** Create  constraint FK_SNOREF_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SNO_REF ADD CONSTRAINT FK_SNOREF_ACC FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SNO_REF.sql =========*** End *** =====
PROMPT ===================================================================================== 