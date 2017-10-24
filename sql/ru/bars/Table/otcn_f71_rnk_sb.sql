

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_F71_RNK_SB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_F71_RNK_SB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_F71_RNK_SB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_F71_RNK_SB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_F71_RNK_SB ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_F71_RNK_SB 
   (	RNK NUMBER, 
	NMK VARCHAR2(70), 
	OKPO VARCHAR2(10), 
	CODCAGENT NUMBER, 
	COUNTRY NUMBER, 
	C_REG NUMBER, 
	VED CHAR(5), 
	PRINS NUMBER, 
	CUSTTYPE NUMBER, 
	CRISK NUMBER, 
	FS CHAR(2), 
	ISE CHAR(5), 
	OSTF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_F71_RNK_SB ***
 exec bpa.alter_policies('OTCN_F71_RNK_SB');


COMMENT ON TABLE BARS.OTCN_F71_RNK_SB IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.NMK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.OKPO IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.CODCAGENT IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.COUNTRY IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.C_REG IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.VED IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.PRINS IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.CRISK IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.FS IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.ISE IS '';
COMMENT ON COLUMN BARS.OTCN_F71_RNK_SB.OSTF IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_F71_RNK_SB.sql =========*** End *
PROMPT ===================================================================================== 
