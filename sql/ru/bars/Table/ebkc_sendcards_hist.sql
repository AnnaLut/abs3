

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EBKC_SENDCARDS_HIST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EBKC_SENDCARDS_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EBKC_SENDCARDS_HIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EBKC_SENDCARDS_HIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EBKC_SENDCARDS_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.EBKC_SENDCARDS_HIST 
   (	RNK NUMBER(38,0), 
	SEND_DATE DATE DEFAULT sysdate
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EBKC_SENDCARDS_HIST ***
 exec bpa.alter_policies('EBKC_SENDCARDS_HIST');


COMMENT ON TABLE BARS.EBKC_SENDCARDS_HIST IS '';
COMMENT ON COLUMN BARS.EBKC_SENDCARDS_HIST.RNK IS '';
COMMENT ON COLUMN BARS.EBKC_SENDCARDS_HIST.SEND_DATE IS '';



PROMPT *** Create  grants  EBKC_SENDCARDS_HIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EBKC_SENDCARDS_HIST to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EBKC_SENDCARDS_HIST.sql =========*** E
PROMPT ===================================================================================== 
