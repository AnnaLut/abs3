

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EMAIL_TMP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EMAIL_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EMAIL_TMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EMAIL_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EMAIL_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EMAIL_TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.EMAIL_TMP 
   (	NLS VARCHAR2(14), 
	FN VARCHAR2(12), 
	ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EMAIL_TMP ***
 exec bpa.alter_policies('EMAIL_TMP');


COMMENT ON TABLE BARS.EMAIL_TMP IS '';
COMMENT ON COLUMN BARS.EMAIL_TMP.NLS IS '';
COMMENT ON COLUMN BARS.EMAIL_TMP.FN IS '';
COMMENT ON COLUMN BARS.EMAIL_TMP.ID IS '';



PROMPT *** Create  grants  EMAIL_TMP ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EMAIL_TMP       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EMAIL_TMP       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EMAIL_TMP       to START1;
grant FLASHBACK,SELECT                                                       on EMAIL_TMP       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EMAIL_TMP.sql =========*** End *** ===
PROMPT ===================================================================================== 
