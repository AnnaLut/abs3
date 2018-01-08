

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_SPS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_SPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_SPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_SPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_SPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_SPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_SPS 
   (	SPS NUMBER(38,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_SPS ***
 exec bpa.alter_policies('CC_SPS');


COMMENT ON TABLE BARS.CC_SPS IS '';
COMMENT ON COLUMN BARS.CC_SPS.SPS IS '';
COMMENT ON COLUMN BARS.CC_SPS.NAME IS '';



PROMPT *** Create  grants  CC_SPS ***
grant SELECT                                                                 on CC_SPS          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_SPS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SPS          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SPS          to RCC_DEAL;
grant SELECT                                                                 on CC_SPS          to UPLD;
grant FLASHBACK,SELECT                                                       on CC_SPS          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_SPS.sql =========*** End *** ======
PROMPT ===================================================================================== 
