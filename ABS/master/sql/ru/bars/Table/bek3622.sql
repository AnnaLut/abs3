

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BEK3622.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BEK3622 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BEK3622'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BEK3622 ***
begin 
  execute immediate '
  CREATE TABLE BARS.BEK3622 
   (	ACC NUMBER(38,0), 
	TOBO VARCHAR2(100), 
	RNK NUMBER(38,0), 
	C1 NUMBER(38,0), 
	NLS VARCHAR2(15), 
	OKPO VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BEK3622 ***
 exec bpa.alter_policies('BEK3622');


COMMENT ON TABLE BARS.BEK3622 IS '';
COMMENT ON COLUMN BARS.BEK3622.OKPO IS '';
COMMENT ON COLUMN BARS.BEK3622.RNK IS '';
COMMENT ON COLUMN BARS.BEK3622.C1 IS '';
COMMENT ON COLUMN BARS.BEK3622.NLS IS '';
COMMENT ON COLUMN BARS.BEK3622.ACC IS '';
COMMENT ON COLUMN BARS.BEK3622.TOBO IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BEK3622.sql =========*** End *** =====
PROMPT ===================================================================================== 
