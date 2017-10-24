

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LOM_NAZN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LOM_NAZN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LOM_NAZN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''LOM_NAZN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LOM_NAZN ***
begin 
  execute immediate '
  CREATE TABLE BARS.LOM_NAZN 
   (	ID NUMBER(*,0), 
	NAZN VARCHAR2(160), 
	S NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LOM_NAZN ***
 exec bpa.alter_policies('LOM_NAZN');


COMMENT ON TABLE BARS.LOM_NAZN IS '';
COMMENT ON COLUMN BARS.LOM_NAZN.ID IS '';
COMMENT ON COLUMN BARS.LOM_NAZN.NAZN IS '';
COMMENT ON COLUMN BARS.LOM_NAZN.S IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LOM_NAZN.sql =========*** End *** ====
PROMPT ===================================================================================== 
