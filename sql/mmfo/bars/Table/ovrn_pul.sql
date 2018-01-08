

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OVRN_PUL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OVRN_PUL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OVRN_PUL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OVRN_PUL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OVRN_PUL ***
begin 
  execute immediate '
  CREATE TABLE BARS.OVRN_PUL 
   (	ID NUMBER, 
	ND NUMBER, 
	ACC8 NUMBER, 
	ACC NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OVRN_PUL ***
 exec bpa.alter_policies('OVRN_PUL');


COMMENT ON TABLE BARS.OVRN_PUL IS '';
COMMENT ON COLUMN BARS.OVRN_PUL.ID IS '';
COMMENT ON COLUMN BARS.OVRN_PUL.ND IS '';
COMMENT ON COLUMN BARS.OVRN_PUL.ACC8 IS '';
COMMENT ON COLUMN BARS.OVRN_PUL.ACC IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OVRN_PUL.sql =========*** End *** ====
PROMPT ===================================================================================== 
