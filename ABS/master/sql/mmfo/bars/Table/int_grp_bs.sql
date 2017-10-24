

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_GRP_BS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_GRP_BS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_GRP_BS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT_GRP_BS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INT_GRP_BS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_GRP_BS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_GRP_BS 
   (	IDG NUMBER(*,0), 
	PAP NUMBER(1,0), 
	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_GRP_BS ***
 exec bpa.alter_policies('INT_GRP_BS');


COMMENT ON TABLE BARS.INT_GRP_BS IS '';
COMMENT ON COLUMN BARS.INT_GRP_BS.IDG IS '';
COMMENT ON COLUMN BARS.INT_GRP_BS.PAP IS '';
COMMENT ON COLUMN BARS.INT_GRP_BS.NBS IS '';



PROMPT *** Create  grants  INT_GRP_BS ***
grant SELECT                                                                 on INT_GRP_BS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_GRP_BS      to BARS_DM;
grant SELECT                                                                 on INT_GRP_BS      to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_GRP_BS      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_GRP_BS.sql =========*** End *** ==
PROMPT ===================================================================================== 
