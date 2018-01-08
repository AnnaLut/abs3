

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_FOT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_FOT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_FOT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_FOT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_FOT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_FOT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_FOT 
   (	BRANCH VARCHAR2(30), 
	ORG_NAME VARCHAR2(100), 
	ORG_OKPO VARCHAR2(10), 
	DAOS DATE, 
	FS VARCHAR2(2), 
	CARD_TYPE VARCHAR2(100), 
	BPK_COUNT NUMBER(10,0), 
	FOT NUMBER(22,0), 
	KRED NUMBER(22,0), 
	PKRED NUMBER(22,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_FOT ***
 exec bpa.alter_policies('BPK_FOT');


COMMENT ON TABLE BARS.BPK_FOT IS '';
COMMENT ON COLUMN BARS.BPK_FOT.BRANCH IS '';
COMMENT ON COLUMN BARS.BPK_FOT.ORG_NAME IS '';
COMMENT ON COLUMN BARS.BPK_FOT.ORG_OKPO IS '';
COMMENT ON COLUMN BARS.BPK_FOT.DAOS IS '';
COMMENT ON COLUMN BARS.BPK_FOT.FS IS '';
COMMENT ON COLUMN BARS.BPK_FOT.CARD_TYPE IS '';
COMMENT ON COLUMN BARS.BPK_FOT.BPK_COUNT IS '';
COMMENT ON COLUMN BARS.BPK_FOT.FOT IS '';
COMMENT ON COLUMN BARS.BPK_FOT.KRED IS '';
COMMENT ON COLUMN BARS.BPK_FOT.PKRED IS '';



PROMPT *** Create  grants  BPK_FOT ***
grant SELECT                                                                 on BPK_FOT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_FOT         to BARS_DM;
grant SELECT                                                                 on BPK_FOT         to RPBN001;
grant SELECT                                                                 on BPK_FOT         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_FOT.sql =========*** End *** =====
PROMPT ===================================================================================== 
