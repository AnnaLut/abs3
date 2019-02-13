SET DEFINE OFF;
delete from TMP_TTS_REGION where tt = 'RXP' and NLS_TYPE='S3800' and kf='300465';
Insert into BARS.TMP_TTS_REGION
   (TT, NLS_TYPE, KF, NLS_STMT)
 Values
   ('RXP', 'S3800', '300465', '#(nbs_ob22 (''3800'',''22''))');
COMMIT;
