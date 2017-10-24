

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CONTS.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CONTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CONTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CONTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CONTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CONTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CONTS 
   (	NEK CHAR(4), 
	NUMB CHAR(3), 
	NLS VARCHAR2(15), 
	KV NUMBER(38,0), 
	RNK NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CONTS ***
 exec bpa.alter_policies('CONTS');


COMMENT ON TABLE BARS.CONTS IS '';
COMMENT ON COLUMN BARS.CONTS.NEK IS '';
COMMENT ON COLUMN BARS.CONTS.NUMB IS '';
COMMENT ON COLUMN BARS.CONTS.NLS IS '';
COMMENT ON COLUMN BARS.CONTS.KV IS '';
COMMENT ON COLUMN BARS.CONTS.RNK IS '';



PROMPT *** Create  grants  CONTS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CONTS           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CONTS           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CONTS           to CONTS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CONTS           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CONTS           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CONTS.sql =========*** End *** =======
PROMPT ===================================================================================== 
