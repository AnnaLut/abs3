

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_S6_SWIFT_BIC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_S6_SWIFT_BIC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_S6_SWIFT_BIC ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_S6_SWIFT_BIC 
   (	BIC NUMBER(11,0), 
	NLS VARCHAR2(25), 
	GROUP_U NUMBER(11,0), 
	I_VA NUMBER(11,0), 
	BIC_IN VARCHAR2(12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_S6_SWIFT_BIC ***
 exec bpa.alter_policies('S6_S6_SWIFT_BIC');


COMMENT ON TABLE BARS.S6_S6_SWIFT_BIC IS '';
COMMENT ON COLUMN BARS.S6_S6_SWIFT_BIC.BIC IS '';
COMMENT ON COLUMN BARS.S6_S6_SWIFT_BIC.NLS IS '';
COMMENT ON COLUMN BARS.S6_S6_SWIFT_BIC.GROUP_U IS '';
COMMENT ON COLUMN BARS.S6_S6_SWIFT_BIC.I_VA IS '';
COMMENT ON COLUMN BARS.S6_S6_SWIFT_BIC.BIC_IN IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_S6_SWIFT_BIC.sql =========*** End *
PROMPT ===================================================================================== 
