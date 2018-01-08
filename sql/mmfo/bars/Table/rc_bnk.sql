

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RC_BNK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RC_BNK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RC_BNK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RC_BNK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RC_BNK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RC_BNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.RC_BNK 
   (	PRIZ VARCHAR2(1), 
	K040 VARCHAR2(3), 
	B010 VARCHAR2(10), 
	TNP VARCHAR2(5), 
	NNP VARCHAR2(40), 
	NAME VARCHAR2(60), 
	SWIFT_CODE VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RC_BNK ***
 exec bpa.alter_policies('RC_BNK');


COMMENT ON TABLE BARS.RC_BNK IS '';
COMMENT ON COLUMN BARS.RC_BNK.PRIZ IS '';
COMMENT ON COLUMN BARS.RC_BNK.K040 IS '';
COMMENT ON COLUMN BARS.RC_BNK.B010 IS '';
COMMENT ON COLUMN BARS.RC_BNK.TNP IS '';
COMMENT ON COLUMN BARS.RC_BNK.NNP IS '';
COMMENT ON COLUMN BARS.RC_BNK.NAME IS '';
COMMENT ON COLUMN BARS.RC_BNK.SWIFT_CODE IS '';



PROMPT *** Create  grants  RC_BNK ***
grant SELECT                                                                 on RC_BNK          to UPLD;



PROMPT *** Create SYNONYM  to RC_BNK ***

  CREATE OR REPLACE PUBLIC SYNONYM RC_BNK FOR BARS.RC_BNK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RC_BNK.sql =========*** End *** ======
PROMPT ===================================================================================== 
