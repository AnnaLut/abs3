

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RC_BNK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RC_BNK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RC_BNK'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RC_BNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.RC_BNK 
   (	PRIZ CHAR(1), 
	K040 CHAR(3), 
	B010 CHAR(10), 
	TNP CHAR(5), 
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
grant DELETE,INSERT,SELECT,UPDATE                                            on RC_BNK          to RC_BNK;
grant SELECT                                                                 on RC_BNK          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RC_BNK.sql =========*** End *** ======
PROMPT ===================================================================================== 
