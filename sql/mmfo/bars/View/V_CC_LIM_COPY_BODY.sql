CREATE OR REPLACE VIEW V_CC_LIM_COPY_BODY AS
SELECT ID
       ,ND
       ,FDAT
       ,LIM2
       ,ACC
       ,NOT_9129
       ,SUMG
       ,SUMO
       ,OTM
       ,KF
       ,SUMK
       ,NOT_SN
  FROM cc_lim_copy_body t;
