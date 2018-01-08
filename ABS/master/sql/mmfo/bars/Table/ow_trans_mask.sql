

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_TRANS_MASK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_TRANS_MASK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_TRANS_MASK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_TRANS_MASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_TRANS_MASK 
   (	MASK VARCHAR2(19), 
	COMM VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_TRANS_MASK ***
 exec bpa.alter_policies('OW_TRANS_MASK');


COMMENT ON TABLE BARS.OW_TRANS_MASK IS '';
COMMENT ON COLUMN BARS.OW_TRANS_MASK.MASK IS '';
COMMENT ON COLUMN BARS.OW_TRANS_MASK.COMM IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_TRANS_MASK.sql =========*** End ***
PROMPT ===================================================================================== 
